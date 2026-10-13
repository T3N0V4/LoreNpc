# Macro: id
# Construye una ventana multi_action con todas las preguntas.

data modify storage lorenpc:runtime ui set value {dialog:{type:"minecraft:multi_action",title:"Conversación",body:[{type:"minecraft:plain_message",contents:{text:"Elegí una pregunta",color:"yellow"},width:320}],columns:1,pause:false,can_close_with_escape:true,after_action:"none",actions:[],exit_action:{label:"Despedirse"}}}

# Usar el nombre del personaje como titulo.
$data modify storage lorenpc:runtime ui.dialog.title set from storage lorenpc:db npcs.n$(id).nombre

# Preguntas disponibles
$execute if data storage lorenpc:db npcs.n$(id).questions.n0.q run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"",width:280,action:{type:"minecraft:run_command",command:"/trigger ln_choice set 1"}}
$execute if data storage lorenpc:db npcs.n$(id).questions.n0.q run data modify storage lorenpc:runtime ui.dialog.actions[-1].label set from storage lorenpc:db npcs.n$(id).questions.n0.q

$execute if data storage lorenpc:db npcs.n$(id).questions.n1.q run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"",width:280,action:{type:"minecraft:run_command",command:"/trigger ln_choice set 2"}}
$execute if data storage lorenpc:db npcs.n$(id).questions.n1.q run data modify storage lorenpc:runtime ui.dialog.actions[-1].label set from storage lorenpc:db npcs.n$(id).questions.n1.q

$execute if data storage lorenpc:db npcs.n$(id).questions.n2.q run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"",width:280,action:{type:"minecraft:run_command",command:"/trigger ln_choice set 3"}}
$execute if data storage lorenpc:db npcs.n$(id).questions.n2.q run data modify storage lorenpc:runtime ui.dialog.actions[-1].label set from storage lorenpc:db npcs.n$(id).questions.n2.q

# Mensaje cuando no hay preguntas.
execute unless data storage lorenpc:runtime ui.dialog.actions[0] run data modify storage lorenpc:runtime ui.dialog.body[0].contents set value {text:"Este personaje no tiene nada que contar todavía.",color:"gray",italic:true}
