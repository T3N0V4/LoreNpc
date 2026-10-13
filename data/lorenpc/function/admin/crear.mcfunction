# Crea un NPC nuevo en la posición del ejecutor.
# Argumentos: id, nombre

$execute if data storage lorenpc:db npcs.n$(id) run tellraw @s {text:"[LoreNPC] Ese ID ya existe.",color:"red"}
$execute if data storage lorenpc:db npcs.n$(id) run return fail

$data modify storage lorenpc:db npcs.n$(id) set value {nombre:"$(nombre)",questions:{},personalidad:"normal"}
$data modify storage lorenpc:runtime spawn_args set value {id:$(id),nombre:"$(nombre)"}

function lorenpc:internal/npc/spawn with storage lorenpc:runtime spawn_args

tellraw @s {text:"[LoreNPC] NPC creado.",color:"green"}
