### FIREFOX ### 
$edge = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe'
#Checking if Firefox is Installed

if($edge){
    mkdir "C:\Users\$env:UserName\Desktop\Artifacts\Edge" -Force
    #Creating Edge Sub Folder
    
    $edgepath = "C:\Users\$env:UserName\AppData\Local\Microsoft\Edge\User Data\"
    
    $edgeArtifacts = @("History", "Login Data", "favicons", "Network\Cookies", "Preferences", "Bookmarks", "Web Data", "Network Action Predictor", "Top Sites", 
    'pdf', "Sessions", "Visited Links")
    #Array of Default folder Artifatcs
    #"Cache" - Can be added for all cache data of each profile 
    
    $eprofiles = @(Get-ChildItem $edgepath -Filter "Profile *") 
    $eprofiles += "Default"

    foreach ($profile in $eprofiles) {
        if (Test-Path -path "$edgepath$profile") {
            mkdir "C:\Users\$env:UserName\Desktop\Artifacts\Edge\$profile" -Force
        }

        #Making Profile Folder
        foreach($art in $edgeArtifacts) {
            try {
                if (test-path "$edgepath$profile\$art") {
                    Copy-Item -Path "$edgepath$profile\$art" -Destination "C:\Users\$env:UserName\Desktop\Artifacts\Edge\$profile\" -Recurse -Force
                    Write-Host "$profile - $art Copied Successfully"
                }         
            }
            catch {
                Write-Warning -Message $Error[0]
            }

    #nested for loop checking if artifact path is valid then copying to specified folder
        }
    }
    
    }
    else {Write-Output "Edge not installed"}
    