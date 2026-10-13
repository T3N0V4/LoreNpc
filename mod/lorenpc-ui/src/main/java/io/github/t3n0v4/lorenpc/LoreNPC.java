package io.github.t3n0v4.lorenpc;

import net.fabricmc.api.ModInitializer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoreNPC implements ModInitializer {

    public static final String MOD_ID = "lorenpc_ui";
    public static final Logger LOGGER =
            LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitialize() {
        LOGGER.info("LoreNPC UI iniciado.");
    }
}
