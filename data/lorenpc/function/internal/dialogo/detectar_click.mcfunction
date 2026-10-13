# Ejecutado como la entidad interaction que recibió el clic.

# Recordar el ID del NPC.
scoreboard players operation #clicked ln_id = @s ln_id

# Asignar ese ID al jugador que hizo clic.
execute on target run scoreboard players operation @s ln_active = #clicked ln_id

# Abrir el diálogo para ese jugador.
execute on target run function lorenpc:internal/dialogo/open

# Limpiar el clic para no repetirlo en el siguiente tick.
data remove entity @s interaction