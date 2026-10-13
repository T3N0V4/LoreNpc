$data modify storage lorenpc:runtime npc set from storage lorenpc:db npcs.n$(id)
tellraw @s {text:"----- LoreNPC -----",color:"gold"}
tellraw @s [{text:"Hablando con: ",color:"gray"},{nbt:"npc.nombre",storage:"lorenpc:runtime",color:"yellow"}]
execute if data storage lorenpc:runtime npc.questions.n0.q run tellraw @s [{text:"[1] ",color:"aqua",click_event:{action:"run_command",command:"/trigger ln_choice set 1"}},{nbt:"npc.questions.n0.q",storage:"lorenpc:runtime",color:"aqua",click_event:{action:"run_command",command:"/trigger ln_choice set 1"}}]
execute if data storage lorenpc:runtime npc.questions.n1.q run tellraw @s [{text:"[2] ",color:"aqua",click_event:{action:"run_command",command:"/trigger ln_choice set 2"}},{nbt:"npc.questions.n1.q",storage:"lorenpc:runtime",color:"aqua",click_event:{action:"run_command",command:"/trigger ln_choice set 2"}}]
execute if data storage lorenpc:runtime npc.questions.n2.q run tellraw @s [{text:"[3] ",color:"aqua",click_event:{action:"run_command",command:"/trigger ln_choice set 3"}},{nbt:"npc.questions.n2.q",storage:"lorenpc:runtime",color:"aqua",click_event:{action:"run_command",command:"/trigger ln_choice set 3"}}]
