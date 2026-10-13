$data modify storage lorenpc:db npcs.n$(id).nombre set value "$(texto)"
$scoreboard players set #target ln_id $(id)
$execute as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run data modify entity @s CustomName set value {text:"$(texto)"}
