#!/usr/bin/bash

install_radiopt() {
        echo "Radiopt program installer."
        echo "Radiopt is a CLI program to listen to Portuguese radio stations through the terminal."
        echo ""
        echo "radiopt dependencies:"
        echo ""
        echo "ffmpeg"
        echo ""
        echo "radiopt info:"
        echo ""
        echo "License: GPLv3"
        echo "Creator: midlpan (https://github.com/midlpan)"
        echo "Source:  https://github.com/midlpan/radiopt"
        echo "Version: 0.1.0"

        read -rp "Continue with the installation[y/n]: " input 

        if [ "$input" == "y" ]; then
                echo "Moving $PWD/radiopt.sh to /usr/bin/radiopt"
                sudo mv "$PWD"/radiopt.sh /usr/bin/radiopt
                echo "Installation completed successfully"
        else
                echo "Exiting..."
                exit 
        fi
}

install_radiopt
