# RotatorShell - ručno/batch upravljanje rotatorom

!!! warning "Mogućnost konflikta - RotatorShell i Sancho"
    Prije rada s `RotatorShell` aplikacijom isključite tracking servis `sancho` zbog konflikta kod pristupa rotatoru:<br>
    `sudo systemctl stop sancho`
    <br><br>
    Kasnije ga ne zaboravite ponovno pokrenuti:<br>
    `sudo systemctl start sancho`

## Konfiguracija

Aplikacija `RotatorShell` konfigurira se ažuriranjem datoteke `/opt/ultima/rotator-shell/application.yml`:
```
logging:
  level:
    root: ERROR

shell:
  out:
    info: CYAN
    success: GREEN
    warning: YELLOW
    error: RED

rotatorshell:
  rotctldHost: localhost # rotctld host
  rotctldPort: 4533 # rotctld port
  setPosWaitStep: 200 # milliseconds
  setPosWaitNumSteps: 3
  setPosWaitTimeout: 120 # seconds
```

!!! note ""
    Datoteku možete ažurirati kroz `nano` editor: <br>
    `sudo nano /opt/ultima/rotator-shell/application.yml`<br>
    Za snimanje izmjena stisnite `CTRL-O`, a za izlaz iz editora `CTRL-X`.

Bitna sekcija je `rotatorshell`:

 - `rotctldHost` - hostname za komunikaciju s `rotctld` servisom
 - `rotctldPort` - TCP port za komunikaciju s `rotctld` servisom
 - `setPosWaitStep` - koliko često aplikacija provjerava je li rotator u mirovanju
 - `setPosWaitNumSteps` - koliko puta rotator mora prijaviti istu poziciju prije no što proglasimo da je u mirovanju
 - `setPosWaitTimeout` - timeout kod čekanja rotatora 

`setPosWait` parametri važni su zbog protokola za komunikaciju s rotatorom. Naime, nakon slanja naredbe za setiranje pozicije, rotator će odmah vratiti povratni status je li naredba prihvaćena ili ne. Kako bi utvrdili da je rotator stao, njegova pozicija se periodički provjerava kroz petlju, s korakom od `setPosWaitStep` milisekundi. Nakon što rotator nekoliko (`setPosWaitNumSteps`) puta prijavi istu poziciju, proglasit ćemo da je stao. Zbog neprecizne ADC konverzije može vratiti različite (az, el) vrijednosti za istu poziciju pa aplikacija može zaključiti da se rotator još uvijek kreće i tako je moguća (iako ne i vjerojatna) beskonačna petlja. Iz ovog razloga se petlja terminira nakon `setPosWaitTimeout` sekundi. `setPosWaitTimeout` ne smije biti manji od maksimalnog vremena koje je rotatoru potrebno za normalno izvršenje najvećeg pomaka, recimo 0 - 359 stupnjeva po azimutu.

## Osnovne naredbe

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

## Dohvat azimuta/elevacije

Unesite naredbu `g` ili `get`:
```
RotatorShell:> g
Az: 328, El: 165
```

## Postavljanje azimuta/elevacije

Unesite naredbu `s <az> <el>` ili `set <az> <el>`:
```
RotatorShell:> set 320 150
Ok. Az: 319, El: 150
```

## Generiranje CSV batch datoteke

Unesite naredbu `csv-out <azimut-od>  <azimut-do>  <elevacija-od>  <elevacija-do>  <pauza>  <afr|efr>  <naziv-datoteke>`, npr:
```
RotatorShell:> csv-out 0 359 0 5 3 afr csv-out.csv
Written output file: csv-out.csv
```

Gornja naredba generirat će datoteku za pomak 0 - 359 stupnjeva po azimutu i 0 - 5 stupnjeva elevacije. Na svakoj poziciji će se rotator zadržati 3 sekunde. `afr` parametar znači prvo pomak po azimutu: 0, 1, 2, 3 ... 359, resetiranje azimuta na 0, pomak elevacije na 1, pa ponovno pomak po azimutu 0, 1, 2 ... 359. Naziv datoteke bit će `csv-out.csv`. Generiranu datoteku možete [preuzeti ovdje](assets/files/rotator_shell/csv-out.csv).

Generiranje datoteke za pomak 0 - 359 stupnjeva po azimutu i 0 - 90 stupnjeva elevacije:
```
RotatorShell:> csv-out 0 359 0 90 3 afr csv-out.csv
Written output file: csv-out.csv
```

## Učitavanje CSV batch datoteke

Ulazna datoteka mora biti formatirana suklano [gornjem primjeru](assets/files/rotator_shell/csv-out.csv) generiranom pomoću naredbe `csv-out`:
```
azimuth,elevation,duration
0,0,3
1,0,3
2,0,3
3,0,3
4,0,3
5,0,3
...
```
Zaglavlje (header) CSV datoteke mora biti prisutno. Ukoliko neki od redaka s podacima ne sadržava tri vrijednosti, aplikacija će ga ignorirati. Parametar `duration` ne može biti manji od jedne sekunde. CSV delimiter je zarez. Datoteku možete generirati naredbom `csv-out` ili na neki drugi način i [kopirati na server](spajanje.md#kopiranje-datoteka-kroz-sshscp). 

Unesite naredbu `csv-in <ulazna-datoteka>  <izlazna-datoteka>`, npr:
```
RotatorShell:> csv-in ulaz.csv izlaz.csv
Input data points: 36
Working, please wait...
Written output file: izlaz.csv
```

Generirana izlazna datoteka sadržavat će sljedeće vrijednosti:

 - `azimuth` - azimut trenutne pozicije
 - `elevation` - elevacija trenutne pozicije
 - `begin_epoch_millis` - *Unix epoch* (ms) početka mirovanja rotatora na poziciji
 - `end_epoch_millis` - *Unix epoch* (ms) kraja mirovanja rotatora na poziciji
 - `begin_timestamp` - vremenska oznaka (string) početka mirovanja rotatora na poziciji
 - `end_timestamp` - vremenska oznaka (string) kraja mirovanja rotatora na poziciji

!!! warning "Azimut i elevacija u izlaznoj datoteci"
    `azimuth` i `elevation` vrijednosti u izlaznoj datoteci mogu, i često hoće, donekle odstupati od očekivanih vrijednosti zadanih kroz ulaznu datoteku. Razlog je u tome što se dohvaćaju kroz očitanje s rotatora nakon što se isti smjesti u traženu poziciju. Primjerice, nakon slanja naredbe za pozicioniranje na (az: 5, el: 5), rotator nakon pomaka može prijaviti poziciju (az: 6, el: 7). Uzmite ovu činjenicu u obzir kod obrade podataka izlazne datoteke.<br>
    Primjer izlazne datoteke za pomak azimuta 0 - 5 i elevacije 0 - 5 možete [preuzeti ovdje](assets/files/rotator_shell/izlaz.csv).

!!! note "Nazivi datoteka"
    Nazivi ulaznih i izlaznih datoteka mogu biti relativni u odnosu na direktorij u kojem ste pokrenuli naredbu `rs` (npr. `ulaz.csv`, `izlaz.csv`) ili apsolutni (npr. `/tmp/ulaz.csv`, `/home/korisnik/izlaz.csv`).

    Trenutni direktorij na serveru možete prikazati pomoću naredbe `pwd` u Linux terminalu (ne u aplikaciji `rs`).

    Ako `rs` ne može zapisati izlaznu datoteku, vjerojatno nemate dovoljna prava za pisanje u njenom odredišnom direktoriju. Pravo pisanja uvijek imate u svom korisničkom direktoriju (`/home/<korisnicko-ime>`) i direktoriju `/tmp`.
