data remove storage lorenpc:runtime reply
$execute if data storage lorenpc:db npcs.n$(id).questions.n0.a if score @s ln_choice matches 1 run data modify storage lorenpc:runtime reply set from storage lorenpc:db npcs.n$(id).questions.n0.a
$execute if data storage lorenpc:db npcs.n$(id).questions.n1.a if score @s ln_choice matches 2 run data modify storage lorenpc:runtime reply set from storage lorenpc:db npcs.n$(id).questions.n1.a
$execute if data storage lorenpc:db npcs.n$(id).questions.n2.a if score @s ln_choice matches 3 run data modify storage lorenpc:runtime reply set from storage lorenpc:db npcs.n$(id).questions.n2.a
tellraw @s [{text:"Aldeano: ",color:"yellow"},{nbt:"reply",storage:"lorenpc:runtime",color:"white"}]
