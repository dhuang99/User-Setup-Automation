
###########################################################################################
#CONNECT TO WIFI
###########################################################################################
try {
    write-output "Connecting to Wifi..." 
    & "\\....cmd"
    & "\\...vbs"
   
    write-host "Connected to Wifi!" -ForegroundColor Green
    
} 
catch {
    Write-Host "An error occurred:" -ForegroundColor Red
    Write-Host $_ -ForegroundColor Red
}
pause


###########################################################################################
#PULL UP APP ADMINISTRATOR
###########################################################################################
write-output "`n`n`n`n`nLaunching App Administrator...`n"

& "C:\Program Files\App..."

write-output "Please click on to Tools > Register to register the device"
write-output "Then please go to the tab and uncheck 'Display PDF in Internet Explorer' `n"
write-output "Press enter once you have completed these two steps"

pause
###########################################################################################
#CHANGE SECURITY SETTINGS OF PUBLIC DESKTOP FOR INTERACTIVE
###########################################################################################
try {
    write-output "`n`n`n`n`nChanging Security Permissions for INTERACTIVE for the Public Desktop Folder..."

    $acl = Get-Acl "C:\Users\Public\Desktop"

    $inherit = [System.Security.AccessControl.InheritanceFlags]::ContainerInherit ` -bor [System.Security.AccessControl.InheritanceFlags]::ObjectInherit
    $Prop =[System.Security.AccessControl.PropagationFlags]::None

    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("NT AUTHORITY\INTERACTIVE", "Modify", $inherit, $Prop, "Allow")

    $acl.SetAccessRule($AccessRule)

    $acl | Set-Acl "C:\Users\Public\Desktop"

    
    write-host "Successfully Changed the Security Permissions!" -ForegroundColor Green
    
}
catch {
    Write-Host "An error occurred:" -ForegroundColor Red
    Write-Host $_ -ForegroundColor Red
}

pause
###########################################################################################
#COPY THE PRINTER AND HELP DESK REMOTE SUPPORT TO PUBLIC DESKTOP
###########################################################################################
try {
    write-output "`n`n`n`n`nMoving 'Rockville Printers', 'Help Desk Remote Support', and 'Win 10 Welcome Packet' to Public Desktop"

    if (test-path "\\davisconstruction.com\root\Installs\Printer Drivers") {
        Copy-Item "\\Print link" "C:\Users\Public\Desktop"
        Copy-Item "\\Print link" "C:\Users\Public\Desktop"
        Copy-Item "\\Print link" "C:\Users\Public\Desktop"
        write-host "Successfully copied all files!" -ForegroundColor Green
    }
} catch {
    Write-Host "An error occurred:" -ForegroundColor Red
    Write-Host $_ -ForegroundColor Red
}
pause 

###########################################################################################
#TURN OFF HIBERNATE
###########################################################################################
try {
    write-output "`n`n`n`n`nTurning off hibernate..."
    powercfg /hibernate off

     write-host "Success!" -ForegroundColor Green
  
} catch {
    Write-Host "An error occurred:" -ForegroundColor Red
    Write-Host $_ -ForegroundColor Red
}
pause 



###########################################################################################
#DOWNLOAD SUPPORT ASSIST AND INSTALL, LAUNCH SUPPORT.DELL.COM
###########################################################################################

#Function for checking whether the file is currently in use
function IsFileLocked([string]$filePath){
    Rename-Item $filePath $filePath -ErrorVariable errs -ErrorAction SilentlyContinue
    return ($errs.Count -ne 0)
}


$InstallerPath = "C:\Users\$($env:UserName)\Downloads\SupportAssistInstaller.exe"

#Accounts for previous faulty downloads
if (test-path $InstallerPath) {
    remove-item $InstallerPath
}

#Trys to download SupportAssist
try {
    $url = "https://downloads.dell.com/serviceability/catalog/SupportAssistInstaller.exe"
    
      
    write-output "`n`n`n`n`nDownloading SupportAssist..."

    Invoke-WebRequest -Uri $url -OutFile $InstallerPath

    write-host "Success!" -ForegroundColor Green
 
} catch {
    Write-Host "An error occurred:" -ForegroundColor Red
    Write-Host $_ -ForegroundColor Red
}

#Checks to see if the download was successful
if (-not (test-path $InstallerPath)) {
    write-host "Could not download SupportAssist...Please go to support.dell.com directly to download SupportAssist." -ForegroundColor Red
    write-host "Launching support.dell.com...."
    Start-Sleep -Seconds 3
    Start-Process -FilePath '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"' -ArgumentList 'https://www.dell.com/support/home/us/en/04/?c=us&l=en&s=bsd'
    exit   
}

#Timer and Sleep if SupportAssist is in use by another program
$timer = 0
while (IsFileLocked($InstallerPath) -and $timer -le 60) {
    write-host "SupportAssist is still in use..."
   
    $timer += 1
    Start-Sleep -Seconds 1
}

#If waiting for the download does not time out...
if ($timer -le 60) { 

    try {
        #Runs if there are no problems
        write-output "Installing SupportAssist..."
        & "C:\Users\$($env:Username)\Downloads\SupportAssistInstaller.exe"
      
        write-host "Success!" -ForegroundColor Green
        write-output "Will redirect to support.dell.com in 30 seconds. Please click on 'Detect PC' then choose 'Drivers & Downloads' and click on 'Detect Drivers'`n"
        write-host "Remember to uninstall SupportAssist after restarting the computer!" -ForegroundColor Yellow -BackgroundColor Black
        Start-Sleep -Seconds 30
        write-output "Launching support.dell.com...`n"
        Start-Process -FilePath '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"' -ArgumentList 'https://www.dell.com/support/home/us/en/04/?c=us&l=en&s=bsd'
        
    
    } catch {
        #If any error is returned
        Write-Host "An error occurred:" -ForegroundColor Red
        Write-Host $_ -ForegroundColor Red

        write-host "Oops something went wrong! Please just go to 'support.dell.com' and download SupportAssist to get the correct drivers for the computer."
        Start-Process -FilePath '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"' -ArgumentList 'https://www.dell.com/support/home/us/en/04/?c=us&l=en&s=bsd'
        write-host "Remember to uninstall SupportAssist after restarting the computer!" -ForegroundColor Yellow -BackgroundColor Black
    }
} else { #If the download does time out
    write-host "Downloading SupportAssist has timed out. Please go to support.dell.com directly to download SupportAssist." -ForegroundColor Red
    write-host "Launching support.dell.com...."
    Start-Sleep -Seconds 5
    Start-Process -FilePath '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"' -ArgumentList 'https://www.dell.com/support/home/us/en/04/?c=us&l=en&s=bsd'
}

pause



