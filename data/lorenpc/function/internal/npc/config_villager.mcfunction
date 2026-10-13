# @s = aldeano recién invocado.

$data merge entity @s {Tags:["ln_npc"],NoAI:1b,Invulnerable:1b,PersistenceRequired:1b,Silent:1b,CustomName:{text:"$(nombre)"},CustomNameVisible:1b,VillagerData:{profession:"minecraft:nitwit",level:1,type:"minecraft:plains"}}
$scoreboard players set @s ln_id $(id)
# Registrar la ubicacion original solo si aun no existe.
# La posicion se guarda desde la entidad recien creada.
$execute unless data storage lorenpc:db npcs.n$(id).location.pos run data modify storage lorenpc:db npcs.n$(id).location.pos set from entity @s Pos

# Registrar la dimension original.
$execute if dimension minecraft:overworld unless data storage lorenpc:db npcs.n$(id).location.dimension run data modify storage lorenpc:db npcs.n$(id).location.dimension set value "minecraft:overworld"
$execute if dimension minecraft:the_nether unless data storage lorenpc:db npcs.n$(id).location.dimension run data modify storage lorenpc:db npcs.n$(id).location.dimension set value "minecraft:the_nether"
$execute if dimension minecraft:the_end unless data storage lorenpc:db npcs.n$(id).location.dimension run data modify storage lorenpc:db npcs.n$(id).location.dimension set value "minecraft:the_end"

$scoreboard players set @s ln_gen $(generation)
