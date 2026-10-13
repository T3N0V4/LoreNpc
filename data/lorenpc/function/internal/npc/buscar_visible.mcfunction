# Requiere #target ln_id configurado.
# Resultado: #found ln_id = 1 si el NPC esta cargado.

scoreboard players set #found ln_id 0

execute in minecraft:overworld as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run scoreboard players set #found ln_id 1
execute in minecraft:the_nether as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run scoreboard players set #found ln_id 1
execute in minecraft:the_end as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run scoreboard players set #found ln_id 1
