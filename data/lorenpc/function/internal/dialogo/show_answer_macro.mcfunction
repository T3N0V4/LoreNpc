# Macro: id, slot

$function lorenpc:internal/dialogo/construir_menu {id:$(id)}

# Mostrar pregunta seleccionada.
$execute if data storage lorenpc:db npcs.n$(id).questions.n$(slot).q run data modify storage lorenpc:runtime ui.dialog.body[0].contents set from storage lorenpc:db npcs.n$(id).questions.n$(slot).q

# Espacio entre pregunta y respuesta.
data modify storage lorenpc:runtime ui.dialog.body append value {type:"minecraft:plain_message",contents:{text:"────────────────────",color:"dark_gray"},width:320}

# Respuesta por defecto.
data modify storage lorenpc:runtime ui.dialog.body append value {type:"minecraft:plain_message",contents:{text:"El aldeano guarda silencio...",color:"gray",italic:true},width:320}

# Sustituir por respuesta configurada.
$execute if data storage lorenpc:db npcs.n$(id).questions.n$(slot).a run data modify storage lorenpc:runtime ui.dialog.body[-1].contents set from storage lorenpc:db npcs.n$(id).questions.n$(slot).a

# Separador visual.
data modify storage lorenpc:runtime ui.dialog.body append value {type:"minecraft:plain_message",contents:{text:"Elegí otra pregunta:",color:"yellow"},width:320}

# Actualizar la ventana.
function lorenpc:internal/dialogo/mostrar_ventana with storage lorenpc:runtime ui
