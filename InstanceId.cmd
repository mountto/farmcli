rem /**
rem * farmcli: Phone Farm command-line interface.
rem *
rem * @copyright Copyright (c) 2026, Hoàng Hải <leduchoanghai@yahoo.com>
rem * @license   MIT, http://www.opensource.org/licenses/mit-license.php
rem */

@echo off
rem "lists all SAMSUNG Mobile USB Composite Device Android devices connected to a computer via USB or Wi-Fi and redirects its output to a new file named InstanceId.txt"

powershell "Get-PnpDevice -PresentOnly -Class USB | Where-Object { $_.InstanceId -match '^USB\\VID_04E8&PID_6860' } | Select-Object @{n='InstanceID';e={$_.InstanceId -replace '^PCI\\(.*?)&REV.*$','$1'}}" > \\your path\InstanceId.txt
echo "FIN"
pause