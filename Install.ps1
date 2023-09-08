###############################
#HP Universal Print Driver  #
################################
$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$drivername = "HP Universal Printing PCL 6"
$portName = "IP_192.168.68.114"
$PortAddress = "192.168.68.114"

###################
#Staging Drivers   #
###################
C:\Windows\SysNative\pnputil.exe /add-driver "$psscriptroot\Driver\hpcu270u.inf" /install

#######################
#Installing Drivers   #
#######################

Add-PrinterDriver -Name $drivername

##########################################################
#Install Printerport | check if the port already exist   #
##########################################################
$checkPortExists = Get-Printerport -Name $portname -ErrorAction SilentlyContinue
if (-not $checkPortExists) 
{
Add-PrinterPort -name $portName -PrinterHostAddress $PortAddress
}

####################################
#Check if PrinterDriver Exists     #
####################################
$printDriverExists = Get-PrinterDriver -name $DriverName -ErrorAction SilentlyContinue


##################
#Install Printer #
##################
if ($printDriverExists)
{
Add-Printer -Name "Matt's Office Printer" -PortName $portName -DriverName $DriverName
}
else
{
Write-Warning "Printer Driver not installed"
}

SLEEP 360