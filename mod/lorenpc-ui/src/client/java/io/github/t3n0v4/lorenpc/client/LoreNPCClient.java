package io.github.t3n0v4.lorenpc.client;

import com.mojang.blaze3d.platform.InputConstants;
import io.github.t3n0v4.lorenpc.network.OpenRequestPayload;
import io.github.t3n0v4.lorenpc.network.OpenResponsePayload;

import net.fabricmc.api.ClientModInitializer;
import net.fabricmc.fabric.api.client.event.lifecycle.v1.ClientTickEvents;
import net.fabricmc.fabric.api.client.keymapping.v1.KeyMappingHelper;
import net.fabricmc.fabric.api.client.networking.v1.ClientPlayNetworking;

import net.minecraft.client.KeyMapping;
import net.minecraft.resources.Identifier;

public class LoreNPCClient implements ClientModInitializer {

    private static final KeyMapping.Category CATEGORY =
        KeyMapping.Category.register(
            Identifier.fromNamespaceAndPath("lorenpc_ui", "controls")
        );

    private static final KeyMapping OPEN_DIALOG =
        KeyMappingHelper.registerKeyMapping(
            new KeyMapping(
                "key.lorenpc_ui.open",
                InputConstants.Type.KEYBOARD,
                InputConstants.KEY_J,
                CATEGORY
            )
        );

    @Override
    public void onInitializeClient() {

        ClientPlayNetworking.registerGlobalReceiver(
            OpenResponsePayload.TYPE,
            (payload, context) -> {
                context.client().execute(() ->
                    context.client().gui.setScreen(
                        new LoreNPCScreen(payload.npcName())
                    )
                );
            }
        );

        ClientTickEvents.END_CLIENT_TICK.register(client -> {
            while (OPEN_DIALOG.consumeClick()) {
                if (client.player != null &&
                    ClientPlayNetworking.canSend(OpenRequestPayload.TYPE)) {

                    ClientPlayNetworking.send(new OpenRequestPayload(0));
                }
            }
        });
    }
}