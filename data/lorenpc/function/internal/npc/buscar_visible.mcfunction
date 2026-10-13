# LoreNPC - Comprobar entidades cargadas de un NPC.
# Requiere #target ln_id.
# #found = 1 si existe un aldeano o interaction cargado.

scoreboard players set #found ln_id 0

# Aldeanos
execute in minecraft:overworld as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run scoreboard players set #found ln_id 1
execute in minecraft:the_nether as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run scoreboard players set #found ln_id 1
execute in minecraft:the_end as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run scoreboard players set #found ln_id 1

# Zonas de interaccion
execute in minecraft:overworld as @e[type=minecraft:interaction,tag=ln_click] if score @s ln_id = #target ln_id run scoreboard players set #found ln_id 1
execute in minecraft:the_nether as @e[type=minecraft:interaction,tag=ln_click] if score @s ln_id = #target ln_id run scoreboard players set #found ln_id 1
execute in minecraft:the_end as @e[type=minecraft:interaction,tag=ln_click] if score @s ln_id = #target ln_id run scoreboard players set #found ln_id 1