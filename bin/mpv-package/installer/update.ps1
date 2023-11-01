# General Warning.
function Warning {
    Write-Host "WARNING:" -ForegroundColor Red
    Write-Host "This script does not keep backups, it replaces and deletes the binaries " -ForegroundColor Green
    Write-Host "and downloaded archives. If you need more functionality then please copy:" -ForegroundColor Green
    Write-Host "installer/update.ps1 --> installer/xupdate.ps1" -ForegroundColor Green
    Write-Host "and modify the new file to your needs, update.bat will prefer that file if" -ForegroundColor Green
    Write-Host "it exists." -ForegroundColor Green
}

# 7z
$env:Path += ";C:\Program Files\7-Zip\;"

# Extracting
function Extract-Archive {
    Write-Host "Extracting" $file -ForegroundColor Green
    & 7z.exe x -y $file
}

# Download, extract and remove
function Update-Mpv {
    $link = "https://github.com/rorgoroth/mingw-cmake-env/releases/download/latest/mpv.7z"
    $file = "mpv.7z"
    Write-Host "Downloading" $file -ForegroundColor Green
    Invoke-WebRequest -Uri $link -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox -OutFile $file
    Extract-Archive
    Remove-Item -Force $file
}

function Update-Ytdlp {
    $link = "https://github.com/rorgoroth/yt-dlp/releases/download/latest/yt-dlp.exe"
    $file = "yt-dlp.exe"
    Write-Host "Downloading" $file -ForegroundColor Green
    Invoke-WebRequest -Uri $link -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox -OutFile $file
}

# Run the whole lot here
try {
    Update-Mpv
    Update-Ytdlp
    Write-Host "Operation completed" -ForegroundColor Magenta
    Write-Host
    Warning
}
catch [System.Exception] {
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
