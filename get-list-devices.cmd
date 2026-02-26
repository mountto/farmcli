rem /**
rem * farmcli: Phone Farm command-line interface.
rem *
rem * @copyright Copyright (c) 2026, Hoàng Hải <leduchoanghai@yahoo.com>
rem * @license   MIT, http://www.opensource.org/licenses/mit-license.php
rem */

@echo off
rem "lists all Android devices connected to a computer via USB or Wi-Fi and redirects its output to a new file named devices.txt"
adb devices > \\your path\devices.txt

echo "FIN"
pause
