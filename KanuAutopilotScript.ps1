# Test connectivity to Google
$googleURL = "https://www.google.com"
try {
    $response = Invoke-WebRequest -Uri $googleURL -UseBasicParsing -TimeoutSec 10
    Write-Host "Successfully connected to Google." -ForegroundColor Green
} catch {
    Write-Host "Failed to connect to Google. Check network connectivity." -ForegroundColor Red
    exit
}

# Enable script execution bypass
Set-ExecutionPolicy Bypass -Scope Process -Force
Write-Host "Execution policy set to Bypass." -ForegroundColor Yellow

# List tag names for user selection
$tags = @(
    "KanuDc", "KanuJPT", "KanuBLM", "KanuPE", "KanuEL", "KanuCPT",
    "KanuKZN", "KanuBW", "KanuCM", "KanuDRC", "KanuGH", "KanuIC",
    "KanuKE", "KanuLR", "KanuMU", "KanuNA", "KanuSL", "KanuTZ",
    "KanuZM", "KanuZW", "KanuIT", "KanuEXEC"
)

Write-Host "Select a Group Tag:"
for ($i = 0; $i -lt $tags.Length; $i++) {
    Write-Host "$($i + 1): $($tags[$i])"
}

$userChoice = Read-Host "Enter selection (1 - $($tags.Length))"
$userTag = $tags[[int]$userChoice - 1]

if ($userTag -eq $null) {
    Write-Host "Invalid selection. Exiting." -ForegroundColor Red
    exit
}

Write-Host "You selected: $userTag" -ForegroundColor Cyan

# Install WindowsAutoPilotInfo module
Install-Script Get-WindowsAutoPilotInfo -Force -Confirm:$false
Write-Host "Installed Get-WindowsAutoPilotInfo script." -ForegroundColor Green

# Run WindowsAutoPilotInfo script with user-selected tag
Get-WindowsAutoPilotInfo -Online -GroupTag $userTag
Write-Host "Windows AutoPilot info uploaded with GroupTag: $userTag" -ForegroundColor Green