# Macro: id
# @s = jugador

data modify storage lorenpc:runtime ui set value {dialog:{type:"minecraft:multi_action",title:"NPC",columns:1,pause:false,can_close_with_escape:true,actions:[],exit_action:{label:"Cerrar"}}}

$data modify storage lorenpc:runtime ui.dialog.title set from storage lorenpc:db npcs.n$(id).nombre

# Pregunta 0
$execute if data storage lorenpc:db npcs.n$(id).questions.n0.q run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"",action:{type:"minecraft:run_command",command:"/function lorenpc:internal/dialogo/seleccionar_0"}}
$execute if data storage lorenpc:db npcs.n$(id).questions.n0.q run data modify storage lorenpc:runtime ui.dialog.actions[-1].label set from storage lorenpc:db npcs.n$(id).questions.n0.q

# Pregunta 1
$execute if data storage lorenpc:db npcs.n$(id).questions.n1.q run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"",action:{type:"minecraft:run_command",command:"/function lorenpc:internal/dialogo/seleccionar_1"}}
$execute if data storage lorenpc:db npcs.n$(id).questions.n1.q run data modify storage lorenpc:runtime ui.dialog.actions[-1].label set from storage lorenpc:db npcs.n$(id).questions.n1.q

# Pregunta 2
$execute if data storage lorenpc:db npcs.n$(id).questions.n2.q run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"",action:{type:"minecraft:run_command",command:"/function lorenpc:internal/dialogo/seleccionar_2"}}
$execute if data storage lorenpc:db npcs.n$(id).questions.n2.q run data modify storage lorenpc:runtime ui.dialog.actions[-1].label set from storage lorenpc:db npcs.n$(id).questions.n2.q

# Fallback si no hay preguntas
execute unless data storage lorenpc:runtime ui.dialog.actions[0] run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"No tiene preguntas disponibles",action:{type:"minecraft:run_command",command:"/function lorenpc:internal/dialogo/noop"}}

function lorenpc:internal/dialogo/mostrar_ventana with storage lorenpc:runtime ui
