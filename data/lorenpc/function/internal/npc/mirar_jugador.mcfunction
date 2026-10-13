# LoreNPC - Mirar al jugador cercano
# Solo girar horizontalmente. Inclinacion vertical fija: 0 grados.

execute in minecraft:overworld as @e[type=minecraft:villager,tag=ln_npc] at @s if entity @p[distance=..5] facing entity @p eyes rotated ~ 0 run tp @s ~ ~ ~ ~ ~
execute in minecraft:the_nether as @e[type=minecraft:villager,tag=ln_npc] at @s if entity @p[distance=..5] facing entity @p eyes rotated ~ 0 run tp @s ~ ~ ~ ~ ~
execute in minecraft:the_end as @e[type=minecraft:villager,tag=ln_npc] at @s if entity @p[distance=..5] facing entity @p eyes rotated ~ 0 run tp @s ~ ~ ~ ~ ~