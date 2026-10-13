package io.github.t3n0v4.lorenpc;

import io.github.t3n0v4.lorenpc.network.OpenRequestPayload;
import io.github.t3n0v4.lorenpc.network.OpenResponsePayload;

import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.networking.v1.PayloadTypeRegistry;
import net.fabricmc.fabric.api.networking.v1.ServerPlayNetworking;

import net.minecraft.nbt.CompoundTag;
import net.minecraft.resources.Identifier;

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

        ServerPlayNetworking.registerGlobalReceiver(
            OpenRequestPayload.TYPE,
            (payload, context) -> {

                context.server().execute(() -> {

                    int npcId = payload.npcId();
                    LOGGER.info("LoreNPC DEBUG: recibida solicitud del NPC {}", npcId);

                    // Solo aceptamos IDs validos.
                    if (npcId < 1 || npcId > 1000000) {
                        return;
                    }

                    // Leer storage lorenpc:db
                    CompoundTag database =
                        context.server()
                            .getCommandStorage()
                            .get(NPC_STORAGE);

                    // Estructura: npcs.n1.nombre
                    CompoundTag npcs =
                        database.getCompoundOrEmpty("npcs");

                    CompoundTag npc =
                        npcs.getCompoundOrEmpty("n" + npcId);

                    // Si no existe, no abrimos la ventana.
                    if (npc.isEmpty()) {
                        LOGGER.warn(
                            "No se encontro el NPC con ID {}",
                            npcId
                        );
                        return;
                    }

                    String nombre =
                        npc.getString("nombre").orElse("NPC");

                    ServerPlayNetworking.send(
                        context.player(),
                        new OpenResponsePayload(nombre)
                    );

                    LOGGER.info(
                        "LoreNPC: enviado NPC {} ({})",
                        npcId,
                        nombre
                    );
                });
            }
        );

        LOGGER.info("LoreNPC UI: conexion con datapack preparada.");
    }
}