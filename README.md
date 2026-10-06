# Joost OS

Persoonlijk werkbesturingssysteem voor de AI-rol binnen Audit & Assurance:
planning, urenregistratie, taken, overleggen, declaraties, doelen, KPI's,
kennis, AI-tips, ideeën, ontwikkeling en weekreview.

Eén HTML-bestand, geen build, geen server, geen afhankelijkheden. Alle
gegevens blijven in de browser van de gebruiker en gaan nergens heen.

---

## Wat hier staat

| Bestand | Waarvoor |
|---|---|
| `index.html` | De hele applicatie |
| `manifest.webmanifest` | Maakt hem installeerbaar als bureaublad-app |
| `sw.js` | Service worker: offline openen en installeerbaarheid |
| `icon-192.png`, `icon-512.png` | App-icoon |
| `icon-maskable-512.png` | Icoon met marge, voor ronde/afgeronde maskers |
| `apple-touch-icon.png`, `favicon-32.png` | iOS-startscherm en browsertabblad |
| `.nojekyll` | Zegt GitHub Pages de bestanden ongemoeid te laten |

---

## Publiceren met GitHub Pages

Je hebt geen git nodig; het kan volledig via de webinterface.

1. Maak een repository aan, bijvoorbeeld **`joost-os`**.
2. **Add file → Upload files**, sleep alle bestanden uit deze map erin, en commit.
3. **Settings → Pages**. Zet *Source* op **Deploy from a branch**, kies de
   branch (`main`) en map **`/ (root)`**. Opslaan.
4. Na een minuut of twee staat hij op
   `https://<organisatie>.github.io/joost-os/`.

> **Let op bij een privérepository.** GitHub Pages vanaf een privérepo werkt
> alleen met GitHub Team of Enterprise. Op een gratis account wordt de site
> openbaar, ook als de repo privé staat. De app bevat geen gegevens — die
> blijven in je browser — maar de pagina is dan wel door iedereen met de URL
> te openen. `index.html` stuurt zoekmachines weg met `noindex`, maar dat is
> een verzoek, geen slot.

---

## Installeren als bureaublad-app

Open de URL in **Edge** of **Chrome**. Rechts in de adresbalk verschijnt een
installatie-icoon (een scherm met een pijl), of via het menu
**… → Apps → Deze site als app installeren**.

Daarna staat Joost OS als los venster in je startmenu en op je taakbalk, met
eigen icoon en zonder adresbalk. Hij opent ook zonder internetverbinding.

Op iOS: Safari → Deel → *Zet op beginscherm*.

---

## Je bestaande gegevens meenemen

**Lees dit voordat je overstapt.** De app bewaart alles in de localStorage van
de browser, en die is gebonden aan het webadres. Een nieuwe URL betekent dus
een lege app — je oude gegevens zijn niet weg, maar staan op het oude adres.

1. Open de app op het **oude** adres.
2. **Instellingen → Back-up downloaden**. Je krijgt een `.json`-bestand met
   alles erin: alle tabbladen, je instellingen, de indeling van je dashboard,
   je taal en je thema.
3. Open de **nieuwe** URL.
4. **Instellingen → Back-up terugzetten**, kies dat bestand, bevestig.

Hetzelfde geldt andersom: de app op je telefoon en die op je laptop zijn twee
aparte werkruimtes. Er is geen synchronisatie; het back-upbestand is de manier
om iets over te zetten.

---

## Bijwerken

`index.html` is het hele programma — er is geen bronbestand en geen build.
Wijzigen doe je in dat bestand, en dat is meteen wat er live staat.

De service worker haalt de pagina netwerk-eerst op, dus bij de eerstvolgende
keer openen mét verbinding heb je de nieuwe versie, zonder cache te legen.
Verander je `sw.js` zelf, verhoog dan `VERSION` bovenin dat bestand, anders
blijft de oude cache staan.

### Werkwijze

1. Wijzigen in `index.html`
2. `powershell -ExecutionPolicy Bypass -File tools\check.ps1` — statische controles
3. `powershell -ExecutionPolicy Bypass -File tools\serve.ps1` — lokaal uitproberen
   op <http://localhost:8099/>, inclusief service worker
4. Commit, en in GitHub Desktop de wijziging nakijken en pushen
5. Pages publiceert binnen een minuut of twee

### Controles

`tools\check.ps1` vangt wat een compiler zou vangen als die er was: een knop
zonder afhandeling, een vertaalsleutel die niet bestaat, een icoon dat niet is
getekend, een element dat wordt opgezocht maar nergens staat, een woordenlijst
die zichzelf aanroept, verminkte tekencodering, en Liquid-tekens waar Jekyll
over struikelt.

Wat het níét vangt is of de app werkelijk doet wat je bedoelt. Daarvoor is
`serve.ps1` er: open de pagina en klik erdoorheen.

---

## Privacy

De app doet geen enkel netwerkverzoek behalve het lettertype van Google Fonts
en de bestanden in deze map. Er is geen analytics, geen telemetrie, geen
server. Wat je invult blijft in je eigen browser staan.

Wil je ook het lettertype lokaal houden, haal dan de drie `fonts.googleapis.com`-
regels bovenin `index.html` weg; de app valt dan terug op het systeemlettertype.
