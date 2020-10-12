# FERSAT dokumentacija

Projekt FERSAT uključuje izradu, lansiranje i korištenje jednog nanosatelita u orbiti na visini između 500 i 650 kilometara u razdoblju od tri godine. Za više detalja molimo posjetite [službene stranice projekta FERSAT](https://www.fer.unizg.hr/zkist/FERSAT).

Ovdje možete pronaći dokumentaciju softverskih komponenata zemaljske stanice:

 - [Sancho](https://github.com/UltimaLabs/sancho/) - aplikacija za scheduling i tracking satelita. Podatke dohvaća kroz eksterni [SatTrackAPI](https://github.com/UltimaLabs/sattrackapi) servis.
 - [RotatorShell](https://github.com/UltimaLabs/rotatorshell) - shell aplikacija za ručno ili batch upravljanje rotatorom.

## Sadržaj

 1. [Oprema, server](oprema_server.md)
 2. [Spajanje na server (OpenVPN, SSH)](spajanje.md)
 3. [Rotator](rotator.md)
 4. [Scheduler/tracker](tracker.md)
 5. [AX.25/APRS](ax25.md)

## Ažuriranje dokumentacije - TL;DR

 - [Source repozitorij](https://github.com/UltimaLabs/fersat-docs/) nalazi se na GitHub-u, pull request-i su dobrodošli.
 - Dokumentacija se nalazi u `/docs` direktoriju. Format je [Markdown](https://www.markdownguide.org/basic-syntax/), za konverziju u statički HTML koristi se [MkDocs](https://www.mkdocs.org/).
 - Za dodavanje novih stranica ažurirajte `mkdocs.yml`, rubrika `nav`.