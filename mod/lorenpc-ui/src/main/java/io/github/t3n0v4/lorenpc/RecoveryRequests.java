package io.github.t3n0v4.lorenpc;

import net.fabricmc.fabric.api.event.lifecycle.v1.ServerTickEvents;
import net.minecraft.core.BlockPos;
import net.minecraft.core.registries.Registries;
import net.minecraft.nbt.CompoundTag;
import net.minecraft.nbt.ListTag;
import net.minecraft.resources.Identifier;
import net.minecraft.resources.ResourceKey;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.world.level.Level;
import net.minecraft.world.phys.Vec3;

public final class RecoveryRequests {
    private static final Identifier RUNTIME = Identifier.fromNamespaceAndPath("lorenpc", "runtime");
    private static final Identifier DATABASE = Identifier.fromNamespaceAndPath("lorenpc", "db");
    private RecoveryRequests() {}

    public static void register() {
        ServerTickEvents.END_SERVER_TICK.register(RecoveryRequests::tick);
    }

    private static void tick(MinecraftServer server) {
        CompoundTag runtime = server.getCommandStorage().get(RUNTIME).copy();
        CompoundTag request = runtime.getCompoundOrEmpty("recovery").copy();
        if (!request.getBooleanOr("pending", false)) return;
        int id = request.getIntOr("id", -1);
        int generation = request.getIntOr("generation", -1);
        String result;
        try { result = recover(server, id, generation); }
        catch (Exception e) {
            LoreNPC.LOGGER.error("Error al recuperar NPC {}", id, e);
            result = "ERROR_EXCEPTION";
        }
        // Volver a leer: spawn_args pudo modificarse durante la recuperacion.
        runtime = server.getCommandStorage().get(RUNTIME).copy();
        request = runtime.getCompoundOrEmpty("recovery").copy();
        request.remove("pending");
        request.putString("status", result);
        runtime.put("recovery", request);
        server.getCommandStorage().set(RUNTIME, runtime);
        LoreNPC.LOGGER.info("Recuperacion NPC {}: {}", id, result);
    }

    private static void command(MinecraftServer server, ServerLevel level, Vec3 position, String cmd) {
        server.getCommands().performPrefixedCommand(
            server.createCommandSourceStack().withLevel(level).withPosition(position), cmd);
    }

    // En 26.3 performPrefixedCommand devuelve void. Para saber si un
    // comando tuvo exito, usamos execute store success en command storage.
    private static boolean check(MinecraftServer server, ServerLevel level, Vec3 position, String condition) {
        command(server, level, position,
            "execute store success storage lorenpc:runtime recovery_check byte 1 run " + condition);
        return server.getCommandStorage().get(RUNTIME).getBooleanOr("recovery_check", false);
    }

    private static String recover(MinecraftServer server, int id, int generation) {
        if (id < 1 || id > 1_000_000) return "REJECTED_ID";
        if (generation <= 0) return "REJECTED_GENERATION";
        CompoundTag db = server.getCommandStorage().get(DATABASE).copy();
        CompoundTag npcs = db.getCompoundOrEmpty("npcs");
        CompoundTag npc = npcs.getCompoundOrEmpty("n" + id);
        if (npc.isEmpty()) return "REJECTED_NOT_FOUND";
        if (!npc.getBooleanOr("hidden", false)) return "REJECTED_NOT_HIDDEN";
        if (npc.getIntOr("generation", -1) != generation) return "REJECTED_GENERATION_MISMATCH";
        CompoundTag location = npc.getCompoundOrEmpty("location");
        ListTag p = location.getListOrEmpty("pos");
        if (p.size() != 3) return "REJECTED_POSITION";
        double x = p.getDoubleOr(0, Double.NaN);
        double y = p.getDoubleOr(1, Double.NaN);
        double z = p.getDoubleOr(2, Double.NaN);
        if (!Double.isFinite(x) || !Double.isFinite(y) || !Double.isFinite(z) ||
            Math.abs(x) > 29999984 || Math.abs(z) > 29999984 || Math.abs(y) > 2048)
            return "REJECTED_POSITION";
        Identifier dimension;
        try { dimension = Identifier.parse(location.getString("dimension").orElse("")); }
        catch (Exception e) { return "REJECTED_DIMENSION"; }
        ServerLevel level = server.getLevel(ResourceKey.create(Registries.DIMENSION, dimension));
        if (level == null) return "REJECTED_DIMENSION_NOT_FOUND";
        if (!level.hasChunkAt(BlockPos.containing(x, y, z))) return "REJECTED_CHUNK_NOT_LOADED";
        Vec3 pos = new Vec3(x, y, z);

        // Comprobar presencia solo mediante comandos vanilla: NO usar getTags/getCommandTags/EntityType.
        if (check(server, level, pos, "execute if entity @e[type=minecraft:villager,tag=ln_npc,distance=..2,limit=1]") ||
            check(server, level, pos, "execute if entity @e[type=minecraft:interaction,tag=ln_click,distance=..2,limit=1]"))
            return "REJECTED_EXISTING_ENTITY";

        CompoundTag runtime = server.getCommandStorage().get(RUNTIME).copy();
        CompoundTag args = new CompoundTag();
        args.putInt("id", id);
        args.putInt("generation", generation);
        args.putString("nombre", npc.getString("nombre").orElse("NPC"));
        runtime.put("spawn_args", args);
        server.getCommandStorage().set(RUNTIME, runtime);
        command(server, level, pos, "function lorenpc:internal/npc/spawn with storage lorenpc:runtime spawn_args");

        // Verificar que se generaron las DOS entidades con ID y generacion correctos.
        String verifyVillager = "execute as @e[type=minecraft:villager,tag=ln_npc,distance=..2] if score @s ln_id matches " + id + " if score @s ln_gen matches " + generation;
        String verifyInteraction = "execute as @e[type=minecraft:interaction,tag=ln_click,distance=..2] if score @s ln_id matches " + id + " if score @s ln_gen matches " + generation;
        if (!check(server, level, pos, verifyVillager) ||
            !check(server, level, pos, verifyInteraction))
            return "ERROR_SPAWN_INCOMPLETE";

        npc.putBoolean("hidden", false);
        npcs.put("n" + id, npc);
        db.put("npcs", npcs);
        server.getCommandStorage().set(DATABASE, db);
        return "RECOVERED";
    }
}