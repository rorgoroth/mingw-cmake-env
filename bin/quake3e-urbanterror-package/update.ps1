# 7z
$env:Path += ";C:\Program Files\7-Zip\;"

# Extracting
function Extract-Archive {
    Write-Host "Extracting" $file -ForegroundColor Green
    & 7z.exe x -y $file
}

# Download, extract and remove
function Update-Q3eURT {
    $link = "https://github.com/rorgoroth/mingw-cmake-env/releases/download/latest/quake3e-urbanterror.7z"
    $file = "quake3e-urbanterror.7z"
    Write-Host "Downloading" $file -ForegroundColor Green
    Invoke-WebRequest -Uri $link -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox -OutFile $file
    Extract-Archive
    Remove-Item -Force $file
}

# Download, extract and remove
function Update-FFmpeg {
    $link = "https://github.com/rorgoroth/mingw-cmake-env/releases/download/latest/ffmpeg.7z"
    $file = "ffmpeg.7z"
    Write-Host "Downloading" $file -ForegroundColor Green
    Invoke-WebRequest -Uri $link -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::FireFox -OutFile $file
    Extract-Archive
    Remove-Item -Force $file
}

# Run the whole lot here
try {
    Update-Q3eURT
    Update-FFmpeg
    Write-Host "Operation completed" -ForegroundColor Magenta
}
catch [System.Exception] {
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
