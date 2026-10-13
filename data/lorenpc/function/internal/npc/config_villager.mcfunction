# @s = aldeano recién invocado.

$data merge entity @s {Tags:["ln_npc"],NoAI:1b,Invulnerable:1b,PersistenceRequired:1b,Silent:1b,CustomName:{text:"$(nombre)"},CustomNameVisible:1b,VillagerData:{profession:"minecraft:nitwit",level:1,type:"minecraft:plains"}}
$scoreboard players set @s ln_id $(id)
