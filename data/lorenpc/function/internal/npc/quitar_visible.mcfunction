# Requiere #target ln_id configurado.

execute in minecraft:overworld as @e[tag=ln_npc,type=minecraft:villager] if score @s ln_id = #target ln_id run kill @s
execute in minecraft:the_nether as @e[tag=ln_npc,type=minecraft:villager] if score @s ln_id = #target ln_id run kill @s
execute in minecraft:the_end as @e[tag=ln_npc,type=minecraft:villager] if score @s ln_id = #target ln_id run kill @s

execute in minecraft:overworld as @e[tag=ln_click,type=minecraft:interaction] if score @s ln_id = #target ln_id run kill @s
execute in minecraft:the_nether as @e[tag=ln_click,type=minecraft:interaction] if score @s ln_id = #target ln_id run kill @s
execute in minecraft:the_end as @e[tag=ln_click,type=minecraft:interaction] if score @s ln_id = #target ln_id run kill @s
