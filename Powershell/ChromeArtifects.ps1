#param ([Int]$hello)

$drive = get-psdrive -psprovider filesystem

foreach($d in $drive) {
   Write-Host "hello there $d.name"
   }
#for loop finding drive types 

### CHROME ### 
$chrome = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'
#Checking if Chrome is Installed


mkdir "C:\Users\$env:UserName\Desktop\Artifects" -Force

if($chrome) {
mkdir "C:\Users\$env:UserName\Desktop\Artifects\Chrome" -Force
#Creating Chrome Sub Folder

$path = "C:\Users\$env:UserName\AppData\Local\Google\Chrome\User Data\"
$profiles = 1
$v = Test-Path "$path\Profile $profiles"
#defining variables

for($i=1; $i -le 50; $i++) {
    #Write-Output $i
    $v = Test-Path "$path\Profile $i"
    $profiles++

      if (!$v) {
    break
    }
}
#Testing and finding chrome user profile paths 



for($i=1; $i -le $profiles; $i++){

if (Test-Path "$path\Profile $i"){mkdir "C:\Users\$env:UserName\Desktop\Artifects\Chrome\Profile $i" -Force}
#Creates Sub folder for Individual Profiles

if (Test-Path "$path\Profile $i") {
#Copies History Artifact
Copy-Item -path "$path\Profile $i\history" -Destination "C:\Users\$env:UserName\Desktop\Artifects\Chrome\Profile $i\history $i" #-Force
Write-Output "Profile $i History Artifect Copied Successfully"

#Copies Visited Links Artifact
Copy-Item -path "$path\Profile $i\Visited Links" -Destination "C:\Users\$env:UserName\Desktop\Artifects\Chrome\Profile $i\Visited Links $i" #-Force
Write-Output "Profile $i Visited Links Artifect Copied Successfully"

#Copies Web Data Artifact
Copy-Item -path "$path\Profile $i\Web Data" -Destination "C:\Users\$env:UserName\Desktop\Artifects\Chrome\Profile $i\Web Data $i" #-Force
Write-Output "Profile $i Web Data Artifect Copied Successfully"

#Copies Top Sites Artifact
Copy-Item -path "$path\Profile $i\Top Sites" -Destination "C:\Users\$env:UserName\Desktop\Artifects\Chrome\Profile $i\Top Sites $i" #-Force
Write-Output "Profile $i Top Sites Artifect Copied Successfully"

#Copies Shrortcuts Artifact
Copy-Item -path "$path\Profile $i\Shortcuts" -Destination "C:\Users\$env:UserName\Desktop\Artifects\Chrome\Profile $i\Shortcuts $i" #-Force
Write-Output "Profile $i Shortcuts Artifect Copied Successfully"

if (Test-Path "$path\Profile $i\Bookmarks"){
#Copies Bookmarks CSV Artifact (Default)
Copy-Item -path "$path\Profile $i\Bookmarks" -Destination "C:\Users\$env:UserName\Desktop\Artifects\Chrome\Profile $i\Bookmarks $i" #-Force
Write-Output "Profile $i Bookmarks Artifect Copied Successfully"}

#Copies Preferences Artifact
Copy-Item -path "$path\Profile $i\Preferences" -Destination "C:\Users\$env:UserName\Desktop\Artifects\Chrome\Profile $i\Preferences $i" #-Force
Write-Output "Profile $i Preferences Artifect Copied Successfully"
}

mkdir "C:\Users\$env:UserName\Desktop\Artifects\Chrome\Default" -Force
#Creating folder for Default

}
#Copies Cookies
if (Test-Path "$path\Default\Network\cookies") {
Copy-Item -path "$path\Default\Network\cookies" -destination "C:\Users\$env:UserName\Desktop\Artifects\Chrome\Default\cookies" #-Force
Write-Output "Nom Nom Nom... Cookies Copied Successfully" }

#Copies Custom Dictionary
if (Test-Path "$path\Default\Custom Dictionary.txt") {
Copy-Item -path "$path\Default\Custom Dictionary.txt" -destination "C:\Users\$env:UserName\Desktop\Artifects\Chrome\Default\Custom Dictionary.txt" #-Force
Write-Output "Custom Dictionary Copied Successfully"

$Default = @("History", "Visited Links", "Web Data", "Top Sites", "Custom Dictionary.txt","Shortcuts", 'Bookmarks', "Preferences", "Login Data", "Media History")
#Array of Default folder Artifatcs

foreach($artifact in $Default){
Copy-Item -path "$path\Default\$artifact" -destination "C:\Users\$env:UserName\Desktop\Artifects\Chrome\Default\"
Write-Output "$artifact Copied Successfully"
}

}
}


else {
Write-Output "Chrome not installed"
}

