$summon minecraft:villager ~ ~ ~ {Tags:["ln_npc","ln_new"],NoAI:1b,Invulnerable:1b,PersistenceRequired:1b,CustomName:{text:"$(nombre)"},CustomNameVisible:1b,VillagerData:{profession:"minecraft:nitwit",level:1,type:"minecraft:plains"}}
$scoreboard players set @e[type=minecraft:villager,tag=ln_new,sort=nearest,limit=1,distance=..2] ln_id $(id)
tag @e[type=minecraft:villager,tag=ln_new,sort=nearest,limit=1,distance=..2] remove ln_new
summon minecraft:interaction ~ ~ ~ {Tags:["ln_click","ln_new"],width:0.8f,height:1.95f,response:1b}
$scoreboard players set @e[type=minecraft:interaction,tag=ln_new,sort=nearest,limit=1,distance=..2] ln_id $(id)
tag @e[type=minecraft:interaction,tag=ln_new,sort=nearest,limit=1,distance=..2] remove ln_new
