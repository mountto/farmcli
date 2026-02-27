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

Do {
 Write-Host "Press any key to continue"
	
		$Key = [Console]::ReadKey($True)

switch ($Key.Key) 
{
     ([ConsoleKey]::G) {
	write-host "Welcome G: Returns information about PnP devices. "
foreach($line in [System.IO.File]::ReadLines("\\your path\InstanceId.txt"))
{
#    Write-Output $line
	Get-PnpDevice -InstanceId $line | Format-Table -AutoSize
#		Write-Output $device

}
	}	
	
([ConsoleKey]::I) {
	write-host "Welcome I: Disables a PnP device "
	$input = Read-Host -Prompt 'Input your InstanceId name of device:  '

		Disable-PnpDevice -InstanceID $input -Confirm:$false
		Write-Output $input "==>Disabled"		

#    Write-Output $line
#	Get-PnpDevice -InstanceId $line
#		Write-Output $device


	}		
([ConsoleKey]::O) {
	write-host "Welcome O: Enables a PnP device"
	$input = Read-Host -Prompt 'Input your InstanceId name of device:  '

		Enable-PnpDevice -InstanceID $input -Confirm:$false
		Write-Output $input "==>Enabled"		

#    Write-Output $line
#	Get-PnpDevice -InstanceId $line
#		Write-Output $device


	}		
	
     ([ConsoleKey]::D) {
	write-host "Welcome D: Disables a PnP devices from file \InstanceId.txt "
foreach($line in [System.IO.File]::ReadLines("\\your path\InstanceId.txt"))
{
		Write-Output "Loading..."
#    Write-Output $line
#	Enable-PnpDevice -InstanceID $line -Confirm:$false
$device = Get-PnpDevice -InstanceId $line | Select-Object -Property Status
$prefix = "Error"
Write-Output $device.Status
Write-Output $prefix
$startsWithPrefix = $device.Status.StartsWith($prefix)
	if ($startsWithPrefix){
		Write-Output $line "Disabled"
	}else{
		Disable-PnpDevice -InstanceID $line -Confirm:$false
		Write-Output $line "==>Disabled"		
	}
}
	}
     ([ConsoleKey]::E) {
	write-host "Welcome E: Enables a PnP devices from file \InstanceId.txt"
foreach($line in [System.IO.File]::ReadLines("\\your path\InstanceId.txt"))
{
#    Write-Output $line
		Write-Output "Loading..."
$device = Get-PnpDevice -InstanceId $line | Select-Object -Property Status
$prefix = "OK"
Write-Output $device.Status
Write-Output $prefix
$startsWithPrefix = $device.Status.StartsWith($prefix)
	if ($startsWithPrefix){	
		Write-Output $line "Enabled"
	}else{
		Enable-PnpDevice -InstanceID $line -Confirm:$false
		Write-Output $line "==>Enabled"
	}
}
}
     ([ConsoleKey]::Escape) {
	write-host "See U again /"
break 
}
		  default {
#			  'Press any key to continue' 
			  write-host "Type 'G': Get-PnpDevice list from file \InstanceId.txt"
		  write-host "Type 'I': Disables a PnP device"
		  write-host "Type 'O': Enables a PnP device"
			  write-host "Type 'D': Disable-PnpDevice list from file \InstanceId.txt"
			  write-host "Type 'E': Enable-PnpDevice list from file \InstanceId.txt"
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

