# LoreNPC - Apertura de conversación
# Macro: id = identificador del NPC seleccionado.

# Cargar los datos del NPC.
$data modify storage lorenpc:runtime npc set from storage lorenpc:db npcs.n$(id)

# Encabezado del diálogo.
tellraw @s {text:"------------------------",color:"dark_gray"}
tellraw @s [{text:"Hablando con: ",color:"gray"},{nbt:"npc.nombre",storage:"lorenpc:runtime",interpret:false,color:"gold",bold:true}]
tellraw @s {text:"Elegí una pregunta:",color:"yellow"}

# Pregunta 1
execute if data storage lorenpc:runtime npc.questions.n0.q run tellraw @s [{text:"[1] ",color:"aqua"},{nbt:"npc.questions.n0.q",storage:"lorenpc:runtime",interpret:false,color:"aqua",click_event:{action:"run_command",command:"/trigger ln_choice set 1"},hover_event:{action:"show_text",value:{text:"Preguntar",color:"green"}}}]

# Pregunta 2
execute if data storage lorenpc:runtime npc.questions.n1.q run tellraw @s [{text:"[2] ",color:"aqua"},{nbt:"npc.questions.n1.q",storage:"lorenpc:runtime",interpret:false,color:"aqua",click_event:{action:"run_command",command:"/trigger ln_choice set 2"},hover_event:{action:"show_text",value:{text:"Preguntar",color:"green"}}}]

# Pregunta 3
execute if data storage lorenpc:runtime npc.questions.n2.q run tellraw @s [{text:"[3] ",color:"aqua"},{nbt:"npc.questions.n2.q",storage:"lorenpc:runtime",interpret:false,color:"aqua",click_event:{action:"run_command",command:"/trigger ln_choice set 3"},hover_event:{action:"show_text",value:{text:"Preguntar",color:"green"}}}]

tellraw @s {text:"------------------------",color:"dark_gray"}