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

### 1.4 De automatische back-up aanzetten

Er is geen server, dus alles staat in de opslag van deze ene browser op deze
ene laptop. Zet dit meteen goed; het is de enige echte zwakte in de opzet.

**Instellingen → Automatische back-up naar een map → Map kiezen.** Maak in je
OneDrive een map `/AI operating system/Back-ups` en wijs die aan. De browser
vraagt eenmalig toestemming om erin te schrijven.

Vanaf dat moment zet de app daar elke werkdag om 17:00 een kopie van je hele
werkruimte neer, en bewaart hij de laatste veertien. Omdat die map in OneDrive
staat, valt je werkruimte daarmee onder de back-up van Microsoft.

> Was je laptop om vijf uur al dicht? Dan gebeurt het bij het eerstvolgende
> openen van de app. Een app zonder server kan alleen iets doen terwijl hij
> openstaat.

Met **Back-up downloaden** haal je daarnaast op elk moment zelf een
`.json`-bestand op — handig als je overstapt naar een andere laptop.

---

# Deel 2 — De map in OneDrive (2 minuten)

Alles wat Copilot en Power Automate maken komt als bestand in één map te
staan, en de app leest die map uit.

Maak in **jouw eigen OneDrive voor Bedrijven**:

```
/AI operating system/Agenda
/AI operating system/Back-ups
```

De eerste is voor wat Copilot en Power Automate aanleveren; de tweede is waar
de app zijn eigen back-up neerzet. Twee aparte mappen, want de app leest de
eerste en schrijft in de tweede.

Op één plek schrijft de app wél in de eerste map: in de submap
`Naar Outlook`, voor afspraken die hij naar Outlook stuurt (zie Deel 3,
*Afspraken naar Outlook*). Maak die submap meteen aan:

```
/AI operating system/Agenda/Naar Outlook
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
| `categorieen-*.json` | Agenda: je lijst met categorieën uit Outlook |
| `mail-*.json` | Mail |
| `briefing-*.json` | Copilot-briefing per afspraak |
| `transcript-*.json` | Copilot-samenvatting van vergaderverslagen |
| `taken-*.json` | Copilot-analyse van mogelijk vergeten taken |
| `nieuws-*.json` | Copilot-nieuwsronde uit je nieuwsbrieven, met de aangekondigde webinars |
| `Naar Outlook/*.json` | De app zelf: een afspraak die naar Outlook moet. De stroom *Afspraken naar Outlook* haalt het weer weg |
| `bevestiging-*.json` | *Afspraken naar Outlook*: onder welke sleutel een nieuwe afspraak in Outlook staat. De app ruimt het zelf op |

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

## Je categorieën meesturen

Het agendabestand bevat alleen de categorieën die op een afspraak staan. Een
categorie die je net in Outlook hebt gemaakt en nog nergens gebruikt, ziet de
app daardoor niet. Daarom schrijft de agendastroom ook de lijst zelf weg. Daar
staat de kleur bij, zodat een nieuwe categorie in de app dezelfde kleur krijgt
als in Outlook.

Zet in de **agendastroom**, ná de stap die het `.ics`-bestand wegschrijft,
twee stappen erbij:

1. **Office 365 Outlook → Send an HTTP request** (zoek binnen de connector op
   "HTTP"). Noem de stap `Categorieen`.
   - **URI:** `https://graph.microsoft.com/v1.0/me/outlook/masterCategories`
   - **Method:** `GET`
2. **OneDrive voor Bedrijven → Bestand maken.**
   - **Mappad:** `/AI operating system/Agenda`
   - **Bestandsnaam**, via `fx`:
     `concat('categorieen-', formatDateTime(utcNow(), 'yyyy-MM-dd-HH'), '.json')`
   - **Bestandsinhoud**, via `fx`: `body('Categorieen')`

Test de stroom één keer en klik in de app op **Vernieuwen**. Staan er
categorieën in Outlook die de app nog niet kende, dan meldt hij
*"… nieuwe categorieën uit Outlook"*.

> **Geeft stap 1 een fout over rechten?** Vervang hem dan door **Office 365
> Outlook → Get Outlook category names** (geen invoer nodig) en houd de naam
> `Categorieen`. Die geeft alleen de namen, dus de app kiest dan zelf een
> kleur. Nieuwe categorieën komen nog steeds vanzelf binnen.

Wat de app met de lijst doet:

- Een categorie die er nog niet was, komt erbij.
- Een kleur die je in de app zelf hebt gekozen, blijft staan. Een kleur die
  de app zelf had gekozen, volgt Outlook.
- Verwijderen doet hij niet. Een categorie die alleen in de app bestaat, mag
  blijven.
- Outlook heeft 25 kleuren en de app 14. Elke kleur komt op de dichtstbijzijnde
  terecht.

## Afspraken naar Outlook

De agendastroom brengt Outlook naar de app. Deze stroom doet het omgekeerde:
wat je in de app maakt, wijzigt of weggooit, gaat naar Outlook. Dat geldt voor:

- webinars die je op **Agenda** goedkeurt;
- afspraken die je in de app maakt terwijl **Naar Outlook** aanstaat (het
  vinkje in de mapregel op **Agenda**);
- een bestaande afspraak waarbij je onderaan op **Ook in Outlook zetten**
  klikt.

Uitnodigingen van anderen en afspraken die je in Outlook maakte, blijven van
Outlook. Deelnemers gaan bewust niet mee: anders stuurt Outlook hun een
uitnodiging.

**Hoe het werkt.** Bij elke wijziging zet de app een klein bestand in
`/AI operating system/Agenda/Naar Outlook`. De stroom maakt, wijzigt of
verwijdert daarmee de afspraak in Outlook, en gooit het bestand daarna weg.
Maakt hij een nieuwe afspraak, dan schrijft hij een bevestiging terug in
`/AI operating system/Agenda`, met de sleutels die Outlook eraan gaf. Daarmee
vindt de app hem later terug om hem te wijzigen of te verwijderen. De app
ruimt die bevestiging zelf op.

De eerste keer vraagt de browser of de app in je agendamap mag schrijven.
Geef die toestemming: zonder schrijfrecht blijft alles in de app.

### Het bestand dat de app neerzet

```json
{
  "version": 2,
  "action": "create",
  "appId": "k3x9q2m1ab7z",
  "eventId": "",
  "receipt": "bevestiging-k3x9q2m1ab7z-mwxhegsw.json",
  "event": {
    "subject": "Sparren met Henri",
    "body": { "contentType": "HTML", "content": "<p>…</p>" },
    "start": { "dateTime": "2026-12-01T13:00:00", "timeZone": "UTC" },
    "end": { "dateTime": "2026-12-01T14:00:00", "timeZone": "UTC" },
    "location": { "displayName": "Kamer 3" },
    "categories": ["Intern"]
  }
}
```

- `action` is `create`, `update` of `delete`.
- `eventId` is leeg bij `create`, en gevuld bij `update` en `delete`.
- `event` staat al in de vorm die Microsoft Graph verwacht, met de tijden in
  UTC. Bij `delete` is het `null`.
- `receipt` is de naam die de bevestiging moet krijgen.

### De stroom bouwen

Maak een **Geautomatiseerde cloudstroom** met de naam `Afspraken naar
Outlook`. Geef elke actie precies de naam hieronder: de formules verwijzen
ernaar.

1. **Trigger:** OneDrive voor Bedrijven → **Wanneer een bestand wordt gemaakt
   (alleen eigenschappen)** (*When a file is created (properties only)*).
   - **Map:** `/AI operating system/Agenda/Naar Outlook`
   - Bij **Instellingen** van de trigger: zet **Gelijktijdigheidsbeheer** aan,
     met **Mate van parallelle uitvoering** op `1`. Dan komt een wijziging
     nooit vóór de afspraak zelf aan.
2. **OneDrive voor Bedrijven → Bestandsinhoud ophalen** (*Get file content*),
   naam `Inhoud`.
   - **Bestand:** de **Id** uit de dynamische inhoud van de trigger. Of via
     `fx`: `triggerOutputs()?['body/Id']`
3. **Samenstellen** (*Compose*), naam `Verzoek`. Invoer, via `fx`:
   ```
   json(if(contains(string(body('Inhoud')), '$content'), base64ToString(coalesce(json(string(body('Inhoud')))?['$content'], '')), string(body('Inhoud'))))
   ```
   Power Automate levert de inhoud van een bestand soms als tekst en soms
   ingepakt. Deze formule werkt in beide gevallen.
4. **Schakelen** (*Switch*), naam `Soort`. **Aan**, via `fx`:
   `outputs('Verzoek')?['action']`. Drie gevallen:

   **Geval `create`:**
   1. **Office 365 Outlook → Een HTTP-aanvraag verzenden** (*Send an HTTP
      request*; zoek binnen de connector op "HTTP"), naam `Maken`.
      - **URI:** `https://graph.microsoft.com/v1.0/me/events`
      - **Methode:** `POST`
      - **Hoofdtekst**, via `fx`: `string(outputs('Verzoek')?['event'])`
      - **Content-Type:** `application/json`
   2. **OneDrive voor Bedrijven → Bestand maken** (*Create file*), naam
      `Bevestiging`.
      - **Mappad:** `/AI operating system/Agenda`
      - **Bestandsnaam**, via `fx`: `outputs('Verzoek')?['receipt']`
      - **Bestandsinhoud**, via `fx`:
        ```
        string(setProperty(setProperty(setProperty(json('{}'), 'appId', outputs('Verzoek')?['appId']), 'eventId', body('Maken')?['id']), 'iCalUId', body('Maken')?['iCalUId']))
        ```

   **Geval `update`:** **Een HTTP-aanvraag verzenden**, naam `Wijzigen`.
   - **URI**, via `fx`:
     `concat('https://graph.microsoft.com/v1.0/me/events/', encodeUriComponent(outputs('Verzoek')?['eventId']))`
   - **Methode:** `PATCH`
   - **Hoofdtekst**, via `fx`: `string(outputs('Verzoek')?['event'])`
   - **Content-Type:** `application/json`

   **Geval `delete`:** **Een HTTP-aanvraag verzenden**, naam `Verwijderen`.
   - **URI:** dezelfde formule als bij `Wijzigen`
   - **Methode:** `DELETE`
   - Geen hoofdtekst

   **Standaard:** leeg laten.
5. **Na** de Schakelen, dus niet erin: **OneDrive voor Bedrijven → Bestand
   verwijderen** (*Delete file*), naam `Opruimen`.
   - **Bestand:** weer de **Id** van de trigger.

Laat bij elke actie **Uitvoeren na** op de standaard staan (*is geslaagd*).
Mislukt er iets, dan blijft het bestand staan. De run in Power Automate wordt
dan rood, en de app meldt na een half uur *Wacht op je stroom*.

De stroom bouwt de adressen zelf op en gebruikt uit het bestand alleen de
gegevens van de afspraak. Een bestand in die map kan dus nooit iets anders
doen dan een afspraak in je eigen agenda maken, wijzigen of verwijderen.

### Wat je in de app ziet

Bij een webinar, en onderaan de pagina van een afspraak:

- *Naar Outlook gestuurd*: het bestand staat klaar.
- *Opgepakt door je stroom*: de stroom is ermee bezig. De app wacht nog op de
  bevestiging.
- *Staat in Outlook*: de bevestiging is binnen.
- *Wacht op je stroom*: na een half uur is het bestand nog niet opgepakt.
  Kijk dan of de stroom aan staat en of de laatste run rood is.
- *Alleen in de app*: er ging nog niets heen. Klik op **Naar Outlook sturen**.

De app kijkt drie en tien minuten na het versturen zelf of de stroom klaar
is, en verder bij elke keer inlezen.

**Verschuif of verwijder je zo'n afspraak in Outlook**, dan neemt de app dat
over bij de volgende agendaronde. Wat je in de app wijzigt, gaat binnen een
paar minuten naar Outlook. Je kunt dus beide kanten gebruiken.

**Test:** zet **Naar Outlook** aan, maak in de app een afspraak voor morgen,
en kijk of hij binnen een paar minuten in Outlook staat. Verschuif hem dan in
de app en kijk of Outlook meeschuift. Verwijder hem tot slot in de app.

---

# Deel 4 — De prompts in Copilot (10 minuten)

De stromen lezen een mail die Copilot klaarzet. Zonder die prompts blijven ze
dus leeglopen.

Er zijn vier geplande prompts. Kopieer ze **letterlijk** uit het bestaande
account — dat gaat sneller dan ze opnieuw schrijven en voorkomt dat het
afgesproken formaat verschuift.

| Prompt | Wanneer | Onderwerp van de mail |
|---|---|---|
| Briefing per afspraak | Elke werkdag 's ochtends | zoals in het origineel |
| Vergaderverslagen van die dag | Elke werkdag 's avonds | zoals in het origineel |
| Mogelijk vergeten taken | Maandag 07:30 | `Joost OS taken` |
| Nieuwsronde en webinars | Ma, wo en vr 's ochtends | `Joost OS AI nieuws` |

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

### De prompt voor de nieuwsronde

Deze staat hier ook voluit, omdat hij de webinars meestuurt. Pas de eerste
alinea aan op de nieuwsbrieven en de map waarin ze bij jou binnenkomen.

```text
Zoek in mijn mailbox naar e-mails van de afgelopen 3 dagen van deze
nieuwsbrieven: The Rundown AI, Ben's Bites, Import AI, The Batch, Every,
One Useful Thing, Last Week in AI, AI-report, Dharmesh (simple AI). Neem ook andere nieuwsbrieven over AI mee die je in die periode tegenkomt.

Beoordeel eerst per mail of hij inhoudelijk iets toevoegt. Sla over:
- reclame, aanbiedingen en wervingsmails (webinars en events komen hieronder apart aan bod)
- mails die alleen naar een betaalde versie verwijzen zonder zelf inhoud te geven
- dubbele berichten over hetzelfde onderwerp: kies dan de uitgebreidste
- alles wat niet over AI gaat

Haal uit wat overblijft de losse onderwerpen. Eén onderwerp is één item, ook
als er in één nieuwsbrief vijf onderwerpen staan. Staat hetzelfde onderwerp in
meerdere nieuwsbrieven, maak er dan één item van en noem beide bronnen.

Beoordeel per onderwerp of het ertoe doet voor een AI-rol binnen Audit &
Assurance bij een middelgroot accountantskantoor. Generiek AI niews kan ook waardevol zijn, ik wil namelijk goed op de hoogte blijven van recente ontwikkelingen. Laat weg wat alleen voor consumenten, ontwikkelaars of durfkapitaal interessant is. Houd maximaal 10-15 items over, de belangrijkste eerst.

Schrijf per item exact dit formaat, zonder opsommingstekens, zonder kopjes,
zonder inleiding of afsluiting:

NIEUWS: <de kop, één zin, concreet>
Wat: <maximaal 10 zinnen over wat er feitelijk is gebeurd of aangekondigd>
Waarom: <maximaal 10 zinnen: wat dit betekent voor controleteams of voor mijn
AI-rol. Wees concreet; schrijf niet "dit is interessant". Maar geef ook aan als het niet per se interessant is voor audit, maar mogelijk wel als basiskennis AI die relevant kan zijn>
Pijler: <één van: Kwaliteit, Adoptie, Waarde, Innovatie>
Bron: <naam van de nieuwsbrief>, <datum van de mail als dd-mm-jjjj>
Link: <de URL naar het oorspronkelijke bericht, of leeg als die er niet is>

Kijk daarnaast in al deze mails, ook in de mails die je hierboven overslaat,
naar aankondigingen van webinars, livestreams en events over AI die nog
moeten plaatsvinden. Schrijf per event, na de nieuwsitems, exact dit formaat:

NIEUWS: <de naam van het webinar of event>
Soort: <Webinar, Livestream of Event>
Datum: <dd-mm-jjjj>
Tijd: <begintijd>-<eindtijd> <tijdzone zoals in de mail, bijvoorbeeld ET of CET>
Locatie: <Online, of de plaats>
Link: <de link om je aan te melden of deel te nemen, of leeg>
Wat: <één zin waar het over gaat>
Bron: <naam van de nieuwsbrief>, <datum van de mail als dd-mm-jjjj>

Neem de tijd en de tijdzone over zoals ze in de mail staan; reken ze niet om.
Staat er geen eindtijd, laat die dan weg. Wordt hetzelfde event in meerdere
mails aangekondigd, noem het dan één keer. Sla events over die al voorbij zijn.

Uiteindelijk heb je dus een overzicht van al het relevante AI nieuws van de afgelopen 3 dagen, met daaronder de webinars en events die eraan komen, overzichtelijk, duidelijk, compleet en in een vaste structuur voor mij klaar staan.

Is er geen nieuws en geen event, schrijf dan alleen: NIET RELEVANT.

Zet dit in een conceptmail aan mezelf met als onderwerp exact: Joost OS AI nieuws
```

Een event begint ook met `NIEUWS:`. Zo neemt de nieuwsstroom het ongewijzigd
mee, en hoef je die stroom niet aan te passen. De app herkent een event aan
de regel `Soort:` en zet het op de agendapagina in plaats van bij het nieuws.

De tijd rekent de app zelf om, met de zomer- en wintertijd van die dag. Achter
de omgerekende tijd zie je wat er in de mail stond. Klopt het niet, gebruik dan
**Aanpassen** voordat je het webinar goedkeurt.

---

# Deel 5 — De map koppelen aan de app (1 minuut)

1. Open de app, ga naar **Agenda**.
2. Klik op het mapicoon en kies `/AI operating system/Agenda` uit je OneDrive,
   zoals die op je laptop is gesynchroniseerd.
3. De browser vraagt om toestemming om die map te lezen. Geef die.
4. Zet **Automatisch inlezen** aan.

Vanaf nu leest de app die map bij het openen, en kun je hem tussendoor
bijwerken met **Vernieuwen** op het dashboard of op de agendapagina.

> De app leest die map. Schrijven doet hij er alleen in de submap
> `Naar Outlook`, voor afspraken die naar Outlook gaan, en hij ruimt de
> bevestigingen van die stroom op. Naar buiten stuurt hij niets.

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
- [ ] De automatische back-up staat aan en heeft één keer een bestand
      weggeschreven naar `/AI operating system/Back-ups`
- [ ] Een afspraak die je in de app maakte, stond binnen een paar minuten in
      Outlook, en schoof mee toen je hem in de app verschoof

---

# Als er iets niet werkt

| Wat je ziet | Wat er meestal aan de hand is |
|---|---|
| Stroom loopt groen, maar er komt geen bestand | Het onderwerpfilter van de stroom en het onderwerp uit de Copilot-prompt komen niet overeen |
| Stromen lopen groen, maar er komt van géén enkele stroom nog iets binnen | OneDrive draait niet op je laptop, vaak na een automatische update. De bestanden staan wel in OneDrive online. Start OneDrive via het startmenu, of start de laptop opnieuw op |
| `Id is malformed`, of een formule die onzin oplevert | Er staat uitleg in het veld in plaats van alleen de formule |
| `The 'from' property value is of type 'Object'` | Je mist `?['value']` achter `body('…')` |
| De app ziet de map niet meer | De browser is de toestemming vergeten; kies de map opnieuw |
| Een vergaderverslag komt leeg binnen | Copilot heeft andere kopjes gebruikt dan de prompt vraagt |
| Van een overleg van iemand anders komt nooit een verslag | Copilot kan niet bij de transcriptie als je geen organisator bent. Laat het transcript toesturen, laat Copilot het samenvatten en plak dat via **Transcripties → Verslag toevoegen**. De knop *Copilot-prompt kopiëren* in dat venster geeft de juiste prompt |
| Alle acties staan op jou | Je naam staat niet in **Instellingen → Profiel** |
| Webinars uit je nieuwsbrieven verschijnen niet op de Agenda | De nieuwsprompt slaat ze nog over. Haal "webinar-uitnodigingen" uit het lijstje *Sla over* en zet het stuk over events erin (Deel 4) |
| Een afspraak of webinar blijft op *Wacht op je stroom* staan | De stroom *Afspraken naar Outlook* staat uit, kijkt naar een andere map dan `/AI operating system/Agenda/Naar Outlook`, of OneDrive draait niet op je laptop. Is de laatste run rood, kijk dan welke stap faalde |
| Een afspraak blijft op *Opgepakt door je stroom* staan | De stap `Bevestiging` schrijft niet naar `/AI operating system/Agenda`, of de bestandsnaam komt niet uit `receipt` |
| Een afspraak of webinar staat op *Alleen in de app* | De browser mocht niet in je agendamap schrijven. Klik op **Naar Outlook sturen** en geef toestemming |
| Een webinar staat op de verkeerde tijd | Copilot heeft de tijdzone niet overgenomen. Kijk achter de tijd wat er in de mail stond en pas het aan met **Aanpassen** |
| Een nieuwe categorie uit Outlook verschijnt niet | De categoriestappen ontbreken in de agendastroom (zie Deel 3), of de stroom liep daarna niet meer |

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
