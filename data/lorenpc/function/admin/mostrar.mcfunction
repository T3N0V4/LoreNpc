# LoreNPC - Recuperar NPC
# Argumento: id

# Comprobar que existe.
$execute unless data storage lorenpc:db npcs.n$(id) run tellraw @s {text:"[LoreNPC] El NPC no existe.",color:"red"}
$execute unless data storage lorenpc:db npcs.n$(id) run return fail

# Solo permitir NPC ocultos.
$execute unless data storage lorenpc:db npcs.n$(id){hidden:1b} run tellraw @s {text:"[LoreNPC] Este NPC no esta oculto.",color:"red"}
$execute unless data storage lorenpc:db npcs.n$(id){hidden:1b} run return fail

# Exigir coordenadas originales.
$execute unless data storage lorenpc:db npcs.n$(id).location.pos run tellraw @s {text:"[LoreNPC] Este NPC no tiene una ubicacion guardada.",color:"red"}
$execute unless data storage lorenpc:db npcs.n$(id).location.pos run return fail

$execute unless data storage lorenpc:db npcs.n$(id).location.dimension run tellraw @s {text:"[LoreNPC] Este NPC no tiene dimension guardada.",color:"red"}
$execute unless data storage lorenpc:db npcs.n$(id).location.dimension run return fail

# La recuperacion por coordenadas se implementara en el mod.
# No generar entidades nuevas en la posicion del administrador.
tellraw @s {text:"[LoreNPC] Ubicacion encontrada. Recuperacion pendiente de habilitar.",color:"yellow"}