# Detectar clics en los NPC.
execute as @e[type=minecraft:interaction,tag=ln_click,nbt={interaction:{}}] run function lorenpc:internal/dialogo/detectar_click

# Procesar respuestas del chat.
scoreboard players enable @a ln_choice
execute as @a[scores={ln_choice=1..3}] run function lorenpc:internal/dialogo/reply
scoreboard players set @a[scores={ln_choice=1..}] ln_choice 0