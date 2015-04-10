# Übung 1: C-Programme und Shell-Kommandos

Zu praktisch jedem Betriebssystem gibt es einen Interpreter mit einer eigenen Sprache, in dem elementare Kommandos ausgeführt werden können.
Unter Unix ist dieser Interpreter die Unix-Shell und bietet sehr vielfältige Möglichkeiten.
In dieser einführenden Übung sollen zunächst ein paar Zusammenhänge zwischen einer solchen Shell und der über sie ausgeführten Kommandos und Programme untersucht werden.

**Tipp:**
Weitere Informationen zu den hier benötigten Unix-Systemaufrufen und Unix-Kommandos finden sich in den [Man-Pages](http://de.wikipedia.org/wiki/Manpage) nachgeschlagen werden.


## 1 Argumente auf der Kommandozeile übergeben
Ähnlich, wie einer C-Funktion Parameter übergeben werden können, kann dies auch an ein fertiges Hauptprogramm aus der Kommandozeile der Shell heraus erfolgen. Diese Argumente werden dabei über die Parameter der main-Funktion übergeben:

```c
int main(int argc, char* argv[], char* envp[])
{
    // ...
}
```

Der erste Parameter `argc` entspricht dabei der Anzahl der über die Kommandozeile übergebenen Argumente. Der zweite Parameter `argv` ist ein Zeiger auf ein String-Array und enthält die eigentlichen Argumente als Zeichenketten, welche in der Kommandozeile durch Leerzeichen getrennt werden müssen. Per Definition entspricht dabei `argv[0]` immer dem Namen des aufgerufenen Programms.

1. Schreiben Sie ein Programm `myecho`, das wie der bekannte Shell-Befehl `echo` (in seiner einfachsten Form) alle nachfolgenden Parameter auf der Standardausgabe ausgibt!

2. Als eine Erweiterung dieses Mechanismus lassen sich auch die von der Shell übergebenen Umgebungsvariablen in einem Programm abfragen. Umgebungsvariablen sind Variablen, die einen String-Wert und einen Namen haben, über den auf den String-Wert zugegriffen werden kann. Dazu dient der (oft weggelassene) dritte Parameter der main-Funktion ( `char* envp[]` ), der auf ein String-Array verweist, das alle gesetzten Name-/Werte-Paare in der Form `NAME=WERT` enthält. Das Ende dieser Tabelle ist dabei durch den NULL-Zeiger gekennzeichnet.

    Schreiben Sie analog zum Unix-Kommando `env` ein Programm `myenv`, das alle gesetzten Umgebungsvariablen sowie zusätzlich deren Anzahl auf der Standardausgabe ausgibt!


## 2 Rückgabewerte von Programmen auswerten
Der Rückgabewert der main-Funktion ist bekanntlich eine Ganzzahl vom Typ `int` und tatsächlich lässt sich dieser Wert nach der Beendigung eines Programms über die spezielle Umgebungsvariable `$?` in der Kommandozeile abfragen.

1. Schreiben Sie ein Programm `isset`, das als Kommandozeilenparameter den Namen einer Umgebungsvariable übergeben bekommt und das dann testet, ob der Wert dieser Variable gesetzt ist oder nicht. Ist dies der Fall, so soll das Programm den Wert `0` zurückliefern, andernfalls den Wert `1`.

  **Tipp:** Zur Umgebungsvariablenabfrage können Sie auch folgende Funktion verwenden:
  ```c
  char *getenv(const char *name);
  ```

2. Erweitern Sie das Programm, so dass bei der Angabe der Option `-v` zusätzlich noch der Wert der abgefragten Umgebungsvariablen ausgegeben wird!


### 3 Erzeugen und Ausführen von Prozessen in C

Bei Unix werden neue Prozesse mit dem Systemaufruf `fork` erzeugt:

```c
pid_t fork (void);
```

Der Rückgabewert der fork-Funktion ist `0` für den Kindsprozess, der Elternprozess erhält als Rückgabewert die Prozess-ID des Kindsprozesses. Ein weiteres Programm lässt sich dann aus einem C-Programm heraus zum Beispiel über einen Systemaufruf der exec-Familie durchführen:

```c
int execv(char* path, char* argv[]);
```

1. Schreiben Sie ein Programm, das als Parameter den Namen eines weiteren Programms bekommt und dieses Programm dann sofort mithilfe von `execv()` ausführt!

2. Ergänzen Sie das Programm derart, dass vor der Ausführung des zweiten Programms zunächst mithilfe von `fork()` ein neuer Prozess erzeugt wird! Lassen Sie dabei auch die Prozess-IDs ausgeben!

## 4: Programmierung einer eigenen Shell (Zusatzaufgabe)

1. Erweitern Sie Ihr Programm aus Aufgabe 3 so, dass das auszuführende Programm sowie seine Parameter über die Standardeingabe eingelesen werden!
  
  **Tipp:** Hierzu können Sie zum Beispiel die komfortablen Funktionen der sog. readline-Bibliothek benutzen:
  
  ```c
  #include <readline/readline.h>
  #include <readline/history.h>
  char *readline (const char *prompt);
  void add_history (const char *line);
  ```
2. Lassen Sie den Pfad zu den ausführbaren Programmen durch eine Umgebungsvariable bestimmbar machen! Erlauben Sie auch mehrere, durch `:` getrennte Suchpfade!

3. Unterscheiden Sie bei der Auswertung der Eingaben zwischen eingebauten Funktionen (wie zum Beispiel das Setzen von Umgebungsvariablen) und dem Aufruf von externen Programmen!
