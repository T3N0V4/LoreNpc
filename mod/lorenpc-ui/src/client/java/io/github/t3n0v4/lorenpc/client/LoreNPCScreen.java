package io.github.t3n0v4.lorenpc.client;

import net.minecraft.client.gui.GuiGraphicsExtractor;
import net.minecraft.client.gui.components.Button;
import net.minecraft.client.gui.screens.Screen;
import net.minecraft.client.renderer.RenderPipelines;
import net.minecraft.network.chat.Component;
import net.minecraft.resources.Identifier;

public class LoreNPCScreen extends Screen {

    private static final Identifier PANEL =
        Identifier.fromNamespaceAndPath(
            "lorenpc_ui", "textures/gui/dialog_panel.png"
        );

    private static final Identifier BUTTON =
        Identifier.fromNamespaceAndPath(
            "lorenpc_ui", "textures/gui/dialog_button.png"
        );

    private static final Identifier BUTTON_HOVER =
        Identifier.fromNamespaceAndPath(
            "lorenpc_ui", "textures/gui/dialog_button_hover.png"
        );

    private final String npcName;
    private final String[] questions;
    private final String[] answers;

    private String answer = "Seleccioná una pregunta para comenzar.";

    private int panelX;
    private int panelY;
    private int panelWidth;
    private int panelHeight;

    public LoreNPCScreen(
        String npcName,
        String[] questions,
        String[] answers
    ) {
        super(Component.literal("LoreNPC"));

        this.npcName = npcName;
        this.questions = questions.clone();
        this.answers = answers.clone();
    }

    @Override
    protected void init() {

        panelWidth = Math.min(350, width - 12);
        panelHeight = 288;

        panelX = (width - panelWidth) / 2;
        panelY = (height - panelHeight) / 2;

        int bx = panelX + 36;
        int bw = panelWidth - 72;

        for (int i = 0; i < questions.length; i++) {

            final int selected = i;

            addRenderableWidget(
                Button.builder(
                    Component.empty(),
                    button -> answer = answers[selected]
                )
                .bounds(
                    bx,
                    panelY + 145 + i * 29,
                    bw,
                    26
                )
                .build()
            );
        }

        addRenderableWidget(
            Button.builder(
                Component.empty(),
                button -> onClose()
            )
            .bounds(
                panelX + (panelWidth - 120) / 2,
                panelY + 242,
                120,
                26
            )
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
        // Sin oscurecer el mundo.
    }

    // Dibuja una imagen dividida en nueve regiones.
    // Conserva los bordes y estira solamente el centro.
    private void nineSlice(
        GuiGraphicsExtractor graphics,
        Identifier texture,
        int x,
        int y,
        int w,
        int h,
        int texW,
        int texH,
        int srcBorder,
        int dstBorder
    ) {

        int[] sx = {
            0,
            srcBorder,
            texW - srcBorder
        };

        int[] sy = {
            0,
            srcBorder,
            texH - srcBorder
        };

        int[] sw = {
            srcBorder,
            texW - srcBorder * 2,
            srcBorder
        };

        int[] sh = {
            srcBorder,
            texH - srcBorder * 2,
            srcBorder
        };

        int[] dx = {
            x,
            x + dstBorder,
            x + w - dstBorder
        };

        int[] dy = {
            y,
            y + dstBorder,
            y + h - dstBorder
        };

        int[] dw = {
            dstBorder,
            w - dstBorder * 2,
            dstBorder
        };

        int[] dh = {
            dstBorder,
            h - dstBorder * 2,
            dstBorder
        };

        for (int iy = 0; iy < 3; iy++) {
            for (int ix = 0; ix < 3; ix++) {

                graphics.blit(
                    RenderPipelines.GUI_TEXTURED,
                    texture,
                    dx[ix], dy[iy],
                    sx[ix], sy[iy],
                    dw[ix], dh[iy],
                    sw[ix], sh[iy],
                    texW, texH
                );
            }
        }
    }

    private void drawButton(
        GuiGraphicsExtractor graphics,
        String label,
        int x,
        int y,
        int w,
        int h,
        int mouseX,
        int mouseY
    ) {

        boolean hovered =
            mouseX >= x && mouseX < x + w &&
            mouseY >= y && mouseY < y + h;

        nineSlice(
            graphics,
            hovered ? BUTTON_HOVER : BUTTON,
            x, y, w, h,
            2172, 724,
            180, 9
        );

        int textWidth = font.width(label);

        graphics.text(
            font,
            label,
            x + (w - textWidth) / 2,
            y + (h - 8) / 2,
            hovered ? 0xFFFFE9B6 : 0xFFF2DFC3,
            true
        );
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

        // Marco principal
        nineSlice(
            graphics,
            PANEL,
            x, y,
            panelWidth, panelHeight,
            1254, 1254,
            140, 27
        );

        // Nombre del NPC
        graphics.text(
            font,
            npcName,
            x + 38,
            y + 37,
            0xFFFFDC98,
            true
        );

        graphics.text(
            font,
            "CONVERSACIÓN",
            x + 38,
            y + 52,
            0xFFC5AD89,
            false
        );

        // Zona de respuesta
        graphics.fill(
            x + 33,
            y + 74,
            x + w - 33,
            y + 129,
            0x88302018
        );

        graphics.text(
            font,
            npcName + ":",
            x + 40,
            y + 80,
            0xFFFFD88E,
            true
        );

        graphics.textWithWordWrap(
            font,
            Component.literal(answer),
            x + 40,
            y + 95,
            w - 80,
            0xFFF9E8D0
        );

        // Los botones siguen gestionando los clics.
        super.extractRenderState(
            graphics,
            mouseX,
            mouseY,
            delta
        );

        // Aspecto medieval de las opciones
        for (int i = 0; i < questions.length; i++) {

            drawButton(
                graphics,
                questions[i],
                x + 36,
                y + 145 + i * 29,
                w - 72,
                26,
                mouseX,
                mouseY
            );
        }

        // Despedida
        drawButton(
            graphics,
            "Despedirse",
            x + (w - 120) / 2,
            y + 242,
            120,
            26,
            mouseX,
            mouseY
        );
    }

    @Override
    public void onClose() {
        minecraft.gui.setScreen(null);
    }
}