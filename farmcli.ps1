# /**
# * farmcli: Phone Farm command-line interface.
# *
# * @copyright Copyright (c) 2026, Hoàng Hải <leduchoanghai@yahoo.com>
# * @license   MIT, http://www.opensource.org/licenses/mit-license.php
# */


	[CmdLetbinding()]
	param([string]$p1, [string]$p2, [string]$p3, [string]$p4)

Function Check-RunAsAdministrator()
{

  #Get current user context
  $CurrentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  
  #Check user is running the script is member of Administrator Group
  if($CurrentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator))
  {
       Write-host "Script is running with Administrator privileges!"
  }
  else
    {
       #Create a new Elevated process to Start PowerShell
       $ElevatedProcess = New-Object System.Diagnostics.ProcessStartInfo "PowerShell";
 
       # Specify the current script path and name as a parameter
       $ElevatedProcess.Arguments = "& '" + $script:MyInvocation.MyCommand.Path + "'"
 
       #Set the Process to elevated
       $ElevatedProcess.Verb = "runas"
 
       #Start the new elevated process
       [System.Diagnostics.Process]::Start($ElevatedProcess)

       #Exit from the current, unelevated, process
       Exit
 
    }
}
 
#Check Script is running with Elevated Privileges
Check-RunAsAdministrator
 
#Place your script here.
write-host "Welcome"
$Script:args=""
write-host "PSBoundParameters.Count: " $PSBoundParameters.Count
write-host "PSBoundParameters.Keys.Count: " $PSBoundParameters.Keys.Count
write-host "Args.Count: " $Args.Count
write-host "Content Args1: $p1" $p1
write-host "Content Args2: $p2" $p2
write-host "Content Args3: $p3" $p3
write-host "Content Args4: $p4" $p4
# Nhap Array List
$devices = [System.Collections.Generic.List[string]]::new()
$index = 0
foreach($line in [System.IO.File]::ReadLines("\\your path\devices.txt"))
{
#    Write-Output $line
	$devices.Add($line)
#		Write-Output "==>Device: "$devices[$index]" ->Xoa proxy"
	$index++

}
$proxys = [System.Collections.Generic.List[string]]::new()
$index = 0
foreach($line in [System.IO.File]::ReadLines("\\your path\proxys.txt"))
{
#    Write-Output $line
	$proxys.Add($line)
#		Write-Output "==>Device: "$proxys[$index]" ->Xoa proxy"
	$index++

}
$youtubes = [System.Collections.Generic.List[string]]::new()
$index = 0
foreach($line in [System.IO.File]::ReadLines("\\your path\youtubes.txt"))
{
#    Write-Output $line
	$youtubes.Add($line)
#		Write-Output "==>Device: "$youtubes[$index]" ->Xoa proxy"
	$index++

}
# Nhap Array List

		Write-Output  "==>Devices :"$devices.count #Enumerable.Count($devices) 
		Write-Output  "==>proxys :"$proxys.count #Enumerable.Count($proxys)
		Write-Output  "==>youtubes :"$youtubes.count #Enumerable.Count($youtubes)

Do {
 Write-Host "Press any key to continue"
	
		$Key = [Console]::ReadKey($True)

switch ($Key.Key) 
{
     ([ConsoleKey]::X) {
	write-host "Welcome X: Remove Proxy"
foreach($line in [System.IO.File]::ReadLines("\\your path\devices.txt"))
{
#    Write-Output $line
	adb -s $line shell settings put global http_proxy :0
		Write-Output "==>Device: $line ->Remove proxy"

}
	}	
	
([ConsoleKey]::P) {

		write-host "Welcome P: Add Proxy"
		$dindex=0
		for ( $pindex = 0; $pindex -lt $proxys.count; $pindex++)
		{
			if($pindex -eq $devices.count){
			$dindex=0
			$input = Read-Host -Prompt 'Press Enter to continue:  '
			Write-Output $input "==> Done"				
			write-host "==================================================="
			}
		"Item[$dindex]: [{0}]" -f $devices[$dindex]
		adb -s $devices[$dindex] shell settings put global http_proxy :0
		"Remove proxy -> Item[$dindex]: [{0}]" -f $devices[$dindex]

#		Write-Output $devices[$dindex]"->Remove proxy"	
		$string1 = $proxys[$pindex] -split ":"		
		adb -s $devices[$dindex] shell settings put global http_proxy $proxys[$pindex]
		adb -s $devices[$dindex] shell settings put global global_http_proxy_host $string1[0]
		adb -s $devices[$dindex] shell settings put global global_http_proxy_port $string1[1]
		"Add proxy -> Item[$dindex]: [{0}]" -f $proxys[$pindex]
		
#		Write-Output $devices[$dindex] $proxys[$pindex]"->Add proxy"			
#			adb -s $devices[$dindex] shell am start -a android.intent.action.VIEW -d $proxys[$pindex]
#			write-host $devices[$dindex]  $proxys[$pindex] "`n==================================================`n"
			$dindex++

		}




}		
([ConsoleKey]::C) {
	write-host "Welcome C: Check Proxy"
	
	for ( $index = 0; $index -lt $devices.count; $index++)
	{
		"Item[$index]: [{0}]" -f $devices[$index]
		adb -s $devices[$index] shell settings put global http_proxy :0
		Write-Output "`n==>Device[$index]: "$devices[$index]" ->Remove proxy"	
#				adb -s $devices[$index] shell curl -sS https://api.ipify.org/
#		Write-Output "---1---`n"
		adb -s $devices[$index] shell settings put global http_proxy $proxys[$index]
		$string1 = $proxys[$index] -split ":"
#		Write-Output "---trimend()---`n" $string1[0] "=" $string1[1] "--"
#adb -s $devices[$index] shell am start -n 'com.adbwifisettingsmanager/.WifiSettingsManagerActivity' --esn disableWifi
#adb -s $devices[$index] shell am start -n 'com.adbwifisettingsmanager/.WifiSettingsManagerActivity' --esn remove -e ssid 'all'
#adb -s $devices[$index] shell am start -n 'com.adbwifisettingsmanager/.WifiSettingsManagerActivity' --esn remove -e ssid 'All'
#adb -s $devices[$index] shell am start -n 'com.adbwifisettingsmanager/.WifiSettingsManagerActivity' --esn enableWifi
#adb -s $devices[$index] shell am start -n 'com.adbwifisettingsmanager/.WifiSettingsManagerActivity' --esn newConnection -e ssid "WiFi 02" -e password 88888888		
#adb -s $devices[$index] shell am start -n 'com.adbwifisettingsmanager/.WifiSettingsManagerActivity' --esn connect -e ssid "WiFi 03"
adb -s $devices[$index] shell settings put global http_proxy $proxys[$index]
adb -s $devices[$index] shell settings put global global_http_proxy_host $string1[0]
adb -s $devices[$index] shell settings put global global_http_proxy_port $string1[1]
		Write-Output "`n==>Device[$index]: "$devices[$index]" ->Add proxy"	
#adb -s $devices[$index] shell am start -n tk.elevenk.proxysetter/.MainActivity -e host $string1[0] -e port $string1[1] -e ssid "WiFi 02" -e key 88888888 -e reset-wifi true
#adb -s $devices[$index] shell am start -n 'com.adbwifisettingsmanager/.WifiSettingsManagerActivity' --esn connect -e ssid "WiFi 02"

#adb -s $devices[$index] shell am start -n com.steinwurf.adbjoinwifi/.MainActivity -e ssid "WiFi 02" -e password_type "WEP|WPA" -e password 88888888 -e proxy_host $string1[0] -e proxy_port $string1[1]		
#		Write-Output "`n==>Device[$index]: "$devices[$index]" ->Add proxy"	
#				adb -s $devices[$index] shell curl -sS https://api.ipify.org/
#		Write-Output "---2---`n"
#	settings put global http_proxy :0	
#	am start -n tk.elevenk.proxysetter/.MainActivity -e host 192.168.88.236 -e port 1001 -e ssid "WiFi 02" -e key 88888888 -e reset-wifi true
#		$result = adb -s $devices[$index] shell curl -sS --proxy $proxys[$index] https://api.ipify.org/
#		Start-Sleep -Seconds 7
#		Write-Output "["$result"]"
#		Write-Output "---3---`n"
		
#		adb -s $devices[$index] shell am start -a android.intent.action.VIEW -d $youtubes[$index]
		adb -s $devices[$index] shell am start -a android.intent.action.VIEW -d http://ipinfo.io/json

#		adb -s $devices[$index] shell curl -sS http://ipinfo.io/json
#		Write-Output "---4---`n"

		Write-Output "`n==>Check "$devices[$index]" - "$proxys[$index]" - "$youtubes[$index] "`n"		
	}	
		

}		
# 14.169.36.15 
# 42.112.165.171
# 171.247.153.206

([ConsoleKey]::Z) {
		write-host "Welcome Z: Open Youtube urls on all devices 1"
		$dindex=0
		for ( $yindex = 0; $yindex -lt $youtubes.count; $yindex++)
		{
			if($yindex -eq $devices.count){
			$dindex=0
			$input = Read-Host -Prompt 'Press Enter to continue:  '
			Write-Output $input "==> Done"				
			write-host "==================================================="
			}
			"Item[$dindex]: [{0}]" -f $devices[$dindex]
			adb -s $devices[$dindex] shell am start -a android.intent.action.VIEW -d $youtubes[$yindex]
			"Youtube -> Item[$dindex]: [{0}]" -f $youtubes[$yindex]
			
#			write-host $devices[$dindex]  $youtubes[$yindex]
			$dindex++

		}
}

([ConsoleKey]::E) {
	write-host "Welcome E: Open Youtube urls on all devices 2"
#		$dindex=0
		for ( $yindex = 0; $yindex -lt $youtubes.count; $yindex++)
		{
			for ( $dindex = 0; $dindex -lt $devices.count; $dindex++)
			{
			"Item[$dindex]: [{0}]" -f $devices[$dindex]
			adb -s $devices[$dindex] shell am start -a android.intent.action.VIEW -d $youtubes[$yindex]
			"Youtube -> Item[$dindex]: [{0}]" -f $youtubes[$yindex]
			
#			write-host $devices[$dindex]  $youtubes[$yindex]
			$dindex++
			}
			$input = Read-Host -Prompt 'Press Enter to continue:  '
			Write-Output $input "==> Done "				
			write-host "==================================================="			
		}
}
     ([ConsoleKey]::Escape) {
	write-host "See U again /"
break 
}
		  default {
#			  'Press any key to continue' 
			  write-host "Type 'X': Remove Proxy on all devices"
    write-host "Type 'P': Add Proxy on all devices"
    write-host "Type 'C': Check Proxy on all devices"
			  write-host "Type 'Z': Open Youtube urls on all devices 1"
			  write-host "Type 'E': Open Youtube urls on all devices 2"
			  write-host "Type 'Escape': Exit Powershell Script"
			  
			  }

}


 

foreach ($key in $PSBoundParameters.keys) {
    $Script:args+= "`$$key=" + $PSBoundParameters["$key"] + "  "
}
write-host $Script:args
# Read-Host -Prompt "Press any key to continue"

#	$Key = [Console]::ReadKey($True)
#	Write-Host $Key.Key
} While ( $Key.Key -NE [ConsoleKey]::Escape )

#Read more: https://www.sharepointdiary.com/2015/01/run-powershell-script-as-administrator-automatically.html#ixzz8FW9JkeKa

