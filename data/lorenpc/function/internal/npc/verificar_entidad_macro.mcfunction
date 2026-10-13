# LoreNPC - Validar la identidad de una entidad cargada.
# @s = aldeano o interaction.
# id llega desde lorenpc:runtime check.

# 1. Registro inexistente: entidad huerfana.
$execute unless data storage lorenpc:db npcs.n$(id) run kill @s
$execute unless data storage lorenpc:db npcs.n$(id) run return 0

# 2. Registro oculto: la entidad no debe permanecer en el mundo.
$execute if data storage lorenpc:db npcs.n$(id){hidden:1b} run kill @s
$execute if data storage lorenpc:db npcs.n$(id){hidden:1b} run return 0

# 3. Comparar generaciones cuando el registro tiene identidad nueva.
# Los registros antiguos sin generation quedan pendientes de migracion.
$execute if data storage lorenpc:db npcs.n$(id).generation store result score #expected ln_gen run data get storage lorenpc:db npcs.n$(id).generation 1

$execute if data storage lorenpc:db npcs.n$(id).generation unless score @s ln_gen = #expected ln_gen run kill @s
