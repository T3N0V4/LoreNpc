# Se ejecuta como el aldeano o interaction.
# Obtiene el ID de la entidad.

execute store result storage lorenpc:runtime check.id int 1 run scoreboard players get @s ln_id

function lorenpc:internal/npc/verificar_entidad_macro with storage lorenpc:runtime check
