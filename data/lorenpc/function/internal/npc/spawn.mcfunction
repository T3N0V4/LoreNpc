# Crea el aldeano y su zona de interacción.
# Se ejecuta en la posición del administrador.
# Recibe id y nombre mediante macros.

execute summon minecraft:villager run function lorenpc:internal/npc/config_villager with storage lorenpc:runtime spawn_args
execute summon minecraft:interaction run function lorenpc:internal/npc/config_interaction with storage lorenpc:runtime spawn_args
