# fresh-Windows-installation

# Windows Setup Script

This repository contains a batch script designed to automate the setup and configuration of a Windows environment for development purposes. The script handles the installation of essential tools, libraries, and applications to streamline the configuration process on a new machine or fresh Windows installation.

## Features

- **PowerShell Script Execution Policy**: Unrestricts the PowerShell script execution policy to allow scripts to run.
- **Chocolatey Installation**: Checks for and installs Chocolatey, a package manager for Windows.
- **WinGet and Dependencies**: Installs the Windows package manager 'WinGet' along with its dependencies.
-  **FFmpeg**
- **Visual C++ Redistributables**: Installs all versions of Visual C++ Redistributables from 2005 to 2015+.
- **DirectX and .NET Framework**: Ensures essential components like DirectX and .NET Framework 4.5.1 are installed.
- **Python and Libraries**: Installs Python 3.11 and a wide range of Python libraries from a `requirements.txt` file.
- **NVIDIA CUDA Toolkit and cuDNN**: Sets up the environment for CUDA-based applications by installing Nvidia CUDA Toolkit and cuDNN.
- **Common Applications**: Installs various applications like 7-Zip, Brave Browser, Discord, Steam, and more.
- **Development Tools**: Installs Visual Studio 2022 Community with specific workloads.

## Prerequisites

- A Windows 10/11 machine with administrator access.
- An active internet connection for downloading packages and tools.

## Installation

1. **Download the Script**:
   - Download the `setup_script.bat` from this repository.

2. **Run as Administrator**:
   - Right-click on the `setup_script.bat` file and select "Run as administrator". This is necessary to allow the script to make system-level changes.

3. **Follow the Prompts**:
   - The script will execute several commands and may ask for input during the process. Please read the prompts carefully and respond as necessary.

4. **Reboot**:
   - Once the script completes, reboot your system to ensure all configurations and installations are properly applied.

## Included Software and Libraries

The script installs the following software:

- **Package Managers**: Chocolatey, WinGet
- **Utilities**: 7-Zip, Brave Browser, Discord, Steam, EpicGames Launcher, Ubisoft Connect, LibreOffice, PotPlayer, NordVPN
- **Development Tools**: Microsoft Visual Studio 2022, Python 3.11, various Python libraries, NVIDIA CUDA Toolkit, Microsoft DirectX, .NET Framework
- **Visual C++ Redistributables**: 2005, 2008, 2010, 2012, 2013, 2015+, both x86 and x64 versions.

## Notes

- Ensure your system meets the prerequisites before running the script.
- The script is provided as-is, and users should review and test it in a safe environment before running on a production machine.


## Contributing

Contributions to this script are welcome. Please fork the repository and submit a pull request with your changes or suggestions.
