package io.github.t3n0v4.lorenpc.client;

import net.minecraft.client.gui.GuiGraphicsExtractor;
import net.minecraft.client.gui.components.Button;
import net.minecraft.client.gui.screens.Screen;
import net.minecraft.client.renderer.RenderPipelines;
import net.minecraft.network.chat.Component;
import net.minecraft.network.chat.FontDescription;
import net.minecraft.resources.Identifier;
import java.util.ArrayList;
import java.util.List;

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

    private static final Identifier MEDIEVAL = Identifier.fromNamespaceAndPath("lorenpc_ui", "medieval");

    private Component oldScript(String value) {
        return Component.literal(value).withStyle(s -> s.withFont(new FontDescription.Resource(MEDIEVAL)));
    }

    private String visibleLabel(String value, int maxWidth) {
        if (font.width(oldScript(value)) <= maxWidth) return value;
        int n = value.length();
        while (n > 0 && font.width(oldScript(value.substring(0, n) + "...")) > maxWidth) n--;
        return value.substring(0, n) + "...";
    }
    private final String npcName;
    private final String[] questions;
    private final String[] answers;

    private String answer = "Seleccioná una pregunta para comenzar.";

    private int answerPage = 0;
    private static final int LINES_PER_PAGE = 3;

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
                    button -> { answer = answers[selected]; answerPage = 0; }
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
                button -> {
                    int total = wrapAnswer(answer, panelWidth - 80).size();
                    int pages = Math.max(1,
                        (total + LINES_PER_PAGE - 1) / LINES_PER_PAGE);
                    answerPage = (answerPage + 1) % pages;
                }
            )
            .bounds(panelX + panelWidth - 115, panelY + 124, 85, 18)
            .build()
        );

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

        // Resaltado sutil, como una ranura iluminada.
        if (hovered) {
            graphics.fill(
                x + 4, y + 2,
                x + w - 4, y + h - 2,
                0x443D2812
            );
        }

        // Linea inferior grabada.
        graphics.fill(
            x + 12, y + h - 2,
            x + w - 12, y + h - 1,
            hovered ? 0xFFBE9756 : 0x66583E25
        );

        // Texto centrado sobre el pergamino.
        label = visibleLabel(label, w - 25);
        int textWidth = font.width(oldScript(label));

        graphics.text(
            font,
            oldScript(label),
            x + (w - textWidth) / 2,
            y + (h - 8) / 2,
            hovered ? 0xFFFFE3A6 : 0xFFE5C99A,
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
            oldScript(visibleLabel(npcName, w - 76)),
            x + (w - font.width(oldScript(visibleLabel(npcName, w - 76)))) / 2,
            y + 39,
            0xFFFFDC98,
            true
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
            oldScript(visibleLabel(npcName + ":", w - 80)),
            x + 40,
            y + 75,
            0xFFFFD88E,
            true
        );

        drawAnswerPages(graphics, x + 40, y + 95, w - 80);

        // Los widgets mantienen los clics, pero no dibujamos su aspecto vanilla.

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


    private List<String> wrapAnswer(String text, int maxWidth) {
        List<String> lines = new ArrayList<>();

        for (String paragraph : text.split("\n", -1)) {
            StringBuilder line = new StringBuilder();

            for (String word : paragraph.split(" ")) {
                if (word.isEmpty()) continue;

                String candidate = line.isEmpty()
                    ? word
                    : line + " " + word;

                if (font.width(oldScript(candidate)) > maxWidth && !line.isEmpty()) {
                    lines.add(line.toString());
                    line.setLength(0);
                }

                if (font.width(oldScript(word)) > maxWidth) {
                    for (char c : word.toCharArray()) {
                        if (!line.isEmpty() &&
                            font.width(oldScript(line.toString() + c)) > maxWidth) {
                            lines.add(line.toString());
                            line.setLength(0);
                        }
                        line.append(c);
                    }
                } else {
                    if (!line.isEmpty()) line.append(' ');
                    line.append(word);
                }
            }

            lines.add(line.toString());
        }

        return lines;
    }

    private void drawAnswerPages(
        GuiGraphicsExtractor graphics,
        int x,
        int y,
        int maxWidth
    ) {
        List<String> lines = wrapAnswer(answer, maxWidth);

        int pageCount = Math.max(1,
            (lines.size() + LINES_PER_PAGE - 1) / LINES_PER_PAGE);

        answerPage = Math.min(answerPage, pageCount - 1);

        int start = answerPage * LINES_PER_PAGE;
        int end = Math.min(start + LINES_PER_PAGE, lines.size());

        for (int i = start; i < end; i++) {
            graphics.text(
                font,
                oldScript(lines.get(i)),
                x,
                y + (i - start) * 11,
                0xFFF2DFC3,
                true
            );
        }

        if (pageCount > 1) {
            String nextLabel = answerPage + 1 < pageCount
                ? "Siguiente >"
                : "Volver al inicio";

            int buttonX = panelX + panelWidth - 115;
            int buttonY = panelY + 124;

            graphics.text(
                font,
                oldScript(nextLabel + " (" + (answerPage + 1) + "/" + pageCount + ")"),
                buttonX,
                buttonY + 4,
                0xFFE7BF79,
                true
            );
        }
    }
    @Override
    public void onClose() {
        minecraft.gui.setScreen(null);
    }
}