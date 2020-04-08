# Spajanje na server - OpenVPN, SSH

## OpenVPN

### Windows

- Preuzmite i instalirajte [OpenVPN](https://openvpn.net/community-downloads/), Windows installer.
- Od administratora/ice sustava dobit ćete datoteke potrebne za spajanje:
    - `fersat.ovpn` - konfiguracijska datoteka ([primjer](assets/files/openvpn/fersat_win_primjer.ovpn))
    - `ta.key` - OpenVPN statički ključ
    - `ca.crt` - CA certifikat
    - `korisnicko_ime.crt` - korisnički certifikat
    - `korisnicko_ime.key` - korisnički privatni ključ
- Navedene datoteke kopirajte u `C:\Program Files\OpenVPN\config`.
- Pokrenite OpenVPN GUI i spojite se na server (`Connect`).

### Linux

- Instalirajte OpenVPN paket na način prikladan za distribuciju koju koristite, npr.
    - `sudo apt-get install openvpn` ili 
    - `sudo yum install openvpn`
- Od administratora/ice sustava dobit ćete datoteke potrebne za spajanje:
    - `fersat.conf` - konfiguracijska datoteka ([primjer](assets/files/openvpn/fersat_linux_primjer.conf))
    - `ta.key` - OpenVPN statički ključ
    - `ca.crt` - CA certifikat
    - `korisnicko_ime.crt` - korisnički certifikat
    - `korisnicko_ime.key` - korisnički privatni ključ
- Navedene datoteke kopirajte u direktorij po želji.
- Spojite se na server: `sudo openvpn fersat.conf`. Molimo konzultirajte dokumentaciju svoje Linux distribucije ukoliko želite konfigurirati spajanje kroz grafičko sučelje.

## SSH

### Windows - PuTTY

- Preuzmite i instalirajte [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html), Windows installer.
- Generirajte par SSH ključeva pomoću `PuTTYgen` aplikacije:
    - odaberite 2048 bit RSA ključ
    - kliknite na gumb "Generate" <br><br>
    ![Generiranje SSH ključeva](assets/img/putty/01-puttygen-generate.jpg)
    - kliknite na "Save private key" i snimite privatni ključ kao "PPK" (PuTTY Private Key) datoteku. <br><br>
    ![Snimanje privatnog ključa](assets/img/putty/02-puttygen-save-ppk.jpg)
    - Kopirajte javni ključ (copy/paste) i dostavite ga e-mailom administratoru/ici. <br><br>
    ![Copy/paste javnog ključa](assets/img/putty/03-puttygen-copy-public-key.jpg)
    - Čekajte potvrdu da je javni ključ dodan na server.
    - Privatni ključ je tajan i ne šaljete ga nikome.
- Pokrenite `PuTTY` aplikaciju
- Pod "Session" / "Host Name (or IP address)" unesite `10.8.19.1` <br><br>
![Host Name unos](assets/img/putty/04-putty-hostname.jpg)
- Pod "Connection" / "Data" / "Auto-login username" unesite vaše korisničko ime <br><br>
![Username unos](assets/img/putty/05-putty-username.jpg)
- Pod "Connection" / "SSH" / "Auth" / "Private key file for authentication" kliknite na "Browse..." i odaberite prethodno generiranu PPK datoteku. <br><br>
![Odabir privatnog ključa](assets/img/putty/06-putty-load-privkey.jpg)
- Vratite se na "Session" i upišite npr. `fersat` pod "Saved Sessions"; kliknite na "Save". <br><br>
![Snimanje konekcije](assets/img/putty/07-putty-save-session.jpg)
- Pod "Session" / "Saved Sessions" dvaput kliknite na `fersat` kako bi se spojili na server. <br><br>
![Snimljene konekcije](assets/img/putty/08-putty-saved-sessions.jpg)
- `fersat` će biti dostupan pod "Session" / "Saved Sessions" kod svakog idućeg pokretanja `PuTTY` aplikacije.

### Linux

- Ukoliko već nemate par SSH ključeva, generirajte ga:
    - `ssh-keygen -t rsa -b 2048`
- Javni ključ (obično sadržaj datoteke `~/.ssh/id_rsa.pub`) dostavite e-mailom administratoru/ici.
- Čekajte potvrdu da je javni ključ dodan na server.
- Spojite se na server:
    - `ssh korisnicko_ime@10.8.19.1`
- Alternativno, možete ažurirati datoteku `~/.ssh/config` i dodati sljedeće linije:
```
Host fersat
    HostName 10.8.19.1
	User korisnicko_ime
	Port 22
```
- Nakon ažuriranja `~/.ssh/config` datoteke, na server se možete spojiti na sljedeći način:
    - `ssh fersat`

!!! note "Lokacija privatnog ključa"
    Ukoliko se ne koristi default lokacija privatnog ključa (`~/.ssh/id_rsa`), morate je eksplicitno navesti kod spajanja: <br>
    `ssh -i /putanja/do/id_rsa korisnicko_ime@10.8.19.1`<br>
    ili dodati liniju `IdentityFile /putanja/do/id_rsa` u `~/.ssh/config` datoteku.

### Prekidanje SSH konekcije

Stisnite `CTRL-D` ili unesite naredbu `exit`.


## Kopiranje datoteka kroz SSH/SCP

Ovdje opisani primjeri mogu se koristiti za prijenos CSV datoteka za `RotatorShell`.

### Windows 

!!! note "PSCP i PuTTY konfiguracija"
    U sljedećim primjerima pretpostavlja se da je prethodno kroz PuTTY definirana konekcija naziva `fersat` (pod "Session" / "Saved Sessions"). Ovo je važno iz razloga što iz tako definirane konekcije `pscp` dohvaća adresu servera, korisničko ime i privatni SSH ključ za autentikaciju. <br><br>
    Naredbe se upisuju u `Command Prompt`.

Kopiranje lokalne datoteke `c:\temp\input.csv` u serverski direktorij `/home/korisnik/`:
```
pscp c:\temp\input.csv fersat:/home/korisnik/
```

Kopiranje lokalne datoteke `c:\temp\input.csv` u serverski direktorij `/home/korisnik/` i preimenovanje datoteke:
```
pscp c:\temp\input.csv fersat:/home/korisnik/podaci.csv
```

Kopiranje serverske datoteke `/home/korisnik/output.csv` u lokalni direktorij `c:\temp`:
```
pscp fersat:/home/korisnik/output.csv c:\temp
```

Kopiranje serverske datoteke `/home/korisnik/output.csv` u lokalni direktorij `c:\temp` i preimenovanje datoteke:
```
pscp fersat:/home/korisnik/output.csv c:\temp\podaci2.csv
```

### Linux

!!! note ""
    U sljedećim primjerima pretpostavlja se da je u datoteku `~/.ssh/config` dodan zapis za `fersat` host.

Kopiranje lokalne datoteke `/tmp/input.csv` u serverski direktorij `/home/korisnik/`:
```
scp /tmp/input.csv fersat:/home/korisnik/
```

Kopiranje lokalne datoteke `/tmp/input.csv` u serverski direktorij `/home/korisnik/` i preimenovanje datoteke:
```
scp /tmp/input.csv fersat:/home/korisnik/podaci.csv
```

Kopiranje serverske datoteke `/home/korisnik/output.csv` u lokalni direktorij `/tmp`:
```
scp fersat:/home/korisnik/output.csv /tmp
```

Kopiranje serverske datoteke `/home/korisnik/output.csv` u lokalni direktorij `/tmp` i preimenovanje datoteke:
```
scp fersat:/home/korisnik/output.csv /tmp/podaci2.csv
```
