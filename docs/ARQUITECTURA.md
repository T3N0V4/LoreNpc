# Arquitectura LoreNPC

Minecraft Java 26.3 - Fabric
Namespace: lorenpc

## admin/
Funciones públicas ejecutadas por administradores.

## internal/npc/
Creación, recuperación y manejo de entidades.

## internal/dialogo/
Detección de interacciones, preguntas y respuestas.

## internal/tick
Actualización automática de conversaciones.

## Almacenamiento
lorenpc:db      - Configuración persistente de NPC.
lorenpc:runtime - Datos temporales de ejecución.

## Identificadores
Cada NPC tiene un ID numérico único.

## Reglas del proyecto
- No cambiar comandos públicos sin actualizar COMANDOS.md.
- No modificar la estructura de almacenamiento sin documentarlo.
- No eliminar funciones sin revisar sus referencias.
- No considerar funcional algo que no fue probado en Minecraft.
- Mantener compatibilidad con Minecraft Java 26.3.