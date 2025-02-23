@echo off
chcp 1252 >nul
:: Richiede l'esecuzione come amministratore
echo Sblocco completo dell'esecuzione degli script PowerShell...

:: Sbloccare completamente l'esecuzione degli script PowerShell
powershell -command "Set-ExecutionPolicy Unrestricted -Scope LocalMachine -Force"
echo Esecuzione degli script PowerShell sbloccata senza restrizioni.


@echo off
REM Controlla se Chocolatey è già installato
powershell -Command "Get-Command choco -ErrorAction SilentlyContinue" >nul 2>&1

IF %ERRORLEVEL% EQU 0 (
    echo Chocolatey è già installato.
) ELSE (
    echo Installazione di Chocolatey...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))"

    IF %ERRORLEVEL% EQU 0 (
        echo Chocolatey installato con successo.
    ) ELSE (
        echo Errore nell'installazione di Chocolatey.
    )
)

@echo off
echo Inizio installazione di WinGet...

:: URLs dei file da scaricare
set "winget_url=https://aka.ms/getwinget"
set "vclibs_url=https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx"
set "xaml_url=https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx"

:: Nomi dei file
set "winget_file=Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
set "vclibs_file=Microsoft.VCLibs.x64.14.00.Desktop.appx"
set "xaml_file=Microsoft.UI.Xaml.2.7.x64.appx"

:: Scarica i file
powershell -Command "Start-BitsTransfer -Source '%winget_url%' -Destination '%winget_file%'"
echo Scaricato %winget_file%

powershell -Command "Start-BitsTransfer -Source '%vclibs_url%' -Destination '%vclibs_file%'"
echo Scaricato %vclibs_file%

powershell -Command "Start-BitsTransfer -Source '%xaml_url%' -Destination '%xaml_file%'"
echo Scaricato %xaml_file%

:: Controlla se una versione più recente di Microsoft.VCLibs è già installata
powershell -Command "Get-AppxPackage -Name Microsoft.VCLibs.140.00.UWPDesktop | Out-Null"
if %errorlevel%==0 (
    echo Microsoft.VCLibs.x64.14.00.Desktop è già installato. Skip installazione.
) else (
    powershell -Command "Add-AppxPackage %vclibs_file%"
    echo Installato %vclibs_file%
)

:: Installa gli altri pacchetti
powershell -Command "Add-AppxPackage %xaml_file%"
echo Installato %xaml_file%

powershell -Command "Add-AppxPackage %winget_file%"
echo Installato %winget_file%

:: Rimuove i file scaricati
powershell -Command "Remove-Item %winget_file%"
echo Rimosso %winget_file%

powershell -Command "Remove-Item %vclibs_file%"
echo Rimosso %vclibs_file%

powershell -Command "Remove-Item %xaml_file%"
echo Rimosso %xaml_file%

:: Verifica se %UserProfile%\AppData\Local\Microsoft\WindowsApps è nel PATH
echo Verifica del PATH...

set "windows_apps_path=%UserProfile%\AppData\Local\Microsoft\WindowsApps"
set "path_found=false"

for %%P in ("%PATH:;=" "%") do (
    if /I "%%~P"=="%windows_apps_path%" (
        set "path_found=true"
    )
)

if "%path_found%"=="false" (
    echo %windows_apps_path% non presente nel PATH. Aggiunta in corso...
    setx PATH "%PATH%;%windows_apps_path%"
    echo Percorso aggiunto al PATH.
) else (
    echo %windows_apps_path% è già presente nel PATH.
)

:: Controlla se WinGet è installato
powershell -Command "Get-Command winget | Out-Null"
if %errorlevel%==0 (
    :: Aggiorna le sorgenti di winget
    powershell -Command "winget source update"
    echo Aggiornate le sorgenti di winget
) else (
    echo WinGet non è stato installato correttamente o non è nel PATH.
)

echo Installazione completata!


echo Aggiornamento Di Tutte Le App Disponibili In Winget...
winget upgrade --all --include-unknown --accept-package-agreements --accept-source-agreements


@echo off

:: Installazione di tutte le librerie Visual C++ Redistributable
echo Installazione di tutte le versioni delle librerie Visual C++ Redistributable...
winget install Microsoft.VCRedist.2015+.x86 -e --accept-source-agreements
winget install Microsoft.VCRedist.2015+.x64 -e --accept-source-agreements
winget install Microsoft.VCRedist.2013.x86 -e --accept-source-agreements
winget install Microsoft.VCRedist.2013.x64 -e --accept-source-agreements
winget install Microsoft.VCRedist.2012.x86 -e --accept-source-agreements
winget install Microsoft.VCRedist.2012.x64 -e --accept-source-agreements
winget install Microsoft.VCRedist.2010.x86 -e --accept-source-agreements
winget install Microsoft.VCRedist.2010.x64 -e --accept-source-agreements
winget install Microsoft.VCRedist.2008.x86 -e --accept-source-agreements
winget install Microsoft.VCRedist.2008.x64 -e --accept-source-agreements
winget install Microsoft.VCRedist.2005.x86 -e --accept-source-agreements
winget install Microsoft.VCRedist.2005.x64 -e --accept-source-agreements

:: Installazione di DirectX
echo Installazione di DirectX...
winget install Microsoft.DirectX -e --accept-source-agreements

:: Installazione di .NET Framework
echo Installazione del .NET Framework 4.5.1...
winget install Microsoft.DotNet.Framework.DeveloperPack_4 -e --accept-source-agreements

echo Installazione di Python 3.11...
winget install Python.Python.3.11 -e --accept-source-agreements

echo Creazione del file requirements.txt per librerie Python...
echo dnspython > requirements.txt
echo deep-translator >> requirements.txt
echo auto-py-to-exe >> requirements.txt
echo pyperclip >> requirements.txt
echo googletrans >> requirements.txt
echo pyautogui >> requirements.txt
echo wmi >> requirements.txt
echo mss >> requirements.txt
echo numpy >> requirements.txt
echo pywin32 >> requirements.txt
echo pyyaml >> requirements.txt
echo requests >> requirements.txt
echo ipython >> requirements.txt
echo psutil >> requirements.txt
echo gitpython >> requirements.txt
echo opencv-python >> requirements.txt
echo scipy >> requirements.txt
echo thop >> requirements.txt
echo tqdm >> requirements.txt
echo tensorboard >> requirements.txt
echo keyboard >> requirements.txt
echo pandas >> requirements.txt
echo translate >> requirements.txt
echo pytube >> requirements.txt
echo openai >> requirements.txt
echo rich >> requirements.txt
echo pygame >> requirements.txt
echo pyserial >> requirements.txt
echo colorama >> requirements.txt
echo onnxruntime-directml >> requirements.txt
echo pefile >> requirements.txt
echo matplotlib >> requirements.txt
echo seaborn >> requirements.txt
echo gradio >> requirements.txt
echo ultralytics >> requirements.txt
echo Pillow >> requirements.txt
echo subliminal >> requirements.txt
echo babelfish >> requirements.txt
echo yt-dlp >> requirements.txt
echo python-vlc >> requirements.txt
echo tk >> requirements.txt
echo pycaw >> requirements.txt
echo comtypes >> requirements.txt

echo Installazione delle librerie Python da requirements.txt...
python -m pip install --upgrade pip
python -m pip install -r requirements.txt

:: Installazione di Nvidia Cuda Toolkit
echo Installazione di Nvidia Cuda Toolkit..
winget install --id Nvidia.CUDA --force -e --accept-source-agreements

echo Installing NVIDIA cuDNN for CUDA 12...
python -m pip install nvidia-cudnn-cu12

echo Uninstalling torch, torchvision, and torchaudio...
python -m pip uninstall torch torchvision torchaudio -y

echo Reinstalling torch, torchvision, and torchaudio with CUDA 12.6 support...
python -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126


echo Installazione di 7-Zip...
winget install 7zip.7zip -e --accept-source-agreements

echo Installazione di Brave Browser...
winget install Brave.Brave -e --accept-source-agreements

echo Installazione di Discord...
winget install Discord.Discord -e --accept-source-agreements

echo Installazione di Steam...
winget install Valve.Steam -e --accept-source-agreements

echo Installazione di EpicGames...
winget install EpicGames.EpicGamesLauncher -e --accept-source-agreements

echo Installazione di Ubisoft...
winget install Ubisoft.Connect -e --accept-source-agreements

echo Installazione di LibreOffice...
winget install TheDocumentFoundation.LibreOffice -e --accept-source-agreements

echo Installazione di PotPlayer...
winget install Daum.PotPlayer -e --accept-source-agreements

echo Installazione di NordVPN...
winget install NordSecurity.NordVPN -e --accept-source-agreements

echo Installazione di Microsoft VisualStudio 2022 Community...
winget install --id Microsoft.VisualStudio.2022.Community  --override "--passive --add Microsoft.VisualStudio.Workload.ManagedDesktop --add Microsoft.VisualStudio.Workload.NativeDesktop --includeRecommended"


:: Operazione completata
echo Installazione completata!
    