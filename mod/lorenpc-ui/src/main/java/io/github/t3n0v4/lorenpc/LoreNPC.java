package io.github.t3n0v4.lorenpc;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import io.github.t3n0v4.lorenpc.network.OpenRequestPayload;
import io.github.t3n0v4.lorenpc.network.OpenResponsePayload;

import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerTickEvents;
import net.fabricmc.fabric.api.networking.v1.PayloadTypeRegistry;
import net.fabricmc.fabric.api.networking.v1.ServerPlayNetworking;

import net.minecraft.nbt.CompoundTag;
import net.minecraft.resources.Identifier;
import net.minecraft.server.MinecraftServer;
import net.minecraft.server.level.ServerPlayer;
import net.minecraft.world.scores.Objective;
import net.minecraft.world.scores.Scoreboard;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoreNPC implements ModInitializer {

    public static final String MOD_ID = "lorenpc_ui";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    private static final Identifier NPC_STORAGE =
        Identifier.fromNamespaceAndPath("lorenpc", "db");

    @Override
    public void onInitialize() {

        PayloadTypeRegistry.serverboundPlay().register(
            OpenRequestPayload.TYPE,
            OpenRequestPayload.CODEC
        );

        PayloadTypeRegistry.clientboundPlay().register(
            OpenResponsePayload.TYPE,
            OpenResponsePayload.CODEC
        );

        // Tecla J: sigue disponible para depuracion.
        ServerPlayNetworking.registerGlobalReceiver(
            OpenRequestPayload.TYPE,
            (payload, context) -> {
                context.server().execute(() ->
                    enviarDialogo(
                        context.server(),
                        context.player(),
                        payload.npcId()
                    )
                );
            }
        );

        // Clic derecho detectado por el datapack.
        ServerTickEvents.END_SERVER_TICK.register(
            LoreNPC::revisarClicks
        );

        LOGGER.info("LoreNPC UI: detector de clic registrado.");
    }

    private static void revisarClicks(MinecraftServer server) {

        Scoreboard scoreboard = server.getScoreboard();

        Objective openObjective = scoreboard.getObjective("ln_open");
        Objective activeObjective = scoreboard.getObjective("ln_active");

        // El datapack podria no estar instalado.
        if (openObjective == null || activeObjective == null) {
            return;
        }

        for (ServerPlayer player : server.getPlayerList().getPlayers()) {

            var openScore =
                scoreboard.getPlayerScoreInfo(player, openObjective);

            if (openScore == null || openScore.value() != 1) {
                continue;
            }

            // Consumir la señal antes de abrir el dialogo.
            scoreboard.getOrCreatePlayerScore(
                player, openObjective
            ).set(0);

            var activeScore =
                scoreboard.getPlayerScoreInfo(player, activeObjective);

            if (activeScore == null) {
                continue;
            }

            int npcId = activeScore.value();

            LOGGER.info(
                "LoreNPC: clic derecho de {} sobre NPC {}",
                player.getName().getString(),
                npcId
            );

            enviarDialogo(server, player, npcId);
        }
    }

    private static void enviarDialogo(
        MinecraftServer server,
        ServerPlayer player,
        int npcId
    ) {

        if (npcId < 1 || npcId > 1000000) {
            return;
        }

        CompoundTag database =
            server.getCommandStorage().get(NPC_STORAGE);

        CompoundTag npcs =
            database.getCompoundOrEmpty("npcs");

        CompoundTag npc =
            npcs.getCompoundOrEmpty("n" + npcId);

        if (npc.isEmpty()) {
            LOGGER.warn("LoreNPC: NPC {} no existe.", npcId);
            return;
        }

        String nombre = npc.getString("nombre").orElse("NPC");
        String preguntas = crearDialogoJson(npc);

        if (!ServerPlayNetworking.canSend(
            player, OpenResponsePayload.TYPE
        )) {
            LOGGER.warn(
                "LoreNPC: el cliente de {} no tiene LoreNPC UI.",
                player.getName().getString()
            );
            return;
        }

        ServerPlayNetworking.send(
            player,
            new OpenResponsePayload(nombre, preguntas)
        );

        LOGGER.info(
            "LoreNPC: enviado dialogo del NPC {} ({})",
            npcId,
            nombre
        );
    }

    private static String crearDialogoJson(CompoundTag npc) {

        JsonArray preguntas = new JsonArray();

        CompoundTag slots =
            npc.getCompoundOrEmpty("questions");

        for (int i = 0; i < 3; i++) {

            CompoundTag slot =
                slots.getCompoundOrEmpty("n" + i);

            String pregunta =
                slot.getString("q").orElse("");

            String respuesta =
                slot.getString("a").orElse("");

            if (pregunta.isBlank()) {
                continue;
            }

            JsonObject opcion = new JsonObject();

            opcion.addProperty("slot", i);
            opcion.addProperty("pregunta", pregunta);
            opcion.addProperty("respuesta", respuesta);

            preguntas.add(opcion);
        }

        return preguntas.toString();
    }
}