package io.github.t3n0v4.lorenpc.client;

import com.mojang.blaze3d.platform.InputConstants;

import net.fabricmc.api.ClientModInitializer;
import net.fabricmc.fabric.api.client.event.lifecycle.v1.ClientTickEvents;
import net.fabricmc.fabric.api.client.keymapping.v1.KeyMappingHelper;

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

        ClientTickEvents.END_CLIENT_TICK.register(client -> {

            while (OPEN_DIALOG.consumeClick()) {

                if (client.player != null) {

                    client.gui.setScreen(
                        new LoreNPCScreen("El Testigo")
                    );
                }
            }
        });
    }
}