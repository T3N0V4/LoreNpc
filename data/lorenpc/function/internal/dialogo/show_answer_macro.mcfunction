# Macro: id, slot
# @s = jugador

data modify storage lorenpc:runtime ui set value {dialog:{type:"minecraft:multi_action",title:"NPC",columns:1,pause:false,can_close_with_escape:true,actions:[],exit_action:{label:"Cerrar"}}}

# Titulo = nombre del NPC
$data modify storage lorenpc:runtime ui.dialog.title set from storage lorenpc:db npcs.n$(id).nombre

# Boton con la respuesta
$execute if data storage lorenpc:db npcs.n$(id).questions.n$(slot).a run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"",action:{type:"minecraft:run_command",command:"/function lorenpc:internal/dialogo/noop"}}
$execute if data storage lorenpc:db npcs.n$(id).questions.n$(slot).a run data modify storage lorenpc:runtime ui.dialog.actions[-1].label set from storage lorenpc:db npcs.n$(id).questions.n$(slot).a

# Fallback si no hay respuesta
execute unless data storage lorenpc:db npcs.n$(id).questions.n$(slot).a run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"El aldeano guarda silencio...",action:{type:"minecraft:run_command",command:"/function lorenpc:internal/dialogo/noop"}}

# Boton para volver
data modify storage lorenpc:runtime ui.dialog.actions append value {label:"Volver a preguntas",action:{type:"minecraft:run_command",command:"/function lorenpc:internal/dialogo/open"}}

function lorenpc:internal/dialogo/mostrar_ventana with storage lorenpc:runtime ui
