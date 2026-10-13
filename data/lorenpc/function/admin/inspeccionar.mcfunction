# LoreNPC - Diagnostico de un NPC
# Uso: /function lorenpc:admin/inspeccionar {id:1}

$execute unless data storage lorenpc:db npcs.n$(id) run tellraw @s {text:"[LoreNPC] El NPC no existe.",color:"red"}
$execute unless data storage lorenpc:db npcs.n$(id) run return fail

tellraw @s {text:"========== LoreNPC ==========",color:"gold"}

$tellraw @s [{text:"ID administrativo: ",color:"yellow"},{text:"$(id)",color:"white"}]

$execute if data storage lorenpc:db npcs.n$(id){hidden:1b} run tellraw @s {text:"Estado: oculto",color:"yellow"}
$execute unless data storage lorenpc:db npcs.n$(id){hidden:1b} run tellraw @s {text:"Estado: visible en registro",color:"green"}

$execute if data storage lorenpc:db npcs.n$(id).generation run tellraw @s {text:"Generacion interna: registrada",color:"green"}
$execute unless data storage lorenpc:db npcs.n$(id).generation run tellraw @s {text:"Generacion interna: LEGACY",color:"yellow"}

$execute if data storage lorenpc:db npcs.n$(id).location.pos run tellraw @s {text:"Coordenadas: registradas",color:"green"}
$execute unless data storage lorenpc:db npcs.n$(id).location.pos run tellraw @s {text:"Coordenadas: no registradas",color:"yellow"}

$execute if data storage lorenpc:db npcs.n$(id).location.dimension run tellraw @s {text:"Dimension: registrada",color:"green"}
$execute unless data storage lorenpc:db npcs.n$(id).location.dimension run tellraw @s {text:"Dimension: no registrada",color:"yellow"}

$scoreboard players set #target ln_id $(id)
scoreboard players set #villagers ln_id 0
scoreboard players set #interactions ln_id 0

execute in minecraft:overworld as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run scoreboard players add #villagers ln_id 1
execute in minecraft:the_nether as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run scoreboard players add #villagers ln_id 1
execute in minecraft:the_end as @e[type=minecraft:villager,tag=ln_npc] if score @s ln_id = #target ln_id run scoreboard players add #villagers ln_id 1

execute in minecraft:overworld as @e[type=minecraft:interaction,tag=ln_click] if score @s ln_id = #target ln_id run scoreboard players add #interactions ln_id 1
execute in minecraft:the_nether as @e[type=minecraft:interaction,tag=ln_click] if score @s ln_id = #target ln_id run scoreboard players add #interactions ln_id 1
execute in minecraft:the_end as @e[type=minecraft:interaction,tag=ln_click] if score @s ln_id = #target ln_id run scoreboard players add #interactions ln_id 1

tellraw @s [{text:"Aldeanos cargados: ",color:"yellow"},{score:{name:"#villagers",objective:"ln_id"},color:"white"}]
tellraw @s [{text:"Interacciones cargadas: ",color:"yellow"},{score:{name:"#interactions",objective:"ln_id"},color:"white"}]

tellraw @s {text:"Solo se revisan entidades en chunks cargados de las dimensiones vanilla.",color:"gray"}
tellraw @s {text:"=============================",color:"gold"}