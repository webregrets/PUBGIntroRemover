#-------------------------------------#
#   Used to automatically change name of movie-files in PUBG in order to decrease load times.
#
#   By: Webregrets
#
#   ChangeLog:
#   11oct22: First draft
#   22Apr23: Adding part to remove old .bak files before changing mp4-files

#-------------------------------------#

#region try to get installdir
$HardCodedPath = "C:\Program Files (x86)\Steam\steamapps\common\PUBG\TslGame\Content\Movies"

try 
{
    $PUBGInstallPath = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 578080" -Name "InstallLocation"
    Write-Host "PUBG Install location found using registry... Moving along..."
    
    if (Test-Path $PUBGInstallPath)
    {  
        $IsThisPUBGINTROPATH = "$PUBGInstallPath\TslGame\Content\Movies"
        Write-Host "Looking for PUBGs movies folder..."
        if (Test-Path $IsThisPUBGINTROPATH)
        {
            Write-Host "PUBG movies folder found!"
            $PUBGIntroPath = $IsThisPUBGINTROPATH
        }
        else
        {
            Write-Host "PUBG movies folder NOT found! Something went all fucky..."
        }
    }
else
{
    Write-Host "Install path for Steam NOT found in registry. Using hard coded path..."
    $PUBGIntroPath = $HardCodedPath
}

$PUBGIntroItems = Get-ChildItem $PUBGIntroPath
}
catch 
{
    Write-Host $_
}

#endregion

#region first pass (removing .bak)
foreach ($i in $PUBGIntroItems)
{
    if ($i -match '\.bak$')
    {
        Write-Host "Found old .bak-file probably because you've used this tool before. Removing..." -ForegroundColor Yellow
        Remove-Item "$PUBGIntroPath\$i" -Force
        Write-Host "$i removed!"
    }
}
Write-Host "All .bak files are removed. Moving on!"
#endregion

#region Second pass (Changing .mp4 to .mp4.bak)
foreach ($i in $PUBGIntroItems)
{
 
    if ($i -match '\.mp4$')
    {
        Write-Host "$i seems to be a mp4-file. Changing name..." -ForegroundColor Green
        Rename-Item -Path "$PUBGIntroPath\$i" "$i.bak" -Force
    }
    else
    {
        Write-Host "$i is not a .mp4 file. Skipping..."
    }   
}
#endregion

Write-Host "Done! Exiting script..."