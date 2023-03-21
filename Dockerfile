FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Create a working directory
RUN mkdir \Temp

# ADK for Windows 11, version 22H2
ADD https://download.microsoft.com/download/6/7/4/674ec7db-7c89-4f2b-8363-689055c2b430/adk/adksetup.exe /Temp/adksetup.exe
RUN C:\Temp\adksetup.exe /quiet /norestart /ceip off /l /Temp/adksetup.log /features OptionId.DeploymentTools

# ADK WinPE Addons for Windows 11, version 22H2
ADD https://download.microsoft.com/download/5/2/5/525dcde0-c7b8-487a-894d-0952775a78c7/adkwinpeaddons/adkwinpesetup.exe /Temp/adkwinpesetup.exe
RUN C:\Temp\adkwinpesetup.exe /quiet /norestart /ceip off /l /Temp/adkwinpesetup.log /features OptionId.WindowsPreinstallationEnvironment

# Cleanup installation files
RUN del /q /f /s C:\Temp

# Copy over the environment variables for the ADK
RUN "C:\Program^ Files^ ^(x86^)\Windows^ Kits\10\Assessment^ and^ Deployment^ Kit\Deployment^ Tools\DandISetEnv.bat && cmd /c reg add ^"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment^" /t REG_EXPAND_SZ /v Path /d ^"%PATH%;%NewPath%^" /f"

CMD [ "powershell" ]