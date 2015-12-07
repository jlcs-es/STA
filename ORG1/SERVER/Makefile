
all: network snmp voip test

network:
	sh network

snmp:
	cd SNMP; \
	python manejador.py; \
	python agente.py

#Evitar que los scripts fallen si referencian ficheros con rutas relativas
voip:
	cd VOIP; \
	sh install; \
	sh config

owncloud:
	cd LDAP; \
	python service.py; \
	cd ../OWNCLOUD; \
	sh install.sh; \
	cd ../CERTS; \
	sh config.sh

ipsec:
	cd IPSEC; \
	sh install.sh

test:
	sh test
	cd SNMP; sh test
	cd VOIP; sh test


.PHONY: all network snmp voip owncloud ipsec test
