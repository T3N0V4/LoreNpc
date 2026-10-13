# Eliminar entidades cuyo registro ya no existe.
$execute unless data storage lorenpc:db npcs.n$(id) run kill @s

# Eliminar entidades de NPC ocultos.
$execute if data storage lorenpc:db npcs.n$(id){hidden:1b} run kill @s
