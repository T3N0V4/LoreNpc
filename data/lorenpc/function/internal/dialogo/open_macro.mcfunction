# Macro: id
# @s es el jugador que hizo clic derecho.

# Ventana base.
data modify storage lorenpc:runtime ui set value {dialog:{type:"minecraft:multi_action",title:"LoreNPC",columns:1,pause:false,can_close_with_escape:true,actions:[],exit_action:{label:"Cerrar"}}}

# Nombre del NPC.
$data modify storage lorenpc:runtime ui.dialog.title set from storage lorenpc:db npcs.n$(id).nombre

# Pregunta 1.
$execute if data storage lorenpc:db npcs.n$(id).questions.n0.q run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"",action:{type:"minecraft:run_command",command:"/trigger ln_choice set 1"}}
$execute if data storage lorenpc:db npcs.n$(id).questions.n0.q run data modify storage lorenpc:runtime ui.dialog.actions[-1].label set from storage lorenpc:db npcs.n$(id).questions.n0.q

# Pregunta 2.
$execute if data storage lorenpc:db npcs.n$(id).questions.n1.q run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"",action:{type:"minecraft:run_command",command:"/trigger ln_choice set 2"}}
$execute if data storage lorenpc:db npcs.n$(id).questions.n1.q run data modify storage lorenpc:runtime ui.dialog.actions[-1].label set from storage lorenpc:db npcs.n$(id).questions.n1.q

# Pregunta 3.
$execute if data storage lorenpc:db npcs.n$(id).questions.n2.q run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"",action:{type:"minecraft:run_command",command:"/trigger ln_choice set 3"}}
$execute if data storage lorenpc:db npcs.n$(id).questions.n2.q run data modify storage lorenpc:runtime ui.dialog.actions[-1].label set from storage lorenpc:db npcs.n$(id).questions.n2.q

# Si no hay preguntas, mostrar un botón informativo.
execute unless data storage lorenpc:runtime ui.dialog.actions[0] run data modify storage lorenpc:runtime ui.dialog.actions append value {label:"No tiene preguntas disponibles"}

# Mostrar la ventana al jugador.
function lorenpc:internal/dialogo/mostrar_ventana with storage lorenpc:runtime ui
