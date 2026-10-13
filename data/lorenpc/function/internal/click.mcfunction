advancement revoke @s only lorenpc:click
execute if entity @e[type=minecraft:interaction,tag=ln_click,distance=..3,limit=1,sort=nearest] run scoreboard players operation @s ln_active = @e[type=minecraft:interaction,tag=ln_click,distance=..3,limit=1,sort=nearest] ln_id
execute if entity @e[type=minecraft:interaction,tag=ln_click,distance=..3] run function lorenpc:internal/open
