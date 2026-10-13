# Macro: id
# Se ejecuta como el jugador.

data modify storage lorenpc:runtime render set value {}

$execute if data storage lorenpc:db npcs.n$(id) run data modify storage lorenpc:runtime render.nombre set from storage lorenpc:db npcs.n$(id).nombre

$execute if score @s ln_choice matches 1 if data storage lorenpc:db npcs.n$(id).questions.n0.a run data modify storage lorenpc:runtime render.texto set from storage lorenpc:db npcs.n$(id).questions.n0.a
$execute if score @s ln_choice matches 2 if data storage lorenpc:db npcs.n$(id).questions.n1.a run data modify storage lorenpc:runtime render.texto set from storage lorenpc:db npcs.n$(id).questions.n1.a
$execute if score @s ln_choice matches 3 if data storage lorenpc:db npcs.n$(id).questions.n2.a run data modify storage lorenpc:runtime render.texto set from storage lorenpc:db npcs.n$(id).questions.n2.a

execute if data storage lorenpc:runtime render.texto run function lorenpc:internal/dialogo/render_respuesta with storage lorenpc:runtime render

execute unless data storage lorenpc:runtime render.texto run tellraw @s {text:"El aldeano guarda silencio...",color:"gray",italic:true}
