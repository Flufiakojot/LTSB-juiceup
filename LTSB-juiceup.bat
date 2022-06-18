@echo off
color 5f
:start
cls
title LTSB-juiceup - main menu
echo.
echo. LTSB-juiceup ver. 1.0.1
echo. Limit telemetry and improve performance on lower-end hardware!
echo. Made by Flufiakojot on GitHub
echo.
echo. !!! MAKE SURE YOU'RE RUNNING THIS WITH ADMINISTRATOR RIGHTS !!!
echo.
echo. Type in "ok" if you want to run the script, "no" if not
echo. Type in "notes" for notes
echo. Type in "tweaks" for optional tweaks
echo.
set /p typein= Type here: 

if %typein% == ok goto continue
if %typein% == no goto bye
if %typein% == notes goto notes
if %typein% == matrix goto matrix
if %typein% == tweaks goto tweaks

goto wrong
:wrong
title LTSB-juiceup - error!
cls
echo.
echo. Did you make a mistake while typing?
echo.
pause
cls
goto start

:bye
cls
title LTSB-juiceup - quitting..
echo.
echo. You did not want to continue, therefore this script will quit.
timeout 3
exit

:matrix
cls
title Shhh! It's a secret!
color 0a
goto start

:notes
cls
title LTSB-juiceup - notes
echo.
echo. Notes..
echo.
echo. This script was made for the 2016 LTSB build of Windows.
echo. It might not do its stuff properly on newer builds, such as 1809 (2019) or 21H2 (2021).
echo.
echo. This script will disable some services and limit the telemetry to improve privacy and gain performance on lower-end hardware!
echo.
echo. There are some services like "OneSyncSvc" with random letters and numbers at their end, I have absolutely no idea how to disable them (because the letters are random each time), so disable them manually.
echo.
echo. You're free to adjust this script to your personal needs! :)
echo.
pause
cls
goto start

:continue 
cls
title LTSB-juiceup - the script is running!
echo. Running!
echo.
echo Uninstalling OneDrive (32-bit)
taskkill /f /im OneDrive.exe
%SystemRoot%\System32\OneDriveSetup.exe /uninstall
echo Uninstalling OneDrive (64-bit)
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
echo Services:
echo Disabling DiagTrack
sc stop DiagTrack
sc config DiagTrack start= disabled
echo Disabling Workstation
sc stop LanmanWorkstation
sc config LanmanWorkstation start= disabled
echo Disabling Delivery Optimization
sc stop DoSvc
sc config DoSvc start= disabled
echo Disabling Server
sc stop LanmanServer
sc config LanmanServer start= disabled
echo Disabling Program Compatibility Assistant Service
sc stop PcaSvc
sc config PcaSvc start= disabled
echo Disabling Distributed Link Tracking Client
sc stop TrkWks
sc config TrkWks start= disabled
echo Disabling Geolocation
sc stop lfsvc
sc config lfsvc start= disabled
echo Disabling dmwappushsvc
sc stop dmwappushsvc
sc config dmwappushsvc start= disabled
echo.
echo. Services have been disabled/set to manual
echo.
echo. Scheduled tasks:
echo.
echo Disabling Microsoft Compatibility Appraiser taskkill (telemetry)
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
echo Disabling ProgramDataUpdater (telemetry)
schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
echo Disabling StartupAppTask (telemetry)
schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
echo Disabling Consolidator (telemetry)
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
echo Disabling KernelCeipTask (telemetry)
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /Disable
echo Disabling UsbCeip (telemetry)
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
echo Disabling Scheduled Diagnosis (telemetry)
schtasks /Change /TN "Microsoft\Windows\Diagnosis\Scheduled" /Disable
echo Disaling Disk Diagnostic Data Collector (telemetry)
schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
echo Disabling Disk Footprint Diagnostics (telemetry)
schtasks /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /Disable
echo Disabling Storage Sense
schtasks /Change /TN "Microsoft\Windows\DiskFootprint\StorageSense" /Disable
echo Disabling dusmtask
schtasks /Change /TN "Microsoft\Windows\DUSM\dusmtask" /Disable
echo Disabling DmClient (telemetry)
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClient" /Disable
echo Disabling DmClientOnScenarioDownload (telemetry)
schtasks /Change /TN "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" /Disable
echo Disabling WinSAT
schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable
echo Disabling BfeOnServiceStartTypeChange
schtasks /Change /TN "Microsoft\Windows\Windows Filtering Platform\BfeOnServiceStartTypeChange" /Disable
echo Disabling Sqm-Tasks (telemetry)
schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable
echo Disabling BackgroundUploadTask
schtasks /Change /TN "Microsoft\Windows\SettingSync\BackgroundUploadTask" /Disable
echo Disabling GatherNetworkInfo (telemetry)
schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable
echo Disabling Device (telemetry)
schtasks /Change /TN "Microsoft\Windows\Device Information\Device" /Disable
echo.
echo. Useless tasks have been disabled
echo.
echo. Registry
echo.
echo Disallowing telemetry
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0
REG ADD "HKCU\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0
echo Disabling Windows Customer Experience Improvement Program
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\SQMClient"
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows"
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0
echo Disabling Cortana
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0
echo Disabling Windows Error Reporting
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1
echo Disabling Steps Recorder
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1
echo Disabling Inventory Collector
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d 1
echo Disabling Handwriting automatic learning
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization"
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrickImplicitTextCollection" /t REG_DWORD /d 1
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1
echo Disabling Advertising ID
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo"
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1
echo Disabling Search Companion
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\SearchCompanion"
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\SearchCompanion" /v "DisableContentFileUpdates" /t REG_DWORD /d 1
echo Disabling Microsoft consumer exeperiences
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1
echo.
echo. Registry done!
echo.
title LTSB-juiceup - done!
echo. Script's done!
echo. It is recommended to restart your computer now.
echo. 
echo. There are also optional tweaks available.
pause
goto done

:done
title LTSB-juiceup - choose!
echo.
echo. Type in "restart" to restart your machine
echo. Type in "exit" to quit the program
echo. Type in "tweaks" to view optional tweaks
echo.
set /p done= Type here: 

if %done% == restart goto restart
if %done% == exit goto exit
if %done% == tweaks goto tweaks

goto wrongthesecond
:wrongthesecond
cls
title LTSB-juiceup - error!
echo.
echo. Did you make a mistake while typing?
echo.
pause
cls
goto done

:restart
cls
title LTSB-juiceup - restarting your machine..
echo. Restarting your machine..
shutdown /r -t 1
exit

:exit
title LTSB-juiceup - quitting
cls
echo. Quiting the program..
exit

:tweaks
cls
title LTSB-juiceup - optional tweaks
echo.
echo. Optional tweaks..
echo.
echo. Type in "1" to increase JPEG quality to 100% for wallpapers
echo. Type in "2" to disable Dnscache service (could cause issues with Microsoft Store or other)
echo. Type in "3" to disable Server service (disabled by default with the script)
echo. Type in "4" to disable Workstation service (disabled by default with the script)
echo. Type in "5" to enable verbose messages
echo.
echo. Type in "6" to remove JPEG quality increase
echo. Type in "7" to enable Dnscache service
echo. Type in "8" to enable Server service
echo. Type in "9" to enable Workstation service
echo. Type in "10" to disable verbose messages
echo.
echo. Type in "start" to get back to the main menu
echo. Type in "restart" to restart your machine
echo. Type in "exit" to quit the program
echo.
set /p optionaltweaks= Type here: 

if %optionaltweaks% == 1 goto 1
if %optionaltweaks% == 2 goto 2
if %optionaltweaks% == 3 goto 3
if %optionaltweaks% == 4 goto 4
if %optionaltweaks% == 5 goto 5
if %optionaltweaks% == 6 goto 6
if %optionaltweaks% == 7 goto 7
if %optionaltweaks% == 8 goto 8
if %optionaltweaks% == 9 goto 9
if %optionaltweaks% == 10 goto 10
if %optionaltweaks% == start goto start
if %optionaltweaks% == restart goto restart
if %optionaltweaks% == exit goto exit

goto wrongthethird
:wrongthethird
cls
title LTSB-juiceup - error!
echo.
echo. Did you make a mistake while typing?
echo.
pause
cls
goto tweaks

:1
cls
title LTSB-juiceup - applying the tweak..
echo.
echo. Settings JPEG quality to 100% for wallpapers..
echo.
REG ADD "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d 64
title LTSB-juice - the tweak has been applied!
echo.
echo. Done!
echo.
timeout 5
goto tweaks

:2
cls
title LTSB-juiceup - applying the tweak..
echo.
echo. Disabling Dnscache service..
echo.
sc stop Dnscache
sc config Dnscache start= disabled
title LTSB-juice - the tweak has been applied!
echo.
echo. Dnscache has been disabled!
echo.
timeout 5
goto tweaks

:3
cls
title LTSB-juiceup - applying the tweak..
echo.
echo. Disabling Server service..
echo.
sc stop LanmanServer
sc config LanmanServer start= disabled
title LTSB-juice - the tweak has been applied!
echo.
echo. Server has been disabled!
echo.
timeout 5
goto tweaks

:4
cls
title LTSB-juiceup - applying the tweak..
echo.
echo. Disabling Workstation service..
echo.
sc stop LanmanWorkstation
sc config LanmanWorkstation
title LTSB-juice - the tweak has been applied!
echo.
echo. Workstation has been disabled!
echo.
timeout 5
goto tweaks

:5
cls
title LTSB-juiceup - applying the tweak..
echo.
echo. Enabling verbose messages..
echo.
title LTSB-juice - the tweak has been applied!
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v "verbosestatus" /t REG_DWORD /d 1
echo.
echo. Verbose messages have been enabled!
echo.
timeout 5
goto tweaks

:6
cls
title LTSB-juiceup - applying the tweak..
echo.
echo. Removing JPEG quality increase..
echo.
REG DELETE "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /f
title LTSB-juice - the tweak has been applied!
echo.
echo. Removed JPEG quality increase!
echo.
timeout 5
goto tweaks

:7
cls
title LTSB-juiceup - applying the tweak..
echo.
echo. Enabling Dnscache service..
echo.
sc config Dnscache start= auto
sc start Dnscache
title "LTSB-juice - the tweak has been applied!"
echo.
echo. Dnscache has been enabled!
echo.
timeout 5
goto tweaks

:8
cls
title LTSB-juiceup - applying the tweak..
echo.
echo. Enabling Server service..
echo.
sc config LanmanServer start= auto
sc start LanmanServer
title "LTSB-juice - the tweak has been applied!"
echo.
echo. Server has been enabled!
echo.
timeout 5
goto tweaks

:9
cls
title LTSB-juiceup - applying the tweak..
echo.
echo. Enabling Workstation service..
echo.
sc config LanmanServer start= auto
sc start LanmanServer
title LTSB-juice - the tweak has been applied!
echo.
echo. Workstation has been enabled!
echo.
timeout 5
goto tweaks

:10
cls
title LTSB-juiceup - applying the tweak..
echo.
echo. Disabling verbose messages..
echo.
REG DELETE HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v "verbosestatus" /f
title LTSB-juice - the tweak has been applied!
echo.
echo. Verbose messages have been disabled!
echo.
timeout 5
goto tweaks