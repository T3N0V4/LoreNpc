package io.github.t3n0v4.lorenpc.client;

import com.google.gson.JsonParser;


import io.github.t3n0v4.lorenpc.network.OpenResponsePayload;

import net.fabricmc.api.ClientModInitializer;


import net.fabricmc.fabric.api.client.networking.v1.ClientPlayNetworking;




public class LoreNPCClient implements ClientModInitializer {
@Override
    public void onInitializeClient() {

        ClientPlayNetworking.registerGlobalReceiver(
            OpenResponsePayload.TYPE,
            (payload, context) -> {
                context.client().execute(() ->
                    context.client().gui.setScreen(
                        new LoreNPCScreen(
                            payload.npcName(),
                            leerOpciones(payload.dialogueJson(), "pregunta"),
                            leerOpciones(payload.dialogueJson(), "respuesta")
                        )
                    )
                );
            }
        );
    }

    private static String[] leerOpciones(String json, String campo) {
        var arreglo = JsonParser.parseString(json).getAsJsonArray();
        String[] opciones = new String[arreglo.size()];

        for (int i = 0; i < arreglo.size(); i++) {
            opciones[i] = arreglo.get(i)
                .getAsJsonObject()
                .get(campo)
                .getAsString();
        }

        return opciones;
    }
}