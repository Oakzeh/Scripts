### FIREFOX ### 
$firefox = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\firefox.exe'
#Checking if Firefox is Installed

if($firefox){
mkdir "C:\Users\$env:UserName\Desktop\Artifacts\Firefox" -Force
#Creating Firefox Sub Folder

$ffpath = "C:\Users\$env:UserName\AppData\Roaming\Mozilla\Firefox\Profiles\"

$ffArtifacts = @("places.sqlite", "cookies.sqlite", "favicons.sqlite", "formhistory.sqlite", 
'storage.sqlite', "webappsstore.sqlite", "protections.sqlite", "content-prefs.sqlite", "permissions.sqlite")
#Array of Default folder Artifatcs


$ffprofiles = @(Get-ChildItem $ffpath) 

foreach ($profile in $ffprofiles) {
    mkdir "C:\Users\$env:UserName\Desktop\Artifacts\Firefox\$profile" -Force

    Write-Host $ffpath$profile
    foreach($art in $ffArtifacts) {
        if (test-path "$ffpath$profile\$art") {
            Copy-Item -Path "$ffpath$profile\$art" -Destination "C:\Users\$env:UserName\Desktop\Artifacts\Firefox\$profile\" -Force
            Write-Host "$profile $art Copied Successfully!"
        }
#nested for loop checking if artifact path is valid then copying to specified folder
    }
}
}
else {Write-Output "Firefox not installed"}


