# Argumento: id

$execute unless data storage lorenpc:db npcs.n$(id) run return fail

$scoreboard players set #target ln_id $(id)
function lorenpc:internal/npc/quitar_visible

$data remove storage lorenpc:db npcs.n$(id)

tellraw @s {text:"[LoreNPC] Registro eliminado.",color:"red"}
