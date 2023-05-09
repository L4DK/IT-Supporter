function Get-PCInfo {
    param (
        [string]$ComputerName = $env:COMPUTERNAME
    )

    $computerSystem = Get-CimInstance CIM_ComputerSystem -ComputerName $ComputerName
    $os = Get-CimInstance CIM_OperatingSystem -ComputerName $ComputerName
    $cpu = Get-CimInstance CIM_Processor -ComputerName $ComputerName
    $storage = Get-CimInstance Win32_LogicalDisk -ComputerName $ComputerName -Filter "DriveType=3"
    $ram = Get-CimInstance CIM_PhysicalMemory -ComputerName $ComputerName

    $info = [PSCustomObject]@{
        ComputerName = $computerSystem.Name
        Manufacturer = $computerSystem.Manufacturer
        Model = $computerSystem.Model
        CPU = $cpu.Name
        Cores = $cpu.NumberOfCores
        LogicalProcessors = $cpu.NumberOfLogicalProcessors
        TotalRAM = [math]::Round($ram.Capacity.Sum() / 1GB, 2)
        OS = $os.Caption
        OSVersion = $os.Version
        OSArchitecture = $os.OSArchitecture
        Storage = $storage | Select-Object DeviceID, @{Name="Size (GB)"; Expression={[math]::Round($_.Size / 1GB, 2)}}, @{Name="Free Space (GB)"; Expression={[math]::Round($_.FreeSpace / 1GB, 2)}}
    }

    $reportDate = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
    $outputFileName = "$($info.ComputerName)_PCInfo_$reportDate.txt"

    $info | Format-List | Out-File $outputFileName

    return $info
}

$pcInfo = Get-PCInfo -ComputerName "RemoteComputerName"
$pcInfo
