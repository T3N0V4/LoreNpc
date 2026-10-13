# LoreNPC - Detectar interaccion del jugador.
# @s es la entidad interaction que recibio el clic.

# Solo IDs administrativos validos.
execute unless score @s ln_id matches 1..1000000 run data remove entity @s interaction
execute unless score @s ln_id matches 1..1000000 run return 0

# Preparar el identificador del NPC.
execute store result storage lorenpc:runtime click.id int 1 run scoreboard players get @s ln_id

# Validar antes de generar una solicitud de apertura.
function lorenpc:internal/dialogo/validar_click with storage lorenpc:runtime click

# Consumir siempre el clic, incluso cuando fue rechazado.
data remove entity @s interaction
