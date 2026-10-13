# Recuperar un NPC oculto en la posición actual.
# Debe existir en la base de datos.

$execute unless data storage lorenpc:db npcs.n$(id) run return fail

# Verificar que el NPC no esté visible.
$scoreboard players set #target ln_id $(id)
scoreboard players set #found ln_id 0

execute as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run scoreboard players set #found ln_id 1

execute if score #found ln_id matches 1 run tellraw @s {text:"[LoreNPC] Ese NPC ya esta visible.",color:"red"}
execute if score #found ln_id matches 1 run return fail

# Recuperar nombre desde la base.
$data modify storage lorenpc:runtime spawn_args set value {id:$(id)}
$data modify storage lorenpc:runtime spawn_args.nombre set from storage lorenpc:db npcs.n$(id).nombre

# Crear entidades.
function lorenpc:internal/npc/spawn with storage lorenpc:runtime spawn_args

tellraw @s {text:"[LoreNPC] NPC recuperado.",color:"green"}
