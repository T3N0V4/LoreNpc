# Desaparece el NPC, pero conserva sus datos.
# Argumento: id

$execute unless data storage lorenpc:db npcs.n$(id) run tellraw @s {text:"[LoreNPC] Ese NPC no existe.",color:"red"}
$execute unless data storage lorenpc:db npcs.n$(id) run return fail

$execute as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id matches $(id) run kill @s
$execute as @e[type=minecraft:interaction,tag=ln_click] if score @s ln_id matches $(id) run kill @s

tellraw @s {text:"[LoreNPC] NPC escondido. Datos conservados.",color:"yellow"}
