##For use in Windows PowerShell to remove all software names that contain Autodesk
##Use at your own Risk!

$products = Get-WmiObject -Class Win32_Product | Where-Object { 
    $_.Name -like "*Autodesk*"
}

foreach ($product in $products) {
    $productName = $product.Name
    $productVersion = $product.Version
    Write-Host "Uninstalling $productName version $productVersion..."
    $result = $product.Uninstall()
    Write-Host "Uninstallation result: $result"
}
