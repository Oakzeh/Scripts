### CHROME ### 
$chrome = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'
#Checking if Chrome is Installed
mkdir "C:\Users\$env:UserName\Desktop\Artifacts" -Force
if($chrome) {
mkdir "C:\Users\$env:UserName\Desktop\Artifacts\Chrome" -Force
#Creating Chrome Sub Folder

$path = "C:\Users\$env:UserName\AppData\Local\Google\Chrome\User Data\"
$profiles = @()
#defining variables

$Default = @("History", "Visited Links", "Web Data", "Top Sites", "Custom Dictionary.txt","Shortcuts", 
'Bookmarks', "Preferences", "Login Data", "Media History", "Shortcuts", "Network Action Predictor", "Favicons")
#Array of Default folder Artifatcs

$profiles = @(Get-ChildItem $path -Filter "Profile*")
foreach($i in $profiles){
  if (Test-Path "$path\$i"){
    mkdir "C:\Users\$env:UserName\Desktop\Artifacts\Chrome\$i" -Force
    #Creates Sub folder for Individual Profiles
    
    foreach($artifact in $Default){
    
    if (test-path -path "$path\$i\$artifact"){
    
    Copy-Item -path "$path\Default\$artifact" -destination "C:\Users\$env:UserName\Desktop\Artifacts\Chrome\$i\$artifact-$i"
    Write-Output "$i - $artifact Copied Successfully"
    }}
}}

mkdir "C:\Users\$env:UserName\Desktop\Artifacts\Chrome\Default" -Force
#Creating folder for Default

#Copies Cookies
if (Test-Path "$path\Default\Network\cookies") {
Copy-Item -path "$path\Default\Network\cookies" -destination "C:\Users\$env:UserName\Desktop\Artifacts\Chrome\Default\cookies" #-Force
Write-Output "Nom Nom Nom... Cookies Copied Successfully" }

#Copies Custom Dictionary
if (Test-Path "$path\Default\Custom Dictionary.txt") {
Copy-Item -path "$path\Default\Custom Dictionary.txt" -destination "C:\Users\$env:UserName\Desktop\Artifacts\Chrome\Default\Custom Dictionary.txt" #-Force
Write-Output "Custom Dictionary Copied Successfully"

foreach($artifact in $Default){
if (test-path -path "$path\Default\$artifact"){
Copy-Item -path "$path\Default\$artifact" -destination "C:\Users\$env:UserName\Desktop\Artifacts\Chrome\Default\"
Write-Output "$artifact Copied Successfully"
}}

if (test-path -path "$path\Default\Cache\Cache_Data") {
Copy-Item -path "$path\Default\Cache\Cache_Data" -Destination "C:\Users\$env:UserName\Desktop\Artifacts\Chrome\Default\" -Recurse -Force
Write-Output "Cache Files Copied Successfully"
}

#if (test-path -path "C:\Windows\Prefetch\CHROME.EXE*") {
#Copy-Item -path "C:\Windows\Prefetch\CHROME.EXE*" -Destination "C:\Users\$env:UserName\Desktop\Artifacts\Chrome\Default\" -Recurse -Force
#Write-Output "Chrome Prefetch Copied Successfully"
#Prefetch File for chrome }
}
}

else {Write-Output "Chrome not installed"}

