
all: network snmp voip test

network:
	sh network

snmp:
	#TODO SNMP: python SNMP/servicios.py

#Evitar que los scripts fallen si referencian ficheros con rutas relativas
voip:
	cd VOIP; \
	sh install; \
	sh config

test:
	sh test
	cd VOIP; sh test


.PHONY: all network snmp voip test
