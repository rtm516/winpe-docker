# WinPE Docker
A simple docker container used as a base for WinPE image creation

## Usage
```Dockerfile
FROM rtm516/winpe:latest

# Create the WinPE image
RUN copype amd64 C:\WinPE_amd64

# Mount the WinPE image
RUN Dism /Mount-Image /ImageFile:"C:\WinPE_amd64\media\sources\boot.wim" /index:1 /MountDir:"C:\WinPE_amd64\mount"

# Copy your files to the WinPE image
COPY . C:\WinPE_amd64\mount\Windows\System32

# Create the ISO
RUN MakeWinPEMedia /ISO C:\WinPE_amd64 C:\WinPE_amd64\WinPE_amd64.iso
```