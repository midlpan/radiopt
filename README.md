<p align="center">
  <img src=".github/radiopt.png" alt="Logo do radiopt">
</p>

radiopt is a CLI program to listen to Portuguese web radios through the terminal (you can also save the audio in a .mp3 file)

## Supported radios

* Radio Comercial
* M80
* CidadeFM
* SmoothFM
* batida
* RFM
* Renascença

## Supported in
Linux

## Install
Dependencies:

* ffmpeg

## Script Install
Run the script install.sh

```bash
chmod +x install.sh
./install.sh
```

## Manual Install
Move the radiopt.sh to /usr/bin/radiopt

```bash
chmod -w+x radiopt.sh logos.sh
sudo mv radiopt.sh /usr/bin/radiopt
sudo mkdir /usr/share/radiopt
sudo mv logos.sh /usr/share/radiopt/
```

## How use
To use you can
```bash
radiopt --help
```
For a help message
```bash
radiopt
```
For CLI interface mode
Usage:
```bash
radiopt [OPTION/RADIO]
```
For normal mode
