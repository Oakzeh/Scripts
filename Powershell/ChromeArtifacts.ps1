mkdir "C:\Users\$env:UserName\Desktop\Artifacts" -Force
### CHROME ### 
$chrome = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'
#Checking if Chrome is Installed

if($chrome) {
mkdir "C:\Users\$env:UserName\Desktop\Artifacts\Chrome" -Force
#Creating Chrome Sub Folder

$path = "C:\Users\$env:UserName\AppData\Local\Google\Chrome\User Data\"

$Default = @("History", "Visited Links", "Web Data", "Top Sites", "Custom Dictionary.txt","Shortcuts", "Media History"
'Bookmarks', "Preferences", "Login Data", "loginz", "Shortcuts", "Network Action Predictor", "Favicons", "Sessions", "Network/cookies")
#Array of Default folder Artifatcs at the end is specific to default folder
#"Cache" - Can be added for all cache data of each profile 

$profiles = @(Get-ChildItem $path -Filter "Profile*")
$profiles += "Default"
#Adding Default folder to Array for loop
# $profiles = "Default" if just default files are required

foreach($i in $profiles){
  if (Test-Path "$path\$i"){
    mkdir "C:\Users\$env:UserName\Desktop\Artifacts\Chrome\$i" -Force
    if (Test-Path -Path "$path\$i\Network\Cookies"){
      mkdir "C:\Users\$env:UserName\Desktop\Artifacts\Chrome\$i\Network" -Force
    }
    #Creates Sub folder for Individual Profiles
    
    foreach($artifact in $Default){
      try {
        if (test-path -path "$path\$i\$artifact"){
          Copy-Item -path "$path\$i\$artifact" -destination "C:\Users\$env:UserName\Desktop\Artifacts\Chrome\$i\$artifact" -Recurse -Force -ErrorAction Stop
          Write-Output "$i - $artifact Copied Successfully"
          }
      }
      catch {
        Write-Warning -Message $Error[0]
      }
  }
}}

#if (test-path -path "C:\Windows\Prefetch\CHROME.EXE*") {
#Copy-Item -path "C:\Windows\Prefetch\CHROME.EXE*" -Destination "C:\Users\$env:UserName\Desktop\Artifacts\Chrome\Default\" -Recurse -Force
#Write-Output "Chrome Prefetch Copied Successfully"
#Prefetch File for chrome}
#}
}

else {Write-Output "Chrome not installed"}

