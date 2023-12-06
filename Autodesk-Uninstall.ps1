$products = Get-WmiObject -Class Win32_Product | Where-Object { 
    $_.Name -like "*Autodesk Revit*" -or
    $_.Name -like "*Navisworks*" -or
    $_.Name -like "*AutoCAD*"
}

foreach ($product in $products) {
    $productName = $product.Name
    $productVersion = $product.Version
    Write-Host "Uninstalling $productName version $productVersion..."
    $result = $product.Uninstall()
    Write-Host "Uninstallation result: $result"
}
