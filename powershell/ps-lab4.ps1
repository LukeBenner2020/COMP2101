# Create a system information script to report several items of information about the running system

# Include the system hardware description (win32_computersystem) done
# Include the operating system name and version number (win32_operatingsystem) done 
# Include processor description with speed, number of cores, and sizes of L1, L2, and L3 cache (win32_processor) done
# Include a summary of the RAM installed with the vendor, description, size, and bank and slot for each DIMM as a table and the total RAM installed in the computer as a summary line after the table (win32_physicalmemory) done
# Include a summary of the physical disk drives with their vendor, model, size, and space usage (size, free space, and percentage free) of the logical disks on them as a single table with one logical disk per output line (win32_diskdrive, win32_diskpartition, win32_logicaldisk). You will need to use a nested foreach something like this: ```powershell $diskdrives = Get-CIMInstance CIM_diskdrive done
# foreach ($disk in $diskdrives) { $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition foreach ($partition in $partitions) { $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk foreach ($logicaldisk in $logicaldisks) { new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer Location=$partition.deviceid Drive=$logicaldisk.deviceid “Size(GB)”=$logicaldisk.size / 1gb -as [int] } } } } ```
# Include your network adapter configuration report from lab 3 done
# Include the video card vendor, description, and current screen resolution in this format: horizontalpixels x verticalpixels (win32_videocontroller) done

#Computer System Information
function ComputerSystem {
Get-WmiObject win32_computersystem |
Format-List description
}

#Operating System Information
function OperatingSystem {
$operatingSystem = Get-WmiObject win32_operatingsystem |
format-list Name, version
$operatingSystem
}

#Processor Information
function ProcessorInfo {
$processor = Get-WmiObject -class win32_processor
Get-WmiObject -class Win32_CacheMemory | 
sort-object DeviceID |
format-list CurrentClockSpeed, description, NumberOfCores, DeviceID,@{e={($_.BlockSize*$_.NumberOfBlocks)};n="Size KB"}
$processor
}

#Physical Memory Information
function PhysicalMemory {
$physicalMemory = Get-WmiObject -class win32_physicalmemory

$physicalMemoryProperties = $physicalMemory | format-table Tag, description, capacity, BankLabel, DeviceLocator
$physicalMemoryProperties
$totalRAM = $physicalMemory | Measure-Object -Property Capacity -Sum 
write-output "Total RAM: $($totalRAM.Sum) bytes"
}

#Disk Drive information
function DiskDriveInformation {
$diskdrives = Get-CIMInstance CIM_diskdrive

    foreach ($disk in $diskdrives) {
    $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
            foreach ($partition in $partitions) {
                $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
                foreach ($logicaldisk in $logicaldisks) {
                     new-object -typename psobject -property @{Model=$disk.Model
                                                               "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                               Vendor=$logicaldisk.vendor
                                                               "Free Space("=$logicaldisk.FreeSpace / 1gb -as [int]
                                                               }
                }
             }
    } 
}

#network adapter configuration report from lab 3
function AdapterSpecs{
$adapterSpec = Get-WmiObject win32_networkadapterconfiguration |
Sort-Object Index | Where-Object { $_.ipenabled -eq $True  } |
Format-Table Description,Index,IPAddress,IPSubnet,DNSDomain,@{n="DNSServer";e={$_.DNSServerSearchOrder[0]}}
$adapterSpec
}

#Video Card Information
function VideoController {
$resolution = Get-WmiObject win32_videocontroller | 
Format-list description, vendor, @{n='Resolution';e={-join $_.VideoModeDescription[0..10] }}
$resolution
}

ComputerSystem
OperatingSystem
ProcessorInfo
PhysicalMemory
DiskDriveInformation
AdapterSpecs
VideoController