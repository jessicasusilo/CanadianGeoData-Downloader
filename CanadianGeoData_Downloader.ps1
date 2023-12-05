################## Canadian Geo*Data ##################

#################### Set Variables ####################

# License string
$license            = "your_license"

# Release version
$release_version    = "latest"  

# Target directory - where you want to download files to; The default is current directory.
$target_directory   = Get-Location

# Program directory - where you put MelissaUpdater.exe; The default is current directory.
# Melissa Updater source code: https://github.com/MelissaData/MelissaUpdater
# Melissa Updater binary download link: https://releases.melissadata.net/Download/Library/WINDOWS/NET/ANY/latest/MelissaUpdater.exe
$program_directory  = "$target_directory\MelissaUpdater" 
$program_path       = "$program_directory\MelissaUpdater.exe" 



##################### Functions #######################
 
function Get-File {
    param (
      [parameter(Mandatory=$true)][String]$Filename,
      [parameter(Mandatory=$false)][String]$Type,
      [parameter(Mandatory=$true)][String]$OperatingSystem,
      [parameter(Mandatory=$true)][String]$Compiler,
      [parameter(Mandatory=$true)][String]$Architecture,
      [parameter(Mandatory=$true)][String]$TargetDirectory,
      [parameter(Mandatory=$false)][String]$WorkingDirectory
    )
       
    $path = "$target_directory\$TargetDirectory" 
    
    $verifyPath = "$target_directory\$TargetDirectory\$Filename"
    $params = "verify", "-p", "$verifyPath"
    & $program_path $params
    
    if($? -eq $False) {
      Invoke-Expression "$program_path file -f -n `"$Filename`" -r `"$release_version`" -l `"$license`" -y `"$Type`" -o `"$OperatingSystem`" -c `"$Compiler`" -a `"$Architecture`" -t `"$path`" " 
    } else {
      Invoke-Expression "$program_path file -n `"$Filename`" -r `"$release_version`" -l `"$license`" -y `"$Type`" -o `"$OperatingSystem`" -c `"$Compiler`" -a `"$Architecture`" -t `"$path`" " 
    }
}

function Get-Manifest {
    param (
      [parameter(Mandatory=$true)][String]$ProductName,
      [parameter(Mandatory=$true)][String]$TargetDirectory,
      [parameter(Mandatory=$false)][String]$WorkingDirectory
    )
       
    $path = "$target_directory\$TargetDirectory" 

    Invoke-Expression "$program_path manifest -p `"$ProductName`" -r `"$release_version`" -l `"$license`" -t `"$path`" " 
}

######################## Main #########################

###################
# Section 1: Data #
###################

# Canadian Geo*Data

# dbf
$target_path = "Data\dbf"
Get-File -Filename "canada.dbf" -Type "DATA" -OperatingSystem "ANY" -Compiler "ANY" -Architecture "ANY" -TargetDirectory $target_path

Get-File -Filename "overlay.dbf" -Type "DATA" -OperatingSystem "ANY" -Compiler "ANY" -Architecture "ANY" -TargetDirectory $target_path

# mdb
$target_path = "Data\mdb"
Get-File -Filename "canada.mdb" -Type "DATA" -OperatingSystem "ANY" -Compiler "ANY" -Architecture "ANY" -TargetDirectory $target_path

# text
$target_path = "Data\text"
Get-File -Filename "canada.txt" -Type "DATA" -OperatingSystem "ANY" -Compiler "ANY" -Architecture "ANY" -TargetDirectory $target_path

Get-File -Filename "overlay.txt" -Type "DATA" -OperatingSystem "ANY" -Compiler "ANY" -Architecture "ANY" -TargetDirectory $target_path
