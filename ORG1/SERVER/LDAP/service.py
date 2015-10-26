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
    lista = ["install", "-y" ,"-q"]
    lista.extend(software)
    bash("apt-get", lista)


def generar_usuario(name, password):
    with open(name+".ldif","w") as ldif:
        ldif.write("# Entrada para los usuarios:\ndn: cn="+name+", ou=owncloud, dc=org31, dc=es\nchangetype: add\nobjectclass: inetOrgPerson\nsn:Perez\ncn: "+name+"cn\nuid: "+name+"uid\nuserPassword: "+password+"\nou:owncloud\n")

if __name__== "__main__":
    # Preparar log.txt
    bash("touch",["log.txt"])
    os.remove("log.txt")
    bash("touch",["log.txt"])

    if os.geteuid() != 0:
        print "Necesitas permisos de super usuario"
        exit(127)

    noupdate = True

    #Evitar la ventana ascii:
    os.environ["DEBIAN_FRONTEND"] = "noninteractive"

    #Instalar paquetes necesarios
    aptget(["slapd", "ldap-utils"])

    os.environ["DEBIAN_FRONTEND"] = ""

    #Copiar la configuracion
    initialdir = os.getcwd()
    shutil.copyfile("./initial.tar.gz","/etc/ldap/initial.tar.gz")
    os.chdir("/etc/ldap/")
    bash("tar", ["-xzf", "initial.tar.gz"])
    os.chdir(initialdir)

    # Generar usuarios:
    generar_usuario("cliente311","manyhue")
    generar_usuario("cliente312","manyhue")
    generar_usuario("cliente313","manyhue")
    exit(0)
