apt-get install -y nagios3

# Poner contraseña alumno
# Usuario por defecto: nagiosadmin

cp disk.cfg /etc/nagios-plugins/config/
cp bandwith.cfg /etc/nagios/conf.d/
cp check_bandwith /usr/lib/nagios/plugins/


service nagios3 restart

# Problemas de DISCO, ir a disk.cfg y añadir al final de command_line de check_disk y check_all_disks

# -A -i '.gvfs'

