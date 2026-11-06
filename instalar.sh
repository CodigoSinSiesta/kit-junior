#!/usr/bin/env bash
#
# instalar.sh: instala el kit en OpenCode.
#
#   ./instalar.sh                    Instalación personal: vale para todos tus repos y no toca ninguno.
#   ./instalar.sh --proyecto RUTA    Solo en ese repo, sin que entre en sus commits.
#   ./instalar.sh --quitar           Quita la instalación personal.
#
# La instalación personal usa enlaces: editas el kit en tu repo y OpenCode ve el cambio.
set -euo pipefail

KIT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ORIGEN="$KIT/opencode"
PERSONAL="${XDG_CONFIG_HOME:-$HOME/.config}/opencode"

ficheros() { (cd "$ORIGEN" && find agents commands skills -type f | sort); }

case "${1:-}" in
  --quitar)
    while IFS= read -r f; do
      if [[ -L "$PERSONAL/$f" ]]; then rm "${PERSONAL:?}/${f:?}"; fi
    done < <(ficheros)
    echo "Kit quitado. Tu repo del kit sigue intacto."
    ;;

  --proyecto)
    REPO="$(cd "${2:?Indica la ruta del repo: ./instalar.sh --proyecto RUTA}" && pwd)"
    while IFS= read -r f; do
      mkdir -p "$(dirname "$REPO/.opencode/$f")"
      cp "$ORIGEN/$f" "$REPO/.opencode/$f"
      # Se excluye en local: tu tutor no entra en los commits del equipo.
      if [[ -d "$REPO/.git" ]] && ! grep -qxF ".opencode/$f" "$REPO/.git/info/exclude" 2>/dev/null; then
        echo ".opencode/$f" >> "$REPO/.git/info/exclude"
      fi
    done < <(ficheros)
    echo "Kit copiado en $REPO/.opencode y excluido de los commits."
    ;;

  "")
    while IFS= read -r f; do
      destino="$PERSONAL/$f"
      mkdir -p "$(dirname "$destino")"
      # Si ya tenías un fichero con ese nombre, se guarda antes de enlazar.
      if [[ -e "$destino" && ! -L "$destino" ]]; then
        mv "$destino" "$destino.bak"
        echo "Guardado tu fichero anterior en $destino.bak"
      fi
      ln -sfn "$ORIGEN/$f" "$destino"
    done < <(ficheros)
    echo "Kit instalado en $PERSONAL."
    echo "Siguiente paso: edita opencode/skills/perfil-tutor/SKILL.md y abre OpenCode. Cambia al tutor con Shift+Tab."
    ;;

  *)
    sed -n '3,8p' "$0"
    exit 1
    ;;
esac
