# Kit de supervivencia para juniors

Un tutor para [OpenCode](https://opencode.ai) que te explica, te cuestiona y te acompaña, pero no escribe el código por
ti. Es tuyo: cambia su tecnología, sus preferencias y sus plantillas para que se adapte a tu trabajo.

Viene del taller «Kit de supervivencia para juniors» de Código Sin Siesta.

## Instalarlo

Crea tu copia con **Use this template**, déjala pública si vas a usarla desde Codespaces, clónala y ejecuta:

```bash
./instalar.sh
```

Hace falta OpenCode 2. Esto instala el tutor en tu usuario:

- **Vale para todos tus repos** y no añade nada a ninguno.
- **Usa enlaces:** editas el kit en tu repo y OpenCode ve el cambio.
- **Si ya tenías un fichero con ese nombre,** lo guarda como `.bak`.

Si solo lo quieres en un proyecto, usa `./instalar.sh --proyecto RUTA`. Lo excluye de git en tu copia local, para que tu
tutor no entre en los commits del equipo. Para quitar la instalación personal: `./instalar.sh --quitar`.

## Usarlo

Abre OpenCode en cualquier repo y cambia al tutor con **Shift+Tab**.

| Comando | Para qué |
|---|---|
| `/mapa` | Orientarte en un repo que no conoces |
| `/explica` | Entender un fichero, una función o un concepto |
| `/pista` | Recibir solo la siguiente pista |
| `/revisa` | Que revise tu cambio como una persona senior |
| `/examen` | Comprobar si entiendes lo que has entregado |
| `/aprendido` | Cerrar la sesión con una nota para tu diario |

Cuando un ticket no sea para aprender, cambia al agente `build` con Shift+Tab. Decidir cuándo usar cada uno también es
parte del oficio.

## Adaptarlo

| Quieres cambiar | Edita |
|---|---|
| Tu tecnología, nivel, idioma y exigencia | `opencode/skills/perfil-tutor/SKILL.md` |
| Tus plantillas de PR, ticket o notas | `opencode/skills/plantillas/SKILL.md` |
| Cómo se comporta y cómo da las pistas | el texto de `opencode/agents/tutor.md` |
| Qué puede hacer | los permisos de `opencode/agents/tutor.md` |
| Tus propios comandos | añade un `.md` en `opencode/commands/` y vuelve a ejecutar `./instalar.sh` |

**Otra tecnología:** si no usas Node.js, añade tus tests a los permisos de `tutor.md`, debajo de los de `npm` y encima de
las dos reglas finales, que deben seguir siendo las últimas:

```yaml
- { action: shell, resource: "mvn test *", effect: allow }
```

**Desde Codespaces** no puedes hacer `git push` a tu kit: edítalo en GitHub (abre tu repo y pulsa `.`) y tráete los cambios con
`git -C ~/kit-junior pull`.

## Tu diario

Guarda en `aprendizajes/` lo que aprendes. `/aprendido` te ayuda a redactarlo, pero lo escribes tú: así el diario es tuyo
y queda en tu repo.

## Qué protege y qué no

- **Los permisos impiden que el tutor cambie tus ficheros.** Están en lista blanca porque denegar solo `edit` no basta:
  el agente delega en un subagente y cambia el código igual.
- **Los permisos no garantizan que se guarde la solución.** Eso depende de sus instrucciones y del modelo, y a veces se le
  escapa. Si pasa, dale otra instrucción en `tutor.md`.
- **No es una barrera de seguridad.** Evita que el tutor escriba por descuido, pero no sustituye a un contenedor.
- **Lo que le enseñas llega al proveedor del modelo.** Antes de usarlo con código de tu empresa, pregunta qué herramientas
  y modelos están aprobados.

## Si usas otra herramienta

Las instrucciones de `tutor.md` y las skills se pueden reutilizar, pero el bloqueo de permisos no: está escrito para
OpenCode y hay que rehacerlo en cada herramienta.

## Licencia

MIT · Código Sin Siesta.
