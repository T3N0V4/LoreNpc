# LoreNPC - Ventana de respuesta
# Macro: id, slot

data modify storage lorenpc:runtime ui set value {dialog:{type:"minecraft:notice",title:"NPC",body:[{type:"minecraft:plain_message",contents:"El aldeano guarda silencio...",width:320}],pause:false,can_close_with_escape:true,action:{label:"Volver a preguntas",action:{type:"minecraft:run_command",command:"/trigger ln_nav set 1"}},after_action:"wait_for_response"}}

$data modify storage lorenpc:runtime ui.dialog.title set from storage lorenpc:db npcs.n$(id).nombre

$execute if data storage lorenpc:db npcs.n$(id).questions.n$(slot).a run data modify storage lorenpc:runtime ui.dialog.body[0].contents set from storage lorenpc:db npcs.n$(id).questions.n$(slot).a

function lorenpc:internal/dialogo/mostrar_ventana with storage lorenpc:runtime ui
