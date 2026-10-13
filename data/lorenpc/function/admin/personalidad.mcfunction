$data modify storage lorenpc:db npcs.n$(id).personalidad set value "$(tipo)"
tellraw @s {text:"[LoreNPC] Personalidad guardada (sin efectos todavía)",color:"yellow"}
