# Argumentos: id, nombre

$scoreboard players set #target ln_id $(id)
execute unless score #target ln_id matches 1.. run return fail

$execute if data storage lorenpc:db npcs.n$(id) run tellraw @s {text:"[LoreNPC] Ese ID ya existe.",color:"red"}
$execute if data storage lorenpc:db npcs.n$(id) run return fail

$data modify storage lorenpc:db npcs.n$(id) set value {nombre:"$(nombre)",questions:{},personalidad:"normal"}
# Generacion interna, independiente del ID administrativo.
scoreboard players add #next ln_gen 1

$execute store result storage lorenpc:db npcs.n$(id).generation int 1 run scoreboard players get #next ln_gen
$data modify storage lorenpc:runtime spawn_args set value {id:$(id),nombre:"$(nombre)"}
$data modify storage lorenpc:runtime spawn_args.generation set from storage lorenpc:db npcs.n$(id).generation

function lorenpc:internal/npc/spawn with storage lorenpc:runtime spawn_args

tellraw @s {text:"[LoreNPC] NPC creado.",color:"green"}
