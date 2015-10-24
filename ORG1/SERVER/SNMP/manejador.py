#!/usr/bin/python
# -*- coding: utf-8 -*-
import shutil
import subprocess
import os
import sys

def bash(command, args):
    proc = subprocess.Popen(command + " " + " ".join(args), shell=True, stdin=None, stdout=open("log.txt","a"), stderr=open(os.devnull,"wb"), executable="/bin/bash")
    proc.wait()

def aptget(software):
    global noupdate
    if software is str:
        software = software.split(" ")
    if noupdate:
        bash("apt-get", ["update"])
        noupdate = False
    lista = ["install", "-y"]
    lista.extend(software)
    bash("apt-get", lista)


if __name__== "__main__":
    # Preparar log.txt
    bash("touch",["log.txt"])
    os.remove("log.txt")
    bash("touch",["log.txt"])

    if os.geteuid() != 0:
        print "Necesitas permisos de super usuario"
        exit(127)

    noupdate = True

    #Instalar paquetes necesarios
    aptget(["snmpd", "snmp", "snmp-mibs-downloader"])

    #Copiar la configuracion
    shutil.copyfile("./snmp.conf","/etc/snmp/snmp.conf")
    shutil.copyfile("./snmptrapd.conf","/etc/snmp/snmptrapd.conf")
    bash("service", ["snmpd","restart"])
    bash("gnome-terminal", ["snmptrapd", "-f", "-Leo"]) #TODO: sustituir por la terminal de linux correcta

    exit(0)
