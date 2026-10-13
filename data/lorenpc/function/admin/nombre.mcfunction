# Cambia el nombre almacenado y el nombre visible.
# Argumentos: id, texto

$execute unless data storage lorenpc:db npcs.n$(id) run tellraw @s {text:"[LoreNPC] Ese NPC no existe.",color:"red"}
$execute unless data storage lorenpc:db npcs.n$(id) run return fail

# Actualizar base de datos.
$data modify storage lorenpc:db npcs.n$(id).nombre set value "$(texto)"

# Actualizar aldeano visible.
$execute as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id matches $(id) run data modify entity @s CustomName set value {text:"$(texto)"}

tellraw @s {text:"[LoreNPC] Nombre actualizado.",color:"green"}
