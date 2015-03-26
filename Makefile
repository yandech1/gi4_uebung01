all: myenv myecho

myecho: myecho.c
	gcc -o $@ $<

myenv: myenv.c
	gcc -o $@ $<

clean:
	rm -f myecho myenv
