# LoreNPC - Clic derecho sobre un NPC

# Guardar el ID de la entidad seleccionada.
scoreboard players operation #clicked ln_id = @s ln_id

# Asignar ID al jugador.
execute on target run scoreboard players operation @s ln_active = #clicked ln_id

# Solicitar que el mod abra la interfaz.
execute on target run scoreboard players set @s ln_open 1

# Consumir el clic.
data remove entity @s interaction
