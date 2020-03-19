# Oprema

 - Primopredajnik: [ICOM IC-9700](https://www.icomamerica.com/en/products/amateur/hf/9700/default.aspx)
 - Antenski rotator: [Yaesu G-5500](https://www.yaesu.com/indexVS.cfm?cmd=DisplayProducts&ProdCatID=104&encProdID=79A89CEC477AA3B819EE02831F3FD5B8)
 - USB interface za rotator: [EA4TX ARS-USB](https://ea4tx.com/en/products-page/ars-usb/)
 - VHF antena: TBD
 - UHF antena: TBD

# Server (fersat1)
 
 - Operativni sustav: [CentOS 7 GNU/Linux](https://www.centos.org/)
 - VPN: [OpenVPN](https://community.openvpn.net/openvpn)
 - Web server: [nginx](https://www.nginx.com/)
 - Softverski paket za upravljanje rotatorom i primopredajnikom [Hamlib](https://hamlib.github.io/); koristi se [rotctld](https://manned.org/rotctld/15b1f5b8) komponenta za komunikaciju s rotatorom.
 - [SatTrackAPI](https://github.com/UltimaLabs/sattrackapi) - REST servis smješten na eksternom serveru, koristi se za dohvat scheduling/tracking podataka.
 - [Sancho](https://github.com/UltimaLabs/sancho/) - servis za scheduling i tracking satelita. Podatke dohvaća kroz SatTrackAPI. S rotatorom komunicira kroz `rotctld`.
 - [RotatorShell](https://github.com/UltimaLabs/rotatorshell) - shell aplikacija za ručno ili batch upravljanje rotatorom.


