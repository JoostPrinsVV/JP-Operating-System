<#
  Serveert de map lokaal, zodat je de app kunt uitproberen zoals hij op
  GitHub Pages draait - inclusief de service worker, die vanaf file:// niet
  werkt.

  Draaien:  powershell -ExecutionPolicy Bypass -File tools\serve.ps1
  Stoppen:  Ctrl+C, of open http://localhost:8099/stop
#>

param(
  [string]$Root = (Resolve-Path (Join-Path $PSScriptRoot "..")),
  [int]$Port = 8099
)

$types = @{
  ".html" = "text/html; charset=utf-8"
  ".js"   = "text/javascript; charset=utf-8"
  ".json" = "application/json; charset=utf-8"
  ".webmanifest" = "application/manifest+json; charset=utf-8"
  ".png"  = "image/png"
  ".md"   = "text/markdown; charset=utf-8"
  ".ps1"  = "text/plain; charset=utf-8"
}

$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
Write-Host "Joost OS draait op http://localhost:$Port/" -ForegroundColor Green
Write-Host "($Root)" -ForegroundColor DarkGray

while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  try {
    $p = $ctx.Request.Url.AbsolutePath
    if ($p -eq '/stop') { $ctx.Response.StatusCode = 200; $ctx.Response.Close(); break }
    if ($p -eq '/') { $p = '/index.html' }
    $file = Join-Path $Root ($p.TrimStart('/') -replace '/', '\')
    # Nooit buiten de map serveren.
    if (-not $file.StartsWith($Root, [StringComparison]::OrdinalIgnoreCase) -or
        -not (Test-Path $file -PathType Leaf)) {
      $ctx.Response.StatusCode = 404; $ctx.Response.Close()
      Write-Host "404 $p" -ForegroundColor DarkYellow
      continue
    }
    $ext = [IO.Path]::GetExtension($file).ToLower()
    $ctx.Response.ContentType = $(if ($types.ContainsKey($ext)) { $types[$ext] } else { "application/octet-stream" })
    $ctx.Response.Headers.Add('Cache-Control', 'no-store')
    $bytes = [IO.File]::ReadAllBytes($file)
    $ctx.Response.ContentLength64 = $bytes.Length
    $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    $ctx.Response.Close()
    Write-Host "200 $p" -ForegroundColor DarkGray
  } catch {
    Write-Host "fout: $_" -ForegroundColor Red
    try { $ctx.Response.Close() } catch {}
  }
}
$listener.Stop()
Write-Host "gestopt." -ForegroundColor Green
