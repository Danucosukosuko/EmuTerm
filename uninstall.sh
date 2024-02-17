#!/bin/bash

show_whiptail_dialog() {
    whiptail --title "$1" --msgbox "$2" 10 60
}

# Detiene y deshabilita el servicio PHPTerm
sudo systemctl stop phpterm
sudo systemctl disable phpterm

# Elimina el directorio de instalación de PHPTerm
rm -rf /home/$(whoami)/PHPTerm

# Elimina el archivo de servicio systemd
sudo rm -f /etc/systemd/system/phpterm.service

# Muestra un mensaje de desinstalación completa
mensaje_desinstalacion="PHPTerm ha sido desinstalado correctamente.\n\nSi deseas reinstalar PHPTerm, puedes ejecutar el script de instalación nuevamente."
show_whiptail_dialog "Desinstalación Completa" "$mensaje_desinstalacion"
