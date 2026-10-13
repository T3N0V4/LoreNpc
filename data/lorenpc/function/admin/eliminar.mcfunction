$function lorenpc:admin/esconder {id:$(id)}
$data remove storage lorenpc:db npcs.n$(id)
tellraw @s {text:"[LoreNPC] Registro eliminado",color:"red"}
