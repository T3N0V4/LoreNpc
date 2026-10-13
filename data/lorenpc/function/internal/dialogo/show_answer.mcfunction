execute store result storage lorenpc:runtime args.id int 1 run scoreboard players get @s ln_active
execute store result storage lorenpc:runtime args.slot int 1 run scoreboard players get @s ln_choice
function lorenpc:internal/dialogo/show_answer_macro with storage lorenpc:runtime args
