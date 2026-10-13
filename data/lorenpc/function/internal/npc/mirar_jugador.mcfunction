# LoreNPC - Orientar NPC hacia jugadores cercanos
# Solo afecta aldeanos LoreNPC y no modifica su posicion.

execute in minecraft:overworld as @e[type=minecraft:villager,tag=ln_npc] at @s if entity @p[distance=..5] run rotate @s facing entity @p eyes
execute in minecraft:the_nether as @e[type=minecraft:villager,tag=ln_npc] at @s if entity @p[distance=..5] run rotate @s facing entity @p eyes
execute in minecraft:the_end as @e[type=minecraft:villager,tag=ln_npc] at @s if entity @p[distance=..5] run rotate @s facing entity @p eyes