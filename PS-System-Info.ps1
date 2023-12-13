## Identify Motherboard Model
  wmic baseboard get product,Manufacturer,version,serialnumber

## Identify Model and Manufacturer
  systeminfo | findstr /C:"System Manufacturer" /C:"System Model"

## Total Hardware Information
  # Get Motherboard information
Get-WmiObject -Class Win32_BaseBoard | Format-Table -Property Product, Manufacturer, Version, SerialNumber -AutoSize

  # Get BIOS information
Get-WmiObject -Class Win32_BIOS | Format-Table -Property Caption, Version, SerialNumber -AutoSize

  # Get RAM information
Get-WmiObject -Class Win32_PhysicalMemory | Format-Table -Property Capacity, Speed -AutoSize

  # Get Hard Drive information
Get-WmiObject -Class Win32_DiskDrive | Format-Table -Property Caption, Size -AutoSize

  # Get CPU information
Get-WmiObject -Class Win32_Processor | Format-Table -Property Caption -AutoSize

  # Get GPU information
Get-WmiObject -Class Win32_VideoController | Format-Table -Property Caption -AutoSize

## Useful tool to manage software on Windows
  https://github.com/ChrisTitusTech/winutil

  iwr -useb https://christitus.com/win | iex
