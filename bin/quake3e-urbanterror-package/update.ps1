# 7z
if ((Get-Command "7z.exe" -ErrorAction SilentlyContinue) -eq $null) {
    Write-Host "7z not found, please install it or add it to your $PATH."
}

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
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $link -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::Chrome -OutFile $file
    $ProgressPreference = 'Continue'
    Extract-Archive
    Remove-Item -Force $file
}

# Run the whole lot here
try {
    Update-Q3eURT
    Write-Host "Operation completed" -ForegroundColor Magenta
}
catch [System.Exception] {
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
