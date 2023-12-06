##For use in Windows PowerShell to remove all residual registry keys that contain Autodesk
##Use at your own Risk!

$autodeskRegistryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
)

foreach ($path in $autodeskRegistryPaths) {
    Get-ChildItem -Path $path | 
    Get-ItemProperty | 
    Where-Object { $_.DisplayName -like "*Autodesk*" } | 
    ForEach-Object {
        $displayName = $_.DisplayName
        Write-Host "Found residual Autodesk entry: $displayName. Deleting..."
        Remove-Item $_.PSPath -Recurse -Force
    }
}
