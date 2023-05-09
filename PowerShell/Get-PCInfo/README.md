NAME: Get-PCInfo

EXPLANATION: 
This script retrieves detailed information about a specified computer or the local machine by default, such as the CPU, RAM, storage, and OS. 
It then generates a TXT report containing the gathered information. The report includes the computer name, date, and time of generation.


USE CASES: 
Diagnosing hardware and software issues, inventory management, general system troubleshooting, and collecting system information for remote machines.


HOW TO USE:
1. Save the script as Get-PCInfo.ps1 on your computer.
2. Create a batch file named run_pcinfo.bat with the provided code and update the path to the script.
3. Run the batch file to execute the PowerShell script and generate the TXT report.


Script Features:
* Retrieves comprehensive system information, including CPU, RAM, OS, and storage details.
* Supports querying remote machines by specifying the computer name.
* Generates a TXT report with the computer name, date, and time of report generation.
