# My Intelligent Workspace — van niets naar klaar

Dit is de volledige inrichting voor een nieuwe gebruiker: de app op de laptop,
de map in OneDrive, de stromen in Power Automate en de geplande prompts in
Copilot.

Reken op **ongeveer een uur**, waarvan het meeste in Power Automate zit.
De app zelf staat in vijf minuten.

Je kunt tussendoor stoppen. Elk deel werkt op zichzelf: zonder stromen is de
app gewoon een werkbesturingssysteem dat je met de hand vult, en elke stroom
die je toevoegt zet daar een stuk automatisch in.

---

## Voordat je begint

| Nodig | Waarom |
|---|---|
| Een Microsoft 365-account van Visser & Visser | Outlook, Teams, OneDrive, Power Automate |
| Edge of Chrome | De app gebruikt een mapfunctie die Safari en Firefox niet hebben |
| Een Copilot-licentie | Alleen voor de drie analyses; de rest werkt zonder |
| Toegang tot Power Automate | `make.powerautomate.com` |

> **Let op bij de browser.** De app bewaart alles in de browser waarin je hem
> opent, gekoppeld aan het webadres. Je laptop en je telefoon zijn dus twee
> aparte werkruimtes, en er is geen synchronisatie tussen de twee. Kies één
> apparaat als je hoofdwerkplek.

---

# Deel 1 — De app (5 minuten)

### 1.1 Openen

Open in **Edge** of **Chrome**:

```
https://joostprinsvv.github.io/JP-Operating-System/
```

Je krijgt een lege werkruimte. Dat hoort zo: de pagina is voor iedereen
dezelfde, maar wat je invult blijft in jouw browser en is voor niemand anders
zichtbaar — ook niet voor degene die de app heeft gemaakt.

### 1.2 Installeren als bureaublad-app

Rechts in de adresbalk verschijnt een installatie-icoon (een scherm met een
pijl). Of via het menu **… → Apps → Deze site als app installeren**.

Daarna staat hij als los venster in je startmenu en op je taakbalk, met eigen
icoon en zonder adresbalk, en opent hij ook zonder internetverbinding.

Op iOS: Safari → Deel → *Zet op beginscherm*. Let op dat je dan een tweede,
losse werkruimte maakt.

### 1.3 Je profiel invullen

**Instellingen → Profiel**: naam, functie, organisatie.

Vul je naam volledig in zoals Copilot hem zal schrijven. De app gebruikt die
naam om te bepalen welke actie uit een vergaderverslag voor jou is en welke
voor iemand anders. Staat hij er niet, dan komt alles op jouw bord.

Loop meteen ook **Instellingen → Werkpatroon** langs: werkdagen en fte. Daar
hangt je capaciteitsberekening aan.

### 1.4 Een back-up maken is jouw taak

Er is geen server, dus er is ook niemand die een back-up voor je maakt.
**Instellingen → Back-up downloaden** geeft je één `.json`-bestand met alles
erin. De app begint erover te zeuren als het te lang geleden is.

---

# Deel 2 — De map in OneDrive (2 minuten)

Alles wat Copilot en Power Automate maken komt als bestand in één map te
staan, en de app leest die map uit.

Maak in **jouw eigen OneDrive voor Bedrijven**:

```
/AI operating system/Agenda
```

> **Maak je eigen map.** Wijs niet de map van een collega aan, ook niet als je
> die gedeeld hebt gekregen. In die bestanden staan hun afspraken,
> vergaderverslagen en mailanalyses.

Deel deze map met niemand. Alles wat erin komt blijft daarmee binnen de
beveiligde omgeving van Visser & Visser.

### Wat er straks in komt te staan

| Bestand | Van welke stroom |
|---|---|
| `*.ics` | Agenda |
| `mail-*.json` | Mail |
| `briefing-*.json` | Copilot-briefing per afspraak |
| `transcript-*.json` | Copilot-samenvatting van vergaderverslagen |
| `taken-*.json` | Copilot-analyse van mogelijk vergeten taken |

De app herkent ze aan die namen. Houd je er dus aan.

---

# Deel 3 — De stromen in Power Automate (30–40 minuten)

Hier zit het echte werk. Er zijn twee routes.

## Route A — Overzetten vanuit het bestaande account (aanbevolen)

Dit is veruit de betrouwbaarste manier. De stromen bestaan al en zijn
uitgeprobeerd; ze opnieuw uittypen levert alleen maar nieuwe tikfouten op.

**In het account waar de stromen al staan:**

1. Ga naar **Mijn stromen**.
2. Bij elke stroom: de drie puntjes → **Exporteren → Pakket (.zip)**.
3. Vul een naam in, laat de rest staan, en klik **Exporteren**. Je krijgt een
   `.zip`.
4. Stuur die bestanden naar de nieuwe gebruiker.

**In het nieuwe account:**

5. Ga naar **Mijn stromen → Importeren → Pakket importeren**.
6. Kies de `.zip`.
7. Onder *Gerelateerde bronnen* staan de verbindingen (Office 365 Outlook,
   OneDrive voor Bedrijven, Content Conversion). Klik bij elk op **Selecteren
   tijdens importeren** en kies je eigen verbinding, of maak hem aan.
8. **Importeren**.
9. Zet de stroom daarna **aan** — een geïmporteerde stroom staat uit.

Loop na het importeren van elke stroom nog één ding na: het **mappad** van de
actie die het bestand wegschrijft. Dat wijst nog naar de OneDrive van de
oorspronkelijke eigenaar. Zet het op `/AI operating system/Agenda` in je eigen
OneDrive.

## Route B — Zelf opbouwen

Alleen als exporteren niet kan. De volledige stap-voor-stapbeschrijving van de
takenstroom staat in de gespreksgeschiedenis bij de bouwer; vraag erom in
plaats van te gokken.

Houd je in beide routes aan deze regels, want ze hebben ons alle vier een
mislukte uitvoering gekost:

- **Geef acties namen zonder spaties.** Power Automate verwijst in formules
  naar een actie via zijn naam; een spatie wordt een liggend streepje en dan
  klopt je formule niet meer.
- **Een lijst van een connector zit in een omhulsel.** `body('Concepten')` is
  een object, niet een rij. Je hebt `body('Concepten')?['value']` nodig.
- **In het Nederlands heet "Compose" Samenstellen.** Zoek daar niet op
  "Opstellen".
- **Een formule zet je in het veld via het `fx`-knopje.** Alleen de formule
  zelf gaat het veld in — geen uitleg, geen aanhalingstekens eromheen.

---

# Deel 4 — De prompts in Copilot (10 minuten)

De stromen lezen een mail die Copilot klaarzet. Zonder die prompts blijven ze
dus leeglopen.

Er zijn drie geplande prompts. Kopieer ze **letterlijk** uit het bestaande
account — dat gaat sneller dan ze opnieuw schrijven en voorkomt dat het
afgesproken formaat verschuift.

| Prompt | Wanneer | Onderwerp van de mail |
|---|---|---|
| Briefing per afspraak | Elke werkdag 's ochtends | zoals in het origineel |
| Vergaderverslagen van die dag | Elke werkdag 's avonds | zoals in het origineel |
| Mogelijk vergeten taken | Maandag 07:30 | `Joost OS taken` |

**Het onderwerp van de mail moet exact overeenkomen** met het onderwerpfilter
in de bijbehorende stroom. Verandert er één letter, dan vindt de stroom niets
en meldt hij geen fout — hij doet gewoon niets.

Die onderwerpregels mogen blijven zoals ze zijn, ook al staat er "Joost OS" in.
Ze zijn een afspraak tussen Copilot en de stroom, en niemand ziet ze.

### De prompt voor vergeten taken

Deze staat hier voluit, omdat hij het nieuwst is:

```text
Analyseer mijn mailbox (ontvangen én verzonden), mijn Teams-chats en mijn
Teams-kanaalberichten van de afgelopen 30 dagen.

Zoek naar dingen die waarschijnlijk nog openstaan en die niet op een
takenlijst staan:
- toezeggingen die ik zelf heb gedaan ("ik stuur je", "ik kom erop terug",
  "ik regel het")
- vragen aan mij die ik niet of alleen met een tussenantwoord heb beantwoord
- afspraken met een datum die inmiddels is gepasseerd
- draden die middenin stilvielen zonder afronding

Laat weg: dingen die aantoonbaar zijn afgerond, nieuwsbrieven, automatische
meldingen, vergaderuitnodigingen en accepteer/afwijsberichten.

Schrijf per punt exact dit formaat, zonder opsommingstekens, zonder kopjes,
zonder inleiding of afsluiting:

TAAK: <één zin, wat er concreet moet gebeuren>
Waarom: <waarom dit nog open lijkt te staan, met datum>
Bron: <van wie en wanneer, bijvoorbeeld: mail Henri Visser, 12-09>

Maximaal 15 punten, de meest waarschijnlijke eerst. Zijn er geen punten,
schrijf dan alleen: GEEN.

Zet dit in een conceptmail aan mezelf met als onderwerp exact: Joost OS taken
```

---

# Deel 5 — De map koppelen aan de app (1 minuut)

1. Open de app, ga naar **Agenda**.
2. Klik op het mapicoon en kies `/AI operating system/Agenda` uit je OneDrive,
   zoals die op je laptop is gesynchroniseerd.
3. De browser vraagt om toestemming om die map te lezen. Geef die.
4. Zet **Automatisch inlezen** aan.

Vanaf nu leest de app die map bij het openen, en kun je hem tussendoor
bijwerken met **Vernieuwen** op het dashboard of op de agendapagina.

> De app leest alleen. Hij schrijft niets naar die map en stuurt niets naar
> buiten.

---

# Deel 6 — Controleren of het werkt

Wacht niet tot morgenochtend. Dwing elke stroom één keer af:

1. Open de stroom in Power Automate.
2. **Testen → Handmatig → Testen → Stroom uitvoeren**.
3. Kijk of hij groen wordt, en of het bestand in `/AI operating system/Agenda`
   verschijnt.
4. Klik in de app op **Vernieuwen** en kijk naar de melding onderin.

De melding vertelt precies wat er binnenkwam, bijvoorbeeld:

> 7 afspraken toegevoegd, 2 vergaderlinks aangevuld, 1 verslag gevonden

Staat er *"Niets nieuws — alles was al bij"*, dan is het bestand wel gelezen
maar stond alles er al in. Staat er *"Geen .ics-bestand in die map gevonden"*,
dan wijst de app naar de verkeerde map of heeft de agenda-stroom niets
weggeschreven.

### Afvinklijst

- [ ] De app staat in het startmenu en opent zonder adresbalk
- [ ] Naam en werkpatroon zijn ingevuld
- [ ] De map `/AI operating system/Agenda` bestaat en is met niemand gedeeld
- [ ] Alle stromen staan **aan** en schrijven naar de eigen OneDrive
- [ ] Alle geplande prompts staan in Copilot, met de juiste onderwerpregels
- [ ] De map is gekoppeld in de app, met automatisch inlezen aan
- [ ] Elke stroom is één keer met de hand uitgevoerd en werd groen
- [ ] Er is één keer een back-up gedownload

---

# Als er iets niet werkt

| Wat je ziet | Wat er meestal aan de hand is |
|---|---|
| Stroom loopt groen, maar er komt geen bestand | Het onderwerpfilter van de stroom en het onderwerp uit de Copilot-prompt komen niet overeen |
| `Id is malformed`, of een formule die onzin oplevert | Er staat uitleg in het veld in plaats van alleen de formule |
| `The 'from' property value is of type 'Object'` | Je mist `?['value']` achter `body('…')` |
| De app ziet de map niet meer | De browser is de toestemming vergeten; kies de map opnieuw |
| Een vergaderverslag komt leeg binnen | Copilot heeft andere kopjes gebruikt dan de prompt vraagt |
| Alle acties staan op jou | Je naam staat niet in **Instellingen → Profiel** |

---

# Wat waar blijft

De app doet **geen enkel verzoek aan derden**: geen analytics, geen
telemetrie, geen server, geen lettertype van buiten. In de code staat geen
`fetch`, `XMLHttpRequest`, `sendBeacon`, WebSocket of `EventSource`.

- **Wat je invult** staat in de localStorage van je eigen browser, op je eigen
  laptop.
- **Wat Copilot en Power Automate maken** staat in jouw OneDrive, binnen de
  tenant van Visser & Visser.
- **De pagina zelf** staat openbaar op GitHub Pages. Het *programma* is dus
  voor iedereen met de URL te openen, de *inhoud* niet.

Dat laatste betekent ook: zet niets persoonlijks in de code zelf, en dus ook
niet in dit bestand.
