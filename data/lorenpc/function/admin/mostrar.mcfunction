$execute unless data storage lorenpc:db npcs.n$(id) run return fail
$scoreboard players set #target ln_id $(id)
execute as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run return fail
$data modify storage lorenpc:runtime spawn_args set value {id:$(id)}
$data modify storage lorenpc:runtime spawn_args.nombre set from storage lorenpc:db npcs.n$(id).nombre
function lorenpc:internal/spawn with storage lorenpc:runtime spawn_args
tellraw @s {text:"[LoreNPC] NPC recuperado",color:"green"}
