# Argumento: id

$execute unless data storage lorenpc:db npcs.n$(id) run return fail

$scoreboard players set #target ln_id $(id)
$data modify storage lorenpc:db npcs.n$(id).hidden set value 1b
function lorenpc:internal/npc/quitar_visible

tellraw @s {text:"[LoreNPC] Entidades cargadas retiradas. Registro conservado.",color:"yellow"}
