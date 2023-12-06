$softwareNames = @("Autodesk Revit", "Navisworks", "AutoCAD")

foreach ($name in $softwareNames) {
    $path = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall", "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
    $path | Get-ChildItem | Get-ItemProperty | Where-Object { $_.DisplayName -like "*$name*" } | ForEach-Object {
        Write-Host "Found residual entry for $($_.DisplayName). Deleting..."
        Remove-Item $_.PSPath -Recurse -Force
    }
}
