<#
  Statische controles op index.html.

  De app is één bestand zonder build, dus er is geen compiler die fouten
  vangt. Deze controles vangen de soorten fout die je hier wél kunt maken:
  een knop zonder afhandeling, een vertaalsleutel die niet bestaat, een
  icoon dat niet is getekend, een element dat wordt opgezocht maar nergens
  staat.

  Draaien:  powershell -ExecutionPolicy Bypass -File tools\check.ps1
#>

param([string]$Path = (Join-Path $PSScriptRoot "..\index.html"))

$src = [Text.Encoding]::UTF8.GetString([IO.File]::ReadAllBytes((Resolve-Path $Path)))
$fail = 0

function Report($name, $missing) {
  if ($missing.Count -eq 0) { Write-Host "OK    $name" -ForegroundColor Green }
  else {
    Write-Host "FAIL  $name -> $($missing -join ', ')" -ForegroundColor Red
    $script:fail++
  }
}

$strSrc = [regex]::Match($src, 'const STR\s*=\s*\{(.*?)\n\};', 'Singleline').Groups[1].Value

# --- elke tr()-sleutel bestaat -----------------------------------------------
$defined = @{}
foreach ($m in [regex]::Matches($strSrc, '([a-z0-9_]+):\s*\[')) { $defined[$m.Groups[1].Value] = $true }
$used = @{}
foreach ($m in [regex]::Matches($src, 'tr\("([a-z0-9_]+)"')) { $used[$m.Groups[1].Value] = $true }
Report "tr() sleutels bestaan" @($used.Keys | Where-Object { -not $defined.ContainsKey($_) } | Sort-Object)

# --- elk icoon bestaat -------------------------------------------------------
$icons = @{}
$iconBlock = [regex]::Match($src, 'const ICONS\s*=\s*\{(.*?)\n\};', 'Singleline')
foreach ($m in [regex]::Matches($iconBlock.Groups[1].Value, '(?m)^\s*([a-zA-Z0-9_]+)\s*:')) { $icons[$m.Groups[1].Value] = $true }
$iconUsed = @{}
foreach ($m in [regex]::Matches($src, 'ico\("([a-zA-Z0-9_]+)"')) { $iconUsed[$m.Groups[1].Value] = $true }
Report "ico() namen bestaan" @($iconUsed.Keys | Where-Object { -not $icons.ContainsKey($_) } | Sort-Object)

# --- elk tabblad heeft een pagina --------------------------------------------
$views = @{}
$viewBlock = [regex]::Match($src, 'const VIEWS\s*=\s*\{(.*?)\n\};', 'Singleline').Groups[1].Value
foreach ($m in [regex]::Matches($viewBlock, '([a-zA-Z0-9_]+)\s*:')) { $views[$m.Groups[1].Value] = $true }
$navBlock = [regex]::Match($src, 'const NAV\s*=\s*\[(.*?)\n\];', 'Singleline').Groups[1].Value
$navViews = @()
foreach ($m in [regex]::Matches($navBlock, '\["([a-z]+)",\s*"([a-z_]+)"')) { $navViews += $m.Groups[1].Value }
Report "menu-items hebben een pagina" @($navViews | Where-Object { -not $views.ContainsKey($_) } | Sort-Object -Unique)

$navTargets = @{}
foreach ($m in [regex]::Matches($src, 'data-nav="([a-zA-Z0-9_]+)"')) { $navTargets[$m.Groups[1].Value] = $true }
Report "data-nav verwijst naar een pagina" @($navTargets.Keys | Where-Object { -not $views.ContainsKey($_) } | Sort-Object)

# --- elke knop heeft een afhandeling -----------------------------------------
$cases = @{}
foreach ($m in [regex]::Matches($src, 'case "([a-z0-9-]+)"')) { $cases[$m.Groups[1].Value] = $true }
$acts = @{}
foreach ($m in [regex]::Matches($src, 'data-act="([a-z0-9-]+)"')) { $acts[$m.Groups[1].Value] = $true }
Report "data-act wordt afgehandeld" @($acts.Keys | Where-Object { -not $cases.ContainsKey($_) } | Sort-Object)

# --- elk opgezocht element bestaat -------------------------------------------
$ids = @{}
foreach ($m in [regex]::Matches($src, 'id="([a-zA-Z0-9_-]+)"')) { $ids[$m.Groups[1].Value] = $true }
foreach ($m in [regex]::Matches($src, 'id:\s*"([a-zA-Z0-9_-]+)"')) { $ids[$m.Groups[1].Value] = $true }
$sel = @{}
foreach ($m in [regex]::Matches($src, '\$\("#([a-zA-Z0-9_-]+)"\)')) { $sel[$m.Groups[1].Value] = $true }
Report '$("#id") bestaat in de markup' @($sel.Keys | Where-Object { -not $ids.ContainsKey($_) } | Sort-Object)

# --- de woordenlijst mag zichzelf niet aanroepen -----------------------------
# Dit heeft ooit de hele app laten crashen: een vertaling die tr() aanriep
# terwijl de woordenlijst nog werd opgebouwd.
$tdz = @()
if ([regex]::IsMatch($strSrc, 'tr\(')) { $tdz = @("STR roept tr() aan") }
Report "geen tr() binnen STR" $tdz

# --- tekencodering -----------------------------------------------------------
# Een verkeerd ingelezen bestand verminkt alle accenten in één klap.
$bad = @()
$tilde = ([regex]::Matches($src, [string][char]0x00C3)).Count
$repl  = ([regex]::Matches($src, [string][char]0xFFFD)).Count
if ($tilde) { $bad += "$tilde x A-tilde (dubbel gecodeerd)" }
if ($repl)  { $bad += "$repl x vervangingsteken (verloren tekens)" }
Report "tekencodering ongeschonden" $bad

# --- GitHub Pages ------------------------------------------------------------
# Pages draait Jekyll; Liquid-tekens in de HTML breken de build.
$liquid = @()
if ([regex]::IsMatch($src, '\{\{')) { $liquid += "'{{' gevonden" }
if ([regex]::IsMatch($src, '\{%'))  { $liquid += "'{%' gevonden" }
Report "geen Liquid-tekens (Jekyll)" $liquid

Write-Host ""
if ($fail) { Write-Host "$fail controle(s) mislukt" -ForegroundColor Red; exit 1 }
else { Write-Host "alle controles geslaagd" -ForegroundColor Green }
