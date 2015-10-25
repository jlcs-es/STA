
all: network snmp test

network:
	sh network

snmp:
	cd SNMP; \
	python agente.py

test:
	sh test
	cd SNMP; sh test


.PHONY: all network snmp test
