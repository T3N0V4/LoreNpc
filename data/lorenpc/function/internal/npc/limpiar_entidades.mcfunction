# Ejecutado cada segundo.

execute in minecraft:overworld as @e[tag=ln_npc,type=minecraft:villager] run function lorenpc:internal/npc/verificar_entidad
execute in minecraft:the_nether as @e[tag=ln_npc,type=minecraft:villager] run function lorenpc:internal/npc/verificar_entidad
execute in minecraft:the_end as @e[tag=ln_npc,type=minecraft:villager] run function lorenpc:internal/npc/verificar_entidad

execute in minecraft:overworld as @e[tag=ln_click,type=minecraft:interaction] run function lorenpc:internal/npc/verificar_entidad
execute in minecraft:the_nether as @e[tag=ln_click,type=minecraft:interaction] run function lorenpc:internal/npc/verificar_entidad
execute in minecraft:the_end as @e[tag=ln_click,type=minecraft:interaction] run function lorenpc:internal/npc/verificar_entidad
