package io.github.t3n0v4.lorenpc.network;

import net.minecraft.network.FriendlyByteBuf;
import net.minecraft.network.codec.ByteBufCodecs;
import net.minecraft.network.codec.StreamCodec;
import net.minecraft.network.protocol.common.custom.CustomPacketPayload;
import net.minecraft.resources.Identifier;

public record OpenRequestPayload(int npcId) implements CustomPacketPayload {

    public static final Type<OpenRequestPayload> TYPE =
        new Type<>(Identifier.fromNamespaceAndPath("lorenpc_ui", "open_request"));

    public static final StreamCodec<FriendlyByteBuf, OpenRequestPayload> CODEC =
        StreamCodec.composite(
            ByteBufCodecs.VAR_INT,
            OpenRequestPayload::npcId,
            OpenRequestPayload::new
        );

    @Override
    public Type<? extends CustomPacketPayload> type() {
        return TYPE;
    }
}