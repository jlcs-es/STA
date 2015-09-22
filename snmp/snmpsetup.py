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

    uso = "Uso: agente|manejador"

    if os.geteuid() != 0:
        print "Necesitas permisos de super vaca"
        exit(127)

    if len(sys.argv) < 2:
        print uso
        exit(0)

    noupdate = True

    if (sys.argv[1] == "agente"):
        aptget(["snmpd", "snmp", "snmp-mibs-downloader"])
        bash("service", ["snmpd","stop"])
        #TODO: Habrá que cambiar el SYSTEM INFORMATION con la información de la Organización
        shutil.copyfile("./snmpd.conf","/etc/snmp/snmpd.conf")
        bash("service", ["snmpd","restart"])
    elif (sys.argv[1] == "manejador"):
        aptget(["snmp", "snmp-mibs-downloader"])
        shutil.copyfile("./snmp.conf","/etc/snmp/snmp.conf")
    else:
        print uso
        exit(127)