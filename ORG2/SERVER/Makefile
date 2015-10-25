
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

test:
	sh test
	cd SNMP; sh test
	cd VOIP; sh test


.PHONY: all network snmp voip test
