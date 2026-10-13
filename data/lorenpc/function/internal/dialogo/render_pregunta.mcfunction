# Recibe numero y texto
$tellraw @s {text:"[$(numero)] $(texto)",color:"aqua",click_event:{action:"run_command",command:"/trigger ln_choice set $(numero)"},hover_event:{action:"show_text",value:{text:"Preguntar",color:"green"}}}
