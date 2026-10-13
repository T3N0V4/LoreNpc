# LoreNPC - Actualizacion principal

# Detectar clic derecho en los NPC.
execute as @e[type=minecraft:interaction,tag=ln_click,nbt={interaction:{}}] run function lorenpc:internal/dialogo/detectar_click

# Limpiar entidades invalidas cada 20 ticks.
scoreboard players add #cleanup ln_id 1
execute if score #cleanup ln_id matches 20.. run function lorenpc:internal/npc/limpiar_entidades
execute if score #cleanup ln_id matches 20.. run scoreboard players set #cleanup ln_id 0

# Girar NPC hacia jugadores cercanos cada 5 ticks.
scoreboard players add #look ln_id 1
execute if score #look ln_id matches 5.. run function lorenpc:internal/npc/mirar_jugador
execute if score #look ln_id matches 5.. run scoreboard players set #look ln_id 0
