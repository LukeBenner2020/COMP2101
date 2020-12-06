# Create a script which produces a report showing the ip configuration for the computer.

# Where-Object
# Sort-Object
# Select-Object
# Script Blocks
# Operators
# Variables
# Hash Notation for property creation

#Use the get-ciminstance command as shown below to get a collection of network adapter configuration objects.
#Use a pipeline with a where-object filter on the ipenabled property to only include enabled adapters in your report.
#each adapter that is configured: the adapter description, index, ip address(es), subnet mask(s), dns domain name, and dns server.
#Use format-table to format your output.

$adapterSpec = get-ciminstance win32_networkadapterconfiguration | 
    Sort-Object Index |
    Where-Object { $_.ipenabled -eq $True  } |
    Format-Table Description,Index,IPAddress,IPSubnet,DNSDomain,@{n="DNSServer";e={$_.DNSServerSearchOrder[0]}}
$adapterSpec
