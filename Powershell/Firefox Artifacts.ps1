﻿### FIREFOX ### 
$firefox = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe'
#Checking if Firefox is Installed

$location = Get-Location

if($firefox){
mkdir "$location\Artifacts\Firefox" -Force
#Creating Firefox Sub Folder

$ffpath = "C:\Users\$env:UserName\AppData\Roaming\Mozilla\Firefox\Profiles\"

$ffArtifacts = @("places.sqlite", "cookies.sqlite", "favicons.sqlite", "formhistory.sqlite", "key4.db", "logins.json", "persdict.dat", "xulstore.json", "prefs.js",
'storage.sqlite', "webappsstore.sqlite", "protections.sqlite", "content-prefs.sqlite", "permissions.sqlite", "bookmarkbackups", "cert9.db", "sessionstore.jsonlz4", "storage\default")
#Array of Default folder Artifatcs


$ffprofiles = @(Get-ChildItem $ffpath) 

foreach ($profile in $ffprofiles) {
    mkdir "$location\Artifacts\Firefox\$profile" -Force

    Write-Host $ffpath$profile
    foreach($art in $ffArtifacts) {
        if (test-path "$ffpath$profile\$art") {
            Copy-Item -Path "$ffpath$profile\$art" -Destination "$location\Artifacts\Firefox\$profile\" -Recurse -Force
            Write-Host "$profile $art Copied Successfully"
        }
#nested for loop checking if artifact path is valid then copying to specified folder
    }
}
}
else {Write-Output "Firefox not installed"}


