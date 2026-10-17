# 7z
if ($null -eq (Get-Command "7z.exe" -ErrorAction SilentlyContinue)) {
    Write-Host "7z not found, please install it or add it to your PATH." -ForegroundColor Red
    exit 1
}

# Extracting
function Extract-Archive {
    Write-Host "Extracting" $file -ForegroundColor Green
    & 7z.exe x -y $file
    if ($LASTEXITCODE -ne 0) {
        throw "7z failed to extract $file (exit code $LASTEXITCODE)"
    }
}

# Download, extract and remove
function Update-FFmpeg {
    $link = "https://github.com/rorgoroth/mingw-cmake-env/releases/download/latest/ffmpeg-full.7z"
    $file = "ffmpeg-full.7z"
    Write-Host "Downloading" $file -ForegroundColor Green
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $link -UserAgent ([Microsoft.PowerShell.Commands.PSUserAgent]::Chrome) -OutFile $file
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
