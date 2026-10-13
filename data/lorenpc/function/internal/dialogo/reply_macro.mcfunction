# LoreNPC - Procesamiento de respuestas
# Macro: id = NPC con el que habla el jugador.
# ln_choice = pregunta seleccionada por el jugador.
# No se utiliza almacenamiento global para la respuesta.

# Pregunta 1
$execute if score @s ln_choice matches 1 if data storage lorenpc:db npcs.n$(id).questions.n0.a run tellraw @s [{text:"Aldeano: ",color:"gold"},{nbt:"npcs.n$(id).questions.n0.a",storage:"lorenpc:db",color:"white"}]

# Pregunta 2
$execute if score @s ln_choice matches 2 if data storage lorenpc:db npcs.n$(id).questions.n1.a run tellraw @s [{text:"Aldeano: ",color:"gold"},{nbt:"npcs.n$(id).questions.n1.a",storage:"lorenpc:db",color:"white"}]

# Pregunta 3
$execute if score @s ln_choice matches 3 if data storage lorenpc:db npcs.n$(id).questions.n2.a run tellraw @s [{text:"Aldeano: ",color:"gold"},{nbt:"npcs.n$(id).questions.n2.a",storage:"lorenpc:db",color:"white"}]

# Respuestas no configuradas
$execute if score @s ln_choice matches 1 unless data storage lorenpc:db npcs.n$(id).questions.n0.a run tellraw @s {text:"El aldeano guarda silencio...",color:"gray",italic:true}
$execute if score @s ln_choice matches 2 unless data storage lorenpc:db npcs.n$(id).questions.n1.a run tellraw @s {text:"El aldeano guarda silencio...",color:"gray",italic:true}
$execute if score @s ln_choice matches 3 unless data storage lorenpc:db npcs.n$(id).questions.n2.a run tellraw @s {text:"El aldeano guarda silencio...",color:"gray",italic:true}