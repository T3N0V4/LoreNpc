# Argumento: id

$execute unless data storage lorenpc:db npcs.n$(id) run return fail

$scoreboard players set #target ln_id $(id)
function lorenpc:internal/npc/buscar_visible

execute if score #found ln_id matches 1 run tellraw @s {text:"[LoreNPC] Ese NPC ya esta visible.",color:"red"}
execute if score #found ln_id matches 1 run return fail

$data modify storage lorenpc:runtime spawn_args set value {id:$(id)}
$data modify storage lorenpc:runtime spawn_args.nombre set from storage lorenpc:db npcs.n$(id).nombre

function lorenpc:internal/npc/spawn with storage lorenpc:runtime spawn_args

tellraw @s {text:"[LoreNPC] NPC recuperado.",color:"green"}
