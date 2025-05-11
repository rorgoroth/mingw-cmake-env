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
function Update-Xonotic {
    $link = "https://github.com/rorgoroth/mingw-cmake-env/releases/download/latest/xonotic.7z"
    $file = "xonotic.7z"
    Write-Host "Downloading" $file -ForegroundColor Green
    Invoke-WebRequest -Uri $link -UserAgent [Microsoft.PowerShell.Commands.PSUserAgent]::Chrome -OutFile $file
    Extract-Archive
    Remove-Item -Force $file
}

# Run the whole lot here
try {
    Update-Xonotic
    Write-Host "Operation completed" -ForegroundColor Magenta
}
catch [System.Exception] {
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}
