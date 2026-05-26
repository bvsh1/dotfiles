---
titulo: Migración Definitiva de Kali a Arch Linux
fecha: 2026-05-26
etiquetas:
  - linux
  - arch
  - hyprland
  - dotfiles
  - udp
  - telecomunicaciones
---

# 🚀 Guía de Migración: Kali Linux ➡️ Arch Linux + Hyprland

> [!abstract] Resumen del Entorno
> **Hardware:** Intel Core i5 (10ª Gen), 12 GB RAM, SSD 1TB.
> **Objetivo:** Sistema base hiperligero optimizado para Wayland.
> **Stack Visual:** Hyprland + Caelestial Dots.
> **Stack Terminal:** Zsh + Ghostty + Fastfetch (gestionado vía GNU Stow).

---

## 1. Fase de Preparación (Pre-Formateo)

> [!warning] Atención
> El disco de tu notebook será borrado por completo en la siguiente fase.

1. Verifica que tu repositorio en GitHub (`https://github.com/bvsh1/dotfiles.git`) esté al día.
2. Respalda tus llaves SSH, documentos de la universidad y proyectos personales en una unidad externa.
3. Flashea la ISO más reciente de Arch Linux en un pendrive USB.

---

## 2. Instalación del Sistema Base (Archinstall)

> [!info] Conexión a Internet
> Al bootear el USB, si usas Wi-Fi, ejecuta:
> `iwctl` ➡️ `station wlan0 scan` ➡️ `station wlan0 get-networks` ➡️ `station wlan0 connect "Tu_Red"` ➡️ `exit`.

Lanza el instalador guiado:
```bash
archinstall
```

Configura el menú exactamente así:
- **Language / Keyboard:** Tu idioma y distribución (ej. `latam`).
- **Mirrors:** Chile (o la región más cercana).
- **Disk Configuration:** - Selecciona tu SSD de 1TB.
  - Elige **Wipe all selected drives and use a best-effort default partition layout**.
  - Sistema de archivos: **ext4** o **btrfs**.
- **Profile:** - `Profile` ➡️ `Type` ➡️ **Minimal**. *(No selecciones ningún Desktop Environment)*.
- **Network:** **NetworkManager**.
- **User Account:** - Crea tu usuario (`bvsh1`).
  - Selecciona **Yes** para otorgar privilegios `sudo`.

Baja hasta **Install**. Al finalizar, responde **No** a la pregunta de `chroot`, escribe `reboot` y retira el pendrive.

---

## 3. Preparación del Ecosistema y AUR

Inicia sesión en la terminal TTY (pantalla negra) con tu usuario y contraseña.

**Actualizar e instalar la base:**
```bash
sudo pacman -Syu
sudo pacman -S base-devel git stow zsh fastfetch hyprland
```

**Instalar el ayudante AUR (`yay`):**
```bash
git clone [https://aur.archlinux.org/yay.git](https://aur.archlinux.org/yay.git)
cd yay
makepkg -si
cd ..
rm -rf yay
```

**Instalar emulador de terminal (Ghostty):**
```bash
yay -S ghostty
```

---

## 4. Entorno Gráfico (Caelestial Dots)

> [!danger] Orden Crítico
> Instala esto **antes** de restaurar tus dotfiles personales. Si lo haces al revés, el script sobrescribirá tu configuración de terminal.

**1. Clonar e instalar:**
```bash
git clone [https://github.com/kndndrj/caelestial.git](https://github.com/kndndrj/caelestial.git) ~/Descargas/caelestial
cd ~/Descargas/caelestial
chmod +x install.sh
./install.sh
```

**2. Adaptar Hyprland a tu flujo de trabajo:**
```bash
nano ~/.config/hypr/hyprland.conf
```
- Busca `$terminal` y cámbialo a: `$terminal = ghostty`
- Verifica/crea la sección de gestos para el panel táctil:
  ```text
  gestures {
      workspace_swipe = true
      workspace_swipe_fingers = 3
  }
  ```
*(Guarda con `Ctrl + O`, `Enter`, y sal con `Ctrl + X`)*.

---

## 5. Restauración de Dotfiles (GNU Stow)

**1. Clonar tu repositorio:**
```bash
git clone [https://github.com/bvsh1/dotfiles.git](https://github.com/bvsh1/dotfiles.git) ~/dotfiles
```

**2. Limpiar conflictos:**
```bash
rm -rf ~/.zshrc
rm -rf ~/.config/ghostty
rm -rf ~/.config/fastfetch
```

**3. Crear enlaces simbólicos:**
```bash
cd ~/dotfiles
stow zsh
stow ghostty
stow fastfetch
```

**4. Instalar núcleo de Oh My Zsh:**
```bash
sh -c "$(curl -fsSL [https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh](https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh))"
```
*(Si este script crea un nuevo `.zshrc` y renombra el tuyo, borra el nuevo y vuelve a ejecutar `stow zsh` desde tu carpeta dotfiles).*

**5. Cambiar Shell predeterminada:**
```bash
chsh -s $(which zsh)
```

---

## 6. Toques Finales

Ejecuta `reboot`. Al iniciar, en el gestor de inicio de sesión (SDDM/Greetd), asegúrate de tener **Hyprland** seleccionado. Entrarás a tu nuevo escritorio con gestos Wayland habilitados, consumiendo menos de 1GB de tu RAM, y con Ghostty configurado exactamente como lo dejaste.

> [!tip] Mini Cheat-Sheet: Pacman vs APT
> 
> | Acción | Arch (`pacman` / `yay`) | Kali (`apt`) |
> | :--- | :--- | :--- |
> | Actualizar TODO | `yay -Syu` | `sudo apt update && sudo apt upgrade` |
> | Instalar | `yay -S paquete` | `sudo apt install paquete` |
> | Buscar | `yay -Ss paquete` | `apt search paquete` |
> | Eliminar + dep. | `sudo pacman -Rs paquete` | `sudo apt autoremove paquete` |
> | Limpiar caché | `sudo pacman -Scc` | `sudo apt clean` |