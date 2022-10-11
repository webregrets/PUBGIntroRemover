#-------------------------------------#
#   Used to automatically change name of movie-files in PUBG in order to decrease load times.
#
#   By: Webregrets
#
#   ChangeLog:
#   11oct: First draft
#-------------------------------------#
$HardCodedPath = "C:\Program Files (x86)\Steam\steamapps\common\PUBG\TslGame\Content\Movies"

$SteamInstallPath = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Wow6432Node\Valve\Steam" -Name "InstallPath"

if (Test-Path $SteamInstallPath)
{
    Write-Host "Install path for Steam found in registry. Using this to find PUBG"
    
    $IsThisPUBGINTROPATH = "$SteamInstallPath\steamapps\common\PUBG\TslGame\Content\Movies"
    Write-Host "Looking for PUBGs movies folder..."
    if (Test-Path $IsThisPUBGINTROPATH)
    {
        Write-Host "PUBG movies folder found!"
        $PUBGIntroPath = $IsThisPUBGINTROPATH
    }
    else
    {
        Write-Host "PUBG movies folder NOT found! Using hard-coded path..."
        $PUBGIntroPath = $HardCodedPath
    }
}
else
{
    Write-Host "Install path for Steam NOT found in registry. Using hard coded path..."
    $PUBGIntroPath = $HardCodedPath
}

$PUBGIntroItems = Get-ChildItem $PUBGIntroPath

foreach ($i in $PUBGIntroItems)
{
    if ($i -match '\.mp4$')
    {
        Write-Host "$i seems to be a mp4-file. Changing name..."
        Rename-Item -Path "$PUBGIntroPath\$i" "$i.bak"
    }
    else
    {
        Write-Host "$i is not a .mp4 file. Skipping..."
    }
    
}
Write-Host "Done! Exiting script..."