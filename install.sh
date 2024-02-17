#!/bin/bash

show_whiptail_dialog() {
    whiptail --title "$1" --yesno "$2" 10 60
}

mensaje_inicio="Hola, bienvenido a PHPTerm.\nEste programa le ayudará a instalar y configurar PHPTerm.\nPara continuar, pulsa en continuar, si por lo contrario quiere cerrar el instalador, dabe a Cancelar"

show_whiptail_dialog "PHPTerm Instalador" "$mensaje_inicio"

respuesta_inicial=$?

if [ $respuesta_inicial -eq 0 ]; then
    mensaje_dependencias="El programa instalará las siguientes dependencias:\n\nPHP\nwget"
    show_whiptail_dialog "Dependencias" "$mensaje_dependencias"

    respuesta_dependencias=$?
    if [ $respuesta_dependencias -eq 0 ]; then
        sudo apt-get -y install php wget

        wget https://github.com/Danucosukosuko/EmuTerm/raw/main/Emuterm.zip -O Emuterm.zip
        mkdir -p /home/$(whoami)/PHPTerm
        unzip Emuterm.zip -d /home/$(whoami)/PHPTerm

        echo "[Unit]
Description=Servicio PHPTerm
After=network.target

[Service]
ExecStart=/usr/bin/php -S 0.0.0.0:9000 -t /home/$(whoami)/PHPTerm
Restart=always

[Install]
WantedBy=multi-user.target" | sudo tee /etc/systemd/system/phpterm.service > /dev/null

        sudo systemctl enable phpterm
        sudo systemctl start phpterm

        mensaje_final="PHPTerm instalado y configurado correctamente.\nEl servicio se está ejecutando en http://localhost:9000\nDesea que el servicio PHPTerm se autoinicie?"
        show_whiptail_dialog "Instalación Completa" "$mensaje_final"
    else
        echo "El programa ha sido cancelado."
        exit 1
    fi
else
    echo "El programa ha sido cancelado."
    exit 1
fi
