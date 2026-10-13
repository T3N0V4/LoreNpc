scoreboard players enable @a ln_choice
execute as @a[scores={ln_choice=1..3}] run function lorenpc:internal/dialogo/reply
scoreboard players set @a[scores={ln_choice=1..}] ln_choice 0
