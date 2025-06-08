# Radiopt
radiopt is a CLI program to listen to Portuguese web radios through the terminal (you can also save the audio in a .mp3 file)

## Supported radios

* Radio Comercial
* M80
* CidadeFM
* SmoothFM
* batida

## Supported in
Linux

## Install
Dependencies:

* ffmpeg

## Scrip Install
Run the script install.sh

```bash
chmod +x install.sh
./install.sh
```

## Manual Install
Move the radiopt.sh to /usr/bin/radiopt

```bash
chmod +x radiopt.sh
sudo mv radiopt.sh /usr/bin/radiopt
```

## How use
To use it, you always need some argument
```bash
radiopt --help
```
Usage:
```bash
radiopt [OPTION/RADIO]
```
