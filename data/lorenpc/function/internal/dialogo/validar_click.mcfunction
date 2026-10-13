# LoreNPC - Validacion del clic derecho.
# Macro: $(id)
# @s sigue siendo la entidad interaction.

# El NPC debe existir.
$execute unless data storage lorenpc:db npcs.n$(id) run return 0

# No conversar con NPC ocultos.
$execute if data storage lorenpc:db npcs.n$(id){hidden:1b} run return 0

# Si el registro tiene generacion, la entidad debe coincidir.
$execute if data storage lorenpc:db npcs.n$(id).generation store result score #click_expected ln_gen run data get storage lorenpc:db npcs.n$(id).generation 1

$execute if data storage lorenpc:db npcs.n$(id).generation unless score @s ln_gen = #click_expected ln_gen run return 0

# El jugador debe seguir siendo el objetivo de la interaccion.
execute unless entity @s[nbt={interaction:{}}] run return 0

# Entregar el ID al jugador que interactuo.
$execute on target run scoreboard players set @s ln_active $(id)

# Solicitar la apertura de la interfaz.
execute on target run scoreboard players set @s ln_open 1
