package io.github.t3n0v4.lorenpc;

import net.fabricmc.fabric.api.event.lifecycle.v1.ServerTickEvents;

import net.minecraft.nbt.CompoundTag;
import net.minecraft.resources.Identifier;
import net.minecraft.server.MinecraftServer;

public final class RecoveryRequests {

    private static final Identifier RUNTIME =
        Identifier.fromNamespaceAndPath("lorenpc", "runtime");

    private static final Identifier DATABASE =
        Identifier.fromNamespaceAndPath("lorenpc", "db");

    private RecoveryRequests() {}

    public static void register() {
        ServerTickEvents.END_SERVER_TICK.register(
            RecoveryRequests::tick
        );
    }

    private static void tick(MinecraftServer server) {

        CompoundTag runtime =
            server.getCommandStorage().get(RUNTIME).copy();

        CompoundTag request =
            runtime.getCompoundOrEmpty("recovery").copy();

        if (!request.getBooleanOr("pending", false)) {
            return;
        }

        int id = request.getIntOr("id", -1);
        int generation = request.getIntOr("generation", -1);

        String status = validate(server, id, generation);

        // Consumimos el pedido exactamente una vez.
        request.remove("pending");
        request.putString("status", status);

        runtime.put("recovery", request);
        server.getCommandStorage().set(RUNTIME, runtime);

        LoreNPC.LOGGER.info(
            "LoreNPC recovery: NPC {}, resultado {}",
            id,
            status
        );
    }

    private static String validate(
        MinecraftServer server,
        int id,
        int generation
    ) {
        if (id < 1 || id > 1_000_000) {
            return "REJECTED_INVALID_ID";
        }

        if (generation <= 0) {
            return "REJECTED_INVALID_GENERATION";
        }

        CompoundTag database =
            server.getCommandStorage().get(DATABASE);

        CompoundTag npc =
            database.getCompoundOrEmpty("npcs")
                    .getCompoundOrEmpty("n" + id);

        if (npc.isEmpty()) {
            return "REJECTED_NOT_FOUND";
        }

        if (!npc.getBooleanOr("hidden", false)) {
            return "REJECTED_NOT_HIDDEN";
        }

        if (npc.getIntOr("generation", -1) != generation) {
            return "REJECTED_GENERATION_MISMATCH";
        }

        CompoundTag location =
            npc.getCompoundOrEmpty("location");

        if (!location.contains("pos")) {
            return "REJECTED_MISSING_POSITION";
        }

        String dimension =
            location.getString("dimension").orElse("");

        if (dimension.isBlank()) {
            return "REJECTED_MISSING_DIMENSION";
        }

        // La solicitud es valida.
        // Aun no se crean entidades ni se modifica hidden.
        return "VALIDATED_AWAITING_SPAWN";
    }
}