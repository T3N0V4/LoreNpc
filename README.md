# LoreNPC Minecraft Java 26.3

## Comandos (OP)
/function lorenpc:admin/crear {id:1,nombre:"El Testigo"}
/function lorenpc:admin/pregunta {id:1,n:0,texto:"Que paso?"}
/function lorenpc:admin/respuesta {id:1,n:0,texto:"No recuerdo nada"}
/function lorenpc:admin/nombre {id:1,texto:"El Testigo"}
/function lorenpc:admin/esconder {id:1}
/function lorenpc:admin/mostrar {id:1}
/function lorenpc:admin/eliminar {id:1}
/function lorenpc:admin/listar

Preguntas: indices n=0,1,2. Respuesta: hacer clic en el texto del chat. Para conversar otra vez, clic derecho otra vez. La personalidad se almacena pero sus efectos todavía no se implementaron.

IMPORTANTE: el contenido de storage se conserva al reiniciar el mundo, no dentro del propio zip del datapack. Hacer backup del mundo. No crear IDs repetidos. NPCs quedan inmóviles. Un solo NPC cerca para evitar ambigüedad en el clic. Si estaba ya cargado el datapack, /reload.

Limitaciones: estructura verificada, comportamiento de Minecraft NO probado dentro del juego; la interacción y macros requieren validación con el motor del juego.
