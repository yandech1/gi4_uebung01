CC = gcc

.PHONY: all default clean

default: myecho

all: myecho

myecho: myecho.c

myenv: myenv.c

clean:
	rm -f myecho
