# Argumento: id

$execute unless data storage lorenpc:db npcs.n$(id) run return fail

$scoreboard players set #target ln_id $(id)
function lorenpc:internal/npc/quitar_visible

tellraw @s {text:"[LoreNPC] Entidades cargadas retiradas. Registro conservado.",color:"yellow"}
