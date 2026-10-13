# Macro: id
# Carga los datos y genera las preguntas.

$data modify storage lorenpc:runtime npc set from storage lorenpc:db npcs.n$(id)

data modify storage lorenpc:runtime render set value {}
data modify storage lorenpc:runtime render.nombre set from storage lorenpc:runtime npc.nombre

tellraw @s {text:"------------------------",color:"dark_gray"}

function lorenpc:internal/dialogo/render_nombre with storage lorenpc:runtime render

tellraw @s {text:"Elegí una pregunta:",color:"yellow"}

# Primera pregunta
execute if data storage lorenpc:runtime npc.questions.n0.q run data modify storage lorenpc:runtime render set value {numero:1}
execute if data storage lorenpc:runtime npc.questions.n0.q run data modify storage lorenpc:runtime render.texto set from storage lorenpc:runtime npc.questions.n0.q
execute if data storage lorenpc:runtime npc.questions.n0.q run function lorenpc:internal/dialogo/render_pregunta with storage lorenpc:runtime render

# Segunda pregunta
execute if data storage lorenpc:runtime npc.questions.n1.q run data modify storage lorenpc:runtime render set value {numero:2}
execute if data storage lorenpc:runtime npc.questions.n1.q run data modify storage lorenpc:runtime render.texto set from storage lorenpc:runtime npc.questions.n1.q
execute if data storage lorenpc:runtime npc.questions.n1.q run function lorenpc:internal/dialogo/render_pregunta with storage lorenpc:runtime render

# Tercera pregunta
execute if data storage lorenpc:runtime npc.questions.n2.q run data modify storage lorenpc:runtime render set value {numero:3}
execute if data storage lorenpc:runtime npc.questions.n2.q run data modify storage lorenpc:runtime render.texto set from storage lorenpc:runtime npc.questions.n2.q
execute if data storage lorenpc:runtime npc.questions.n2.q run function lorenpc:internal/dialogo/render_pregunta with storage lorenpc:runtime render

tellraw @s {text:"------------------------",color:"dark_gray"}
