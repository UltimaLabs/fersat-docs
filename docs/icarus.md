# Icarus

## Korištene tehnologije

### Frontend aplikacija

- [Angular](https://angularjs.org/) - TypeScript frontend framework    
- [CesiumJS](https://cesium.com/platform/cesiumjs/) - JavaScript library za kreiranje 3D globusa i 2D mapa u web pregledniku 
- [SatelliteJS](https://github.com/shashwatak/satellite-js) - SGP4/SDP4 library (SGP4/SDP4 - Simplified perturbations models)

### Backend aplikacija

- [Spring Boot](https://spring.io/projects/spring-boot) - Spring framework ekstenzija
- [Spring Data JPA](https://spring.io/projects/spring-data-jpa) - JPA (Java Persistence API) Spring framework dodatak za pristup bazi podataka
- [Hibernate ORM](https://hibernate.org/orm/) - ORM (objektno-relacijsko mapiranje) framework za mapiranje objektno orijentiranog modela domene u relacijsku   bazu podataka
- [Keycloak](https://www.keycloak.org/) - Autorizacijski server i implementacija OAuth 2.0 protokola autorizacije      
- [FlywayDB](https://flywaydb.org/) - Java framework za migraciju baze podataka
- [Gradle](https://gradle.org/) - Build automation alat

### Baza podataka:

- [PostgreSQL](https://www.postgresql.org/)

## Funkcionalnosti

### Definicija satelita i zemaljskih postaja

Unutar aplikacije moguće je definiranje i ažuriranje satelita i zemaljskih postaja sa svim potrebnim parametrima za njihov pravilan prikaz i upravljanje. 

Definirani sateliti osim nužnih informacija o svom identitetu, sadrže i popis slijedećih *n* preleta nad određenim zemaljskim postajama i ostalih zakazanih događaja te popis svih zemaljskih postaja koje taj satelit prate. Pri definiciji i ažuriranju satelita moguće je unijeti i custom TLE (*Two-line element set*) parametre.

Definirane zemaljske postaje sadrže svoje geografske koordinate, parametre nužne za upravljanje primopredajnikom i rotatorom, adresu SatTrackAPI REST servisa sa kojeg dobiva scheduling/tracking podatke te popis svih praćenja satelita i slijedećih *n* preleta satelita koje prate.

Između ostalog, svaka zemaljska postaja sadrži informaciju o tome jesu li njeni podaci spremljeni u konfiguraciju Sancho *scheduling/tracking* servisa te, ako nisu, moguće ih je spremiti kako bi servis radio na željeni način. Važno je napomenuti da iako je moguće definirati *n* različitih zemaljskih postaja, samo jedna zemaljska postaja može u isto vrijeme biti aktivna tj. Sancho servis je konfiguriran njenim podacima.

### Upravljanje i definicija praćenja satelita

Unutar zemaljske postaje moguće je definirati *n* praćenja satelita koji postoje u sustavu. Svako takvo praćenje sadrži podatke potrebne za njegov prikaz u stvarnom vremenu na kontrolnoj ploči i ispravan rad rotatora i primopredajnika kada je ono aktivno. Pri definiciji i ažuriranju pojedinog praćenja satelita moguće je također omogućiti ili onemogućiti upravljanje rotatorom ili primopredajnikom.

Svako definirano praćenje satelita moguće je aktivirati i deaktivirati. Deaktivirana praćenja se ne uzimaju u obzir pri prikazu u stvarnom vremenu na kontrolnoj ploči ili upravljanju rotatora ili primopredajnika. Unutar popisa je također moguće promijeniti redoslijed praćenja satelita (*drag&drop*) i na taj način definirati njihove prioritete koje Sancho servis uzima u obzir kod praćenja.

### Interaktivni prikaz praćenih satelita na kontrolnoj ploči

Icarus aplikacija sadržava kontrolnu ploču sa prikazom lokacija praćenih satelita u stvarnom vremenu. Ovisno o odabranoj zemaljskoj postaji, na svojim trenutnim lokacijama se prikazuju sateliti koje ona prati. Također se može odabrati opcija fiksiranja kamere na odabrani satelit i iscrtavanje njegove putanje do nekoliko dana unaprijed.

## Konfiguracija

Icarus aplikacija konfigurira se ažuriranjem *.yml* datoteka u `/opt/ultima/icarus/config/` direktoriju.

- `application.yml` - konfiguracijske vrijednosti komponenata sustava (Spring, Keycloak, Flyway i dr.)
- `application-production.yml` - konfiguracijske vrijednosti specifične za produkcijsko okruženje (npr. config file paths)
- `icarus.yml` - konfiguracijske vrijednosti aplikacije (*sancho* parametri, postavke kontrolne ploče i dr.)
- `persistence.yml` - konfiguracijske vrijednosti potrebne za spajanje na bazu podataka 
- `security.yml` - PKI (Public Key Infrastructure) konfiguracijske vrijednosti, login i logout parametri
- `/pagination` direktorij sadrži *.yml* datoteke koje sadrže konfiguraciju paginacije pojedinih pregleda podataka u aplikaciji    
- `/lang` direktorij sadrži *.yml* datoteke s prijevodima određenih poruka, naziva ili naslova unutar Java *backend* aplikacije
