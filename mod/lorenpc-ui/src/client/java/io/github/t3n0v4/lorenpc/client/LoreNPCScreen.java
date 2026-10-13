package io.github.t3n0v4.lorenpc.client;

import net.minecraft.client.gui.GuiGraphicsExtractor;
import net.minecraft.client.gui.components.Button;
import net.minecraft.client.gui.screens.Screen;
import net.minecraft.network.chat.Component;
import net.minecraft.resources.Identifier;
import net.minecraft.client.renderer.RenderPipelines;

public class LoreNPCScreen extends Screen {

    private final String npcName;
    private String answer = "Seleccioná una pregunta para comenzar.";

    private final String[] questions;
    private final String[] answers;
    private static final Identifier DIALOG_PANEL_TEXTURE =
        Identifier.fromNamespaceAndPath(
            "lorenpc_ui", "textures/gui/dialog_panel.png");

    private static final Identifier DIALOG_BUTTON_TEXTURE =
        Identifier.fromNamespaceAndPath(
            "lorenpc_ui", "textures/gui/dialog_button.png");

    private static final Identifier DIALOG_BUTTON_HOVER_TEXTURE =
        Identifier.fromNamespaceAndPath(
            "lorenpc_ui", "textures/gui/dialog_button_hover.png");
    private int panelX;
    private int panelY;
    private int panelWidth;

    public LoreNPCScreen(String npcName, String[] questions, String[] answers) {
        super(Component.literal("LoreNPC"));
        this.npcName = npcName;
        this.questions = questions.clone();
        this.answers = answers.clone();
    }

    @Override
    protected void init() {
        panelWidth = Math.min(340, width - 24);
        panelX = (width - panelWidth) / 2;
        panelY = (height - 228) / 2;

        int buttonX = panelX + 20;
        int buttonWidth = panelWidth - 40;

        for (int i = 0; i < questions.length; i++) {
            final int selected = i;

            this.addRenderableWidget(
                Button.builder(
                    Component.literal(questions[i]),
                    button -> answer = answers[selected]
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

        // Marco medieval
        graphics.blit(
            RenderPipelines.GUI_TEXTURED,
            DIALOG_PANEL_TEXTURE,
            x, y,
            0, 0,
            w, 224,
            1254, 1254
        );

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

        int buttonX = x + 20;
        int buttonWidth = w - 40;

        for (int i = 0; i < questions.length; i++) {
            int by = y + 112 + i * 25;

            boolean hovered =
                mouseX >= buttonX &&
                mouseX < buttonX + buttonWidth &&
                mouseY >= by &&
                mouseY < by + 20;

            Identifier texture = hovered
                ? DIALOG_BUTTON_HOVER_TEXTURE
                : DIALOG_BUTTON_TEXTURE;

            graphics.blit(
                RenderPipelines.GUI_TEXTURED,
                texture,
                buttonX, by,
                0, 0,
                buttonWidth, 20,
                2172, 724
            );

            int textWidth = this.font.width(questions[i]);

            graphics.text(
                this.font,
                questions[i],
                buttonX + (buttonWidth - textWidth) / 2,
                by + 6,
                hovered ? 0xFFFFE7AA : 0xFFF3DEC1,
                true
            );
        }

        int exitX = x + w - 105;
        int exitY = y + 195;

        boolean exitHovered =
            mouseX >= exitX &&
            mouseX < exitX + 85 &&
            mouseY >= exitY &&
            mouseY < exitY + 20;

        graphics.blit(
            RenderPipelines.GUI_TEXTURED,
            exitHovered
                ? DIALOG_BUTTON_HOVER_TEXTURE
                : DIALOG_BUTTON_TEXTURE,
            exitX, exitY,
            0, 0,
            85, 20,
            2172, 724
        );

        graphics.text(
            this.font,
            "Despedirse",
            exitX + (85 - this.font.width("Despedirse")) / 2,
            exitY + 6,
            0xFFF3DEC1,
            true
        );
    }

    @Override
    public void onClose() {
        this.minecraft.gui.setScreen(null);
    }
}