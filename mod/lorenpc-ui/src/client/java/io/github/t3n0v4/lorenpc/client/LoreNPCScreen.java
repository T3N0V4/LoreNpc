package io.github.t3n0v4.lorenpc.client;

import net.minecraft.client.gui.GuiGraphicsExtractor;
import net.minecraft.client.gui.components.Button;
import net.minecraft.client.gui.screens.Screen;
import net.minecraft.network.chat.Component;

public class LoreNPCScreen extends Screen {

    private final String npcName;
    private String answer = "Seleccioná una pregunta para comenzar.";

    private static final String[] QUESTIONS = {
        "¿Quién sos?",
        "¿Qué pasó en este lugar?",
        "¿Hay algún peligro?"
    };

    private static final String[] ANSWERS = {
        "Soy El Testigo. Llevo muchos años aquí.",
        "Hace cien años, este pueblo desapareció.",
        "No salgas cuando caiga la noche."
    };

    private int panelX;
    private int panelY;
    private int panelWidth;

    public LoreNPCScreen(String npcName) {
        super(Component.literal("LoreNPC"));
        this.npcName = npcName;
    }

    @Override
    protected void init() {
        panelWidth = Math.min(340, width - 24);
        panelX = (width - panelWidth) / 2;
        panelY = (height - 228) / 2;

        int buttonX = panelX + 20;
        int buttonWidth = panelWidth - 40;

        for (int i = 0; i < QUESTIONS.length; i++) {
            final int selected = i;

            this.addRenderableWidget(
                Button.builder(
                    Component.literal(QUESTIONS[i]),
                    button -> answer = ANSWERS[selected]
                )
                .bounds(buttonX, panelY + 112 + i * 25, buttonWidth, 20)
                .build()
            );
        }

        this.addRenderableWidget(
            Button.builder(
                Component.literal("Despedirse"),
                button -> this.onClose()
            )
            .bounds(panelX + panelWidth - 105, panelY + 195, 85, 20)
            .build()
        );
    }

    @Override
    public boolean isPauseScreen() {
        return false;
    }

    @Override
    public void extractBackground(
        GuiGraphicsExtractor graphics,
        int mouseX,
        int mouseY,
        float delta
    ) {
        // Sin fondo oscuro ni desenfoque a pantalla completa.
    }

    @Override
    public void extractRenderState(
        GuiGraphicsExtractor graphics,
        int mouseX,
        int mouseY,
        float delta
    ) {
        int x = panelX;
        int y = panelY;
        int w = panelWidth;

        // Sombra
        graphics.fill(x + 4, y + 4, x + w + 4, y + 228,
            0x66000000);

        // Panel semitransparente
        graphics.fill(x, y, x + w, y + 224,
            0xDD171C20);

        // Borde superior
        graphics.fill(x, y, x + w, y + 2,
            0xFFB9A06A);

        // Encabezado
        graphics.text(
            this.font,
            npcName,
            x + 20,
            y + 17,
            0xFFE8D4A4,
            true
        );

        graphics.text(
            this.font,
            "DIÁLOGO",
            x + 20,
            y + 33,
            0xFF929D96,
            false
        );

        // Separador
        graphics.fill(x + 20, y + 49, x + w - 20, y + 50,
            0xFF50544E);

        // Zona de respuesta
        graphics.fill(x + 16, y + 58, x + w - 16, y + 98,
            0xAA30383A);

        graphics.text(
            this.font,
            npcName + ":",
            x + 23,
            y + 64,
            0xFFD4BF88,
            true
        );

        graphics.text(
            this.font,
            answer,
            x + 23,
            y + 79,
            0xFFFFFFFF,
            false
        );

        graphics.text(
            this.font,
            "PREGUNTAR",
            x + 20,
            y + 101,
            0xFFB5C2B4,
            false
        );

        super.extractRenderState(graphics, mouseX, mouseY, delta);
    }

    @Override
    public void onClose() {
        this.minecraft.gui.setScreen(null);
    }
}