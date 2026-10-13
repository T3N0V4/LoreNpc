package io.github.t3n0v4.lorenpc.network;

import net.minecraft.network.FriendlyByteBuf;
import net.minecraft.network.codec.ByteBufCodecs;
import net.minecraft.network.codec.StreamCodec;
import net.minecraft.network.protocol.common.custom.CustomPacketPayload;
import net.minecraft.resources.Identifier;

public record OpenResponsePayload(
    String npcName,
    String dialogueJson
) implements CustomPacketPayload {

    public static final Type<OpenResponsePayload> TYPE =
        new Type<>(Identifier.fromNamespaceAndPath("lorenpc_ui", "open_response"));

    public static final StreamCodec<FriendlyByteBuf, OpenResponsePayload> CODEC =
        StreamCodec.composite(
            ByteBufCodecs.STRING_UTF8, OpenResponsePayload::npcName,
            ByteBufCodecs.STRING_UTF8, OpenResponsePayload::dialogueJson,
            OpenResponsePayload::new
        );

    @Override
    public Type<? extends CustomPacketPayload> type() {
        return TYPE;
    }
}