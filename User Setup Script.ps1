###########################################################################################
#ADD JOBSITE/HQ PRINTERS
###########################################################################################

$pass = $false

while ($pass -eq $false)  {
    $printerinput = read-host "`nType in 'R' for ____________ Printers and 'J' for _________ Printers. `nIf you don't want to set up printers type 'skip'"
    #For Rockville Printers
    if ($printerinput -like "R") {
        write-host "`n`n`nLaunching _______ Printer Site..."
        Start-Sleep -Seconds 3
        Start-Process -FilePath '"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"' -ArgumentList 'http://printers/printers/'
        #Additional printers
        $addprinter = read-host "Would you like to add any more printers? [y/n]"
        if ($addprinter -like "n") {
            $pass = $true
        }
    } 
    #For jobsite printers
    elseif ($printerinput -like "J") {
        write-host "`n`nPlease go to the Jobsite Support Page on Sharepoint to find the IP address of the jobsite printer."
        write-host "This script will open Control Panel and you can add the specific printer by IP."
        write-host "`nOpening Control Panel..."
        Start-Sleep -Seconds 3
        Show-ControlPanelItem *printer*
           #Additional printers
        $addprinter = read-host "Would you like to add any more printers? [y/n]`n"
        if ($addprinter -like "n") {
            $pass = $true
        }
    } 
    #If there are no printers to add
    elseif ($printerinput -like "skip") {
        write-host "`nMoving onto the next checklist item...`n"
        break;
    } 
    #Invalid Input
    else {
        write-host "Please choose one of the three choices stated above.`n" -ForegroundColor Red
        $pass = $false
    } 

} 

pause

###########################################################################################
#OUTLOOK
###########################################################################################

write-host "`n`n`n`nOpening Outlook...`n"
write-host "Go to File -> Account Settings (the box) -> Account Settings -> Double Click the user's email (i.e. example@example.com) 
-> Offline Settings and then move the slider all the way to the right (All)`n"
write-host "Then go to Folder -> New Folder, and type in 'Employees' EXACTLY THE SAME for the name and select 'Contact Items' for the 'Folder Contains' section.
Then scroll down to find 'Contacts' and place the new folder within the 'Contacts' folder"

Start-Sleep -Seconds 10
if (test-path "C:\Program Files (x86)\Microsoft Office\Office16\OUTLOOK.EXE") {
    & "C:\Program Files (x86)\Microsoft Office\Office16\OUTLOOK.EXE"
} else {
    Start-Sleep -Seconds 2
    write-host "Unable to launch Outlook...please manually open Outlook and complete the steps above."
}

pause

###########################################################################################
#VERIFY OFFICE 365 ACTIVATION
###########################################################################################

write-host "`n`n`n`nMoving to Verify 365 Activation..."
write-host "`nGo to Accounts and verify that the subscription product ssays Microsoft Office 365 ProPlus. `nIf not try updating Office or doing 'gpupdate /force' in cmd."

if (test-path "C:\Program Files (x86)\Microsoft Office\Office16\WINWORD.EXE") {
    & "C:\Program Files (x86)\Microsoft Office\Office16\WINWORD.EXE"
} else {
    Start-Sleep -Seconds 2
    write-host "`nUnable to launch Word...please manually open Word and complete the steps above."
}

pause
###########################################################################################
#SOFTWARE CENTER (AOV & DUO)
###########################################################################################

write-host "`n`n`n`nMoving to Install AOV and DUO Authentication through Software Center"
write-host "`nPlease make sure that DUO has been installed already and install AOV if it has not already been installed."
write-host "`nLaunching Software Center..."
if (test-path "C:\ProgramData\Microsoft\Windows\...") {
    & "C:\ProgramData\Microsoft\Windows\..."
} else {
    Start-Sleep -Seconds 2
    write-host "`nUnable to launch Software Center...please manually open Software Center and complete the steps above."
}

pause
###########################################################################################
#BITLOCKER
###########################################################################################

Write-Host "`n`n`n`nMoving to launch Bitlocker..."
write-host "`nPlease make sure that Bitlocker is enabled. If not, let the encrpytion run."
Start-Sleep -Seconds 4
& "C:\Program Files\Microsoft\MDOP MBAM\MBAMClientUI.exe"
& "C:\Program Files\Microsoft\MDOP MBAM\MBAMControlUI.exe"

pause
###########################################################################################
#THINGS TO DO AFTER
###########################################################################################

write-host "`n`n`n`nOTHER CHECKLIST ITEMS TO DO:" -ForegroundColor Cyan -BackgroundColor Black
write-host "- Remove the old Offline Password from the user's Duo app. Add the new Offline Password (duo.daviscloud.com)"
Write-Host "- Have the user sign the new asset form. Scan the new asset form and remove the old asset form."
write-host "- Connect the computer to an external network (cord at helpdesk) and make that AOV works properly." -ForegroundColor Green -BackgroundColor Black
write-host "- Assign User to PC in IDB and set as active." -ForegroundColor Green  -BackgroundColor Black

pause