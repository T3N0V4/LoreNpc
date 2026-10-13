# LoreNPC - Solicitar recuperacion
# Argumento: id
# El mod Java procesara la solicitud.

# Comprobar registro.
$execute unless data storage lorenpc:db npcs.n$(id) run tellraw @s {text:"[LoreNPC] El NPC no existe.",color:"red"}
$execute unless data storage lorenpc:db npcs.n$(id) run return fail

# Debe estar oculto.
$execute unless data storage lorenpc:db npcs.n$(id){hidden:1b} run tellraw @s {text:"[LoreNPC] Este NPC no esta oculto.",color:"red"}
$execute unless data storage lorenpc:db npcs.n$(id){hidden:1b} run return fail

# Exigir identidad y ubicacion.
$execute unless data storage lorenpc:db npcs.n$(id).generation run tellraw @s {text:"[LoreNPC] NPC antiguo: requiere migracion.",color:"red"}
$execute unless data storage lorenpc:db npcs.n$(id).generation run return fail

$execute unless data storage lorenpc:db npcs.n$(id).location.pos run tellraw @s {text:"[LoreNPC] Faltan coordenadas.",color:"red"}
$execute unless data storage lorenpc:db npcs.n$(id).location.pos run return fail

$execute unless data storage lorenpc:db npcs.n$(id).location.dimension run tellraw @s {text:"[LoreNPC] Falta dimension.",color:"red"}
$execute unless data storage lorenpc:db npcs.n$(id).location.dimension run return fail

# Evitar sobrescribir solicitudes anteriores.
execute if data storage lorenpc:runtime recovery.pending run tellraw @s {text:"[LoreNPC] Ya hay una recuperacion pendiente.",color:"yellow"}
execute if data storage lorenpc:runtime recovery.pending run return fail

# Registrar el ID y su generacion.
$data modify storage lorenpc:runtime recovery set value {id:$(id),pending:1b}
$data modify storage lorenpc:runtime recovery.generation set from storage lorenpc:db npcs.n$(id).generation

tellraw @s {text:"[LoreNPC] Solicitud registrada. Pendiente del administrador Java.",color:"yellow"}
