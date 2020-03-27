# Rotator, scheduler/tracker

## RotatorShell

### Osnovne naredbe

Nakon spajanja na server pokrenite RotatorShell:
```
rs
```

Za prikaz pomoći unesite naredbu `help`:
```
RotatorShell:> help
AVAILABLE COMMANDS

Built-In Commands
        clear: Clear the shell screen.
        exit, quit: Exit the shell.
        help: Display help about available commands.
        history: Display or save the history of previously run commands
        script: Read and execute commands from a file.
        stacktrace: Display the full stacktrace of the last error.

Rotator Shell Batch Exec
        csv-in: Input az/el/duration data points from a CSV file (RFC 4180), set the rotator position accordingly and output a timestamped CSV.
        csv-out: Generate file with az/el/duration data points, suitable as input for 'csv-in' command.

Rotator Shell Simple Commands
        g, get: Get rotator azimuth/elevation.
        s, set: Set rotator azimuth/elevation.
```

Za prikaz pomoći pojedine naredbe unesite `help <cmd>`, npr:
```
RotatorShell:> help set


NAME
	set - Set rotator azimuth/elevation.

SYNOPSYS
	set [-az] int  [-el] int  

OPTIONS
	-az  int
		Azimuth
		[Mandatory]

	-el  int
		Elevation
		[Mandatory]

ALSO KNOWN AS
	s
```

Za izlaz iz aplikacije unesite naredbu `exit` ili `quit`.

### Dohvat azimuta/elevacije

Unesite naredbu `g` ili `get`:
```
RotatorShell:> g
Az: 328, El: 165
```

### Postavljanje azimuta/elevacije

Unesite naredbu `s az el` ili `set az el`:
```
RotatorShell:> set 320 150
Ok. Az: 319, El: 150
```

### Generiranje CSV batch datoteke

TODO

### Učitavanje CSV batch datoteke

TODO

## Konfiguracija tracking softvera

TODO