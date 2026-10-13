$execute unless data storage lorenpc:db npcs.n$(id).questions.n$(n) run data modify storage lorenpc:db npcs.n$(id).questions.n$(n) set value {}
$data modify storage lorenpc:db npcs.n$(id).questions.n$(n).a set value "$(texto)"
tellraw @s {text:"[LoreNPC] Respuesta guardada",color:"green"}
