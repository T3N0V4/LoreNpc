execute store result storage lorenpc:runtime reply_args.id int 1 run scoreboard players get @s ln_active
execute store result storage lorenpc:runtime reply_args.n int 1 run scoreboard players get @s ln_choice
function lorenpc:internal/reply_macro with storage lorenpc:runtime reply_args
