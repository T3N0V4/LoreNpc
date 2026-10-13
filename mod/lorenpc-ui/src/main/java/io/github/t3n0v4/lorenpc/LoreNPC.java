package io.github.t3n0v4.lorenpc;

import io.github.t3n0v4.lorenpc.network.OpenRequestPayload;
import io.github.t3n0v4.lorenpc.network.OpenResponsePayload;
import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.networking.v1.PayloadTypeRegistry;
import net.fabricmc.fabric.api.networking.v1.ServerPlayNetworking;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoreNPC implements ModInitializer {

    public static final String MOD_ID = "lorenpc_ui";
    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

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
                // Prueba de comunicacion. Luego consultaremos lorenpc:db.
                ServerPlayNetworking.send(
                    context.player(),
                    new OpenResponsePayload("NPC desde servidor")
                );
            }
        );

        LOGGER.info("LoreNPC UI: puente de red registrado.");
    }
}