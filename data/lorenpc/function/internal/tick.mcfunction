# Detectar clic derecho en NPC.
execute as @e[type=minecraft:interaction,tag=ln_click,nbt={interaction:{}}] run function lorenpc:internal/dialogo/detectar_click

# Habilitar controles de dialogo.
scoreboard players enable @a ln_choice
scoreboard players enable @a ln_nav

# Mostrar respuesta correspondiente al jugador.
execute as @a[scores={ln_choice=1..3}] run function lorenpc:internal/dialogo/show_answer
scoreboard players set @a[scores={ln_choice=1..}] ln_choice 0

# Regresar al menu de preguntas.
execute as @a[scores={ln_nav=1..}] run function lorenpc:internal/dialogo/open
scoreboard players set @a[scores={ln_nav=1..}] ln_nav 0

# Limpieza de entidades cada segundo.
scoreboard players add #cleanup ln_id 1
execute if score #cleanup ln_id matches 20.. run function lorenpc:internal/npc/limpiar_entidades
execute if score #cleanup ln_id matches 20.. run scoreboard players set #cleanup ln_id 0

# Girar NPC hacia jugadores cercanos.
scoreboard players add #look ln_id 1
execute if score #look ln_id matches 5.. run function lorenpc:internal/npc/mirar_jugador
execute if score #look ln_id matches 5.. run scoreboard players set #look ln_id 0
