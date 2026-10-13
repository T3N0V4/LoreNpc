# Editar respuesta de un NPC.
# id = identificador del NPC
# n = posicion (0, 1 o 2)
# texto = respuesta

$execute unless data storage lorenpc:db npcs.n$(id) run tellraw @s {text:"[LoreNPC] El NPC no existe.",color:"red"}
$execute unless data storage lorenpc:db npcs.n$(id) run return fail

$scoreboard players set #slot ln_id $(n)

execute unless score #slot ln_id matches 0..2 run tellraw @s {text:"[LoreNPC] Solo se permiten respuestas 0, 1 y 2.",color:"red"}
execute unless score #slot ln_id matches 0..2 run return fail

$execute unless data storage lorenpc:db npcs.n$(id).questions.n$(n) run data modify storage lorenpc:db npcs.n$(id).questions.n$(n) set value {}

$data modify storage lorenpc:db npcs.n$(id).questions.n$(n).a set value "$(texto)"

tellraw @s {text:"[LoreNPC] Respuesta actualizada.",color:"green"}
