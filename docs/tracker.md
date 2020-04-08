# Sancho - scheduling/tracking servis

## Konfiguracija

`sancho` servis konfigurira se ažuriranjem datoteke `/opt/ultima/sancho/application.yml`. Za detaljni opis važnih parametara [kliknite ovdje](https://github.com/UltimaLabs/sancho/blob/master/README.md#configuration).
Pod sekcijom `satelliteData` možete definirati jedan ili više satelita koje želite pratiti. Primjer za ISS:
```
    - id: 98067A
      name: "ISS"
      radioFrequency: 137.1
      minElevation: 15.0
      trackingElevationThreshold: 20.0
      stepSize: 1
      rotatorEnabled: true
      satRiseShellCmdTemplate: ""
      satSetShellCmdTemplate: ""
```

!!! note ""
    Datoteku možete ažurirati kroz `nano` editor: <br>
    `sudo nano /opt/ultima/sancho/application.yml`<br>
    Za snimanje izmjena stisnite `CTRL-O`, a za izlaz iz editora `CTRL-X`.

!!! warning "Restart nakon izmjene konfiguracije"
    Nakon ažuriranja konfiguracijske datoteke potrebno je restartati servis:<br>
    `sudo systemctl restart sancho`


## Pregled logova

Za pregled loga servisa unesite sljedeću naredbu:

```
sudo journalctl -u sancho
```

Za navigaciju kroz log možete koristiti tipke `PageUp`, `PageDown`, `Home` i `End`. Za izlaz iz pregleda stisnite tipku `q`.
