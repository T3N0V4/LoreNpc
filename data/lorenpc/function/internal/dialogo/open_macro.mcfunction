# LoreNPC - Menu de preguntas
# Macro: id

data modify storage lorenpc:runtime ui set value {dialog:{type:"minecraft:multi_action",title:"NPC",body:[{type:"minecraft:plain_message",contents:"¿Qué querés preguntarle?",width:280}],columns:1,pause:false,can_close_with_escape:true,actions:[],exit_action:{label:"Despedirse"},after_action:"wait_for_response"}}

$data modify storage lorenpc:runtime ui.dialog.title set from storage lorenpc:db npcs.n$(id).nombre

$execute if data storage lorenpc:db npcs.n$(id).questions.n0.q run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"",action:{type:"minecraft:run_command",command:"/trigger ln_choice set 1"}}
$execute if data storage lorenpc:db npcs.n$(id).questions.n0.q run data modify storage lorenpc:runtime ui.dialog.actions[-1].label set from storage lorenpc:db npcs.n$(id).questions.n0.q

$execute if data storage lorenpc:db npcs.n$(id).questions.n1.q run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"",action:{type:"minecraft:run_command",command:"/trigger ln_choice set 2"}}
$execute if data storage lorenpc:db npcs.n$(id).questions.n1.q run data modify storage lorenpc:runtime ui.dialog.actions[-1].label set from storage lorenpc:db npcs.n$(id).questions.n1.q

$execute if data storage lorenpc:db npcs.n$(id).questions.n2.q run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"",action:{type:"minecraft:run_command",command:"/trigger ln_choice set 3"}}
$execute if data storage lorenpc:db npcs.n$(id).questions.n2.q run data modify storage lorenpc:runtime ui.dialog.actions[-1].label set from storage lorenpc:db npcs.n$(id).questions.n2.q

execute unless data storage lorenpc:runtime ui.dialog.actions[0] run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"No hay preguntas disponibles"}

function lorenpc:internal/dialogo/mostrar_ventana with storage lorenpc:runtime ui
