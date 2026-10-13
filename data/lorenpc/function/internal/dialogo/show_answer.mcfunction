# Ejecutado como el jugador que selecciono una pregunta.

execute store result storage lorenpc:runtime args.id int 1 run scoreboard players get @s ln_active

scoreboard players operation #slot ln_id = @s ln_choice
scoreboard players remove #slot ln_id 1

execute store result storage lorenpc:runtime args.slot int 1 run scoreboard players get #slot ln_id

function lorenpc:internal/dialogo/show_answer_macro with storage lorenpc:runtime args
