# Ruta a tu instalación de Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# TEMA: "bira" es excelente para Kali (doble línea). 
# Puedes cambiarlo a "robbyrussell" si prefieres algo más simple.
#ZSH_THEME="bira"

# PLUGINS
# Asegúrate de haber descargado zsh-autosuggestions y zsh-syntax-highlighting
# como vimos en el paso anterior.
plugins=(
  git
  sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Cargar Oh My Zsh
source $ZSH/oh-my-zsh.sh

# ALIAS DE USUARIO (Tus atajos)
alias ll="ls -la"
alias update="sudo apt update && sudo apt upgrade -y"

# INICIAR FASTFETCH
# Esto hará que Gengar aparezca cada vez que abras la terminal
fastfetch
# --- MIS ALIAS PERSONALIZADOS ---

# 1. Actualizar todo el sistema de una sola vez
# (Actualiza repositorios, instala actualizaciones y limpia basura)
alias actualizar="sudo apt update && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt autoclean"

# 2. Navegación rápida
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ll="ls -la"  # Listar todo, incluso ocultos, en formato lista

# 3. Utilidades para Hacking / CTF
# Levanta un servidor web rápido en la carpeta actual (útil para pasar archivos a máquinas víctima)
alias servidor="python3 -m http.server 8000"

# Ver tu IP rápidamente (resalta la dirección para copiarla fácil)
alias miip="ip -c a"

# Atajo para tu Gengar (por si quieres verlo sin abrir otra terminal)
alias ff="fastfetch"

# 4. Conexión VPN (Ejemplo para TryHackMe o HackTheBox)
# OJO: Cambia la ruta "/ruta/a/tu/archivo.ovpn" por la real donde guardas tu llave
alias vpn="sudo openvpn /home/seba/Descargas/sebastian.navarrete.ovpn"
# 5. Mostrar lista de mis atajos personalizados
alias misalias="grep '^alias' ~/.zshrc"
# 6. Apagar el equipo
alias apagar="systemctl poweroff"
#7. Bios
alias bios="sudo systemctl reboot --firmware-setup"
# --- PROMPT ESTILO KALI (Igual a la foto) ---
# Desactiva el tema de Oh My Zsh para usar este personalizado
ZSH_THEME=""

# Dibujo del prompt:
# Línea 1: ┌── (blanco) seba@kali (verde negrita) ~ (azul)
# Línea 2: └─$ (blanco)
PROMPT=$'%F{white}┌──%f%B%F{green}%n@%m%f%b %F{blue}%~%f\n%F{white}└─%f$ '
export PATH="$HOME/.npm-global/bin:$PATH"

# pnpm
export PNPM_HOME="/home/seba/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# OpenClaw Completion
source "/home/seba/.openclaw/completions/openclaw.zsh"

# opencode
export PATH=/home/seba/.opencode/bin:$PATH
