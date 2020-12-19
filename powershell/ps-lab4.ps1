# Create a system information script to report several items of information about the running system

# Include the system hardware description (win32_computersystem) done
# Include the operating system name and version number (win32_operatingsystem) done 
# Include processor description with speed, number of cores, and sizes of L1, L2, and L3 cache (win32_processor) done
# Include a summary of the RAM installed with the vendor, description, size, and bank and slot for each DIMM as a table and the total RAM installed in the computer as a summary line after the table (win32_physicalmemory) done
# Include a summary of the physical disk drives with their vendor, model, size, and space usage (size, free space, and percentage free) of the logical disks on them as a single table with one logical disk per output line (win32_diskdrive, win32_diskpartition, win32_logicaldisk). You will need to use a nested foreach something like this: ```powershell $diskdrives = Get-CIMInstance CIM_diskdrive done
# foreach ($disk in $diskdrives) { $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition foreach ($partition in $partitions) { $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk foreach ($logicaldisk in $logicaldisks) { new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer Location=$partition.deviceid Drive=$logicaldisk.deviceid “Size(GB)”=$logicaldisk.size / 1gb -as [int] } } } } ```
# Include your network adapter configuration report from lab 3 done
# Include the video card vendor, description, and current screen resolution in this format: horizontalpixels x verticalpixels (win32_videocontroller) done

Import-Module SystemInfoFunctions

if ($args.Contains("-System")) {
    # ComputerSystem
    ProcessorInfo
    OperatingSystem
    PhysicalMemory
    VideoController
}
if ($args.Contains("-Disks")) {
    DiskDriveInformation
}
if ($args.Contains("-Network")) {
    AdapterSpecs
}

if ($args.length -lt 1) {
    Write-Output "Write out -System, -Disks, or -Network"
}