# 7z
$env:Path += ";C:\Program Files\7-Zip\;"

# Extracting
function Extract-Archive {
    Write-Host "Extracting" $file -ForegroundColor Green
    & 7z.exe x -y $file
}

# Download, extract and remove
function Update-FFmpeg {
    $link = "https://github.com/rorgoroth/mingw-cmake-env/releases/download/latest/ffmpeg.7z"
    $file = "ffmpeg.7z"
    Write-Host "Downloading" $file -ForegroundColor Green
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $link -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::Chrome -OutFile $file
    $ProgressPreference = 'Continue'
    Extract-Archive
    Remove-Item -Force $file
}

# Run the whole lot here
try {
    Update-FFmpeg
    Write-Host "Operation completed" -ForegroundColor Magenta
}
catch [System.Exception] {
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
