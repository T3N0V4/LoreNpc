# LoreNPC - Comprobar entidades de un ID
# Entrada: #target ln_id
#
# Resultados:
# #villagers ln_id = aldeanos cargados
# #interactions ln_id = zonas de interaccion cargadas
# #duplicate ln_id = 1 cuando hay entidades inesperadas

scoreboard players set #villagers ln_id 0
scoreboard players set #interactions ln_id 0
scoreboard players set #duplicate ln_id 0

# Aldeanos del Overworld
execute in minecraft:overworld as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run scoreboard players add #villagers ln_id 1

# Aldeanos del Nether
execute in minecraft:the_nether as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run scoreboard players add #villagers ln_id 1

# Aldeanos del End
execute in minecraft:the_end as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run scoreboard players add #villagers ln_id 1

# Interacciones del Overworld
execute in minecraft:overworld as @e[type=minecraft:interaction,tag=ln_click] if score @s ln_id = #target ln_id run scoreboard players add #interactions ln_id 1

# Interacciones del Nether
execute in minecraft:the_nether as @e[type=minecraft:interaction,tag=ln_click] if score @s ln_id = #target ln_id run scoreboard players add #interactions ln_id 1

# Interacciones del End
execute in minecraft:the_end as @e[type=minecraft:interaction,tag=ln_click] if score @s ln_id = #target ln_id run scoreboard players add #interactions ln_id 1

# Cualquier entidad cargada existente requiere una revision antes de recuperar.
execute if score #villagers ln_id matches 1.. run scoreboard players set #duplicate ln_id 1
execute if score #interactions ln_id matches 1.. run scoreboard players set #duplicate ln_id 1