$execute as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id matches $(id) run kill @s
$execute as @e[type=minecraft:interaction,tag=ln_click] if score @s ln_id matches $(id) run kill @s
tellraw @s {text:"[LoreNPC] NPC escondido (datos conservados)",color:"yellow"}
