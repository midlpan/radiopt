#!/usr/bin/bash

uninstall_radiopt() {
        sudo rm -rf /usr/share/radiopt
        sudo rm /usr/bin/radiopt
        echo "Uninstallation completed"
        exit 0
}

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
        echo "Version: 0.1.3"

        read -rp "Continue with the installation[y/n]: " input 

        if [ "$input" == "y" ]; then
                echo "-------------------------------------"
                echo "Moving $PWD/radiopt.sh to /usr/bin/radiopt"
                chmod -w+x radiopt.sh || { 
                        echo "Program not found '$PWD/radiopt.sh'" 
                        exit 1 
        }
                sudo mv "$PWD"/radiopt.sh /usr/bin/radiopt

                echo "Creating directory /usr/share/radiopt"
                sudo mkdir /usr/share/radiopt
                echo "Moving $PWD/logos.sh to /usr/share/radiopt/logos.sh"
                chmod -wx logos.sh || {
                        echo "Library not found '$PWD/logos.sh'"
                        exit 1
                }
                sudo mv "$PWD"/logos.sh /usr/share/radiopt

                echo "Installation completed successfully"
        elif [ "$input" == "n" ]; then
                echo "-------------------------------------"
                echo "Do you want to uninstall the program?"
                echo "This will remove the file:"
                echo "/usr/bin/radiopt"
                echo "and"
                echo "/usr/share/radiopt recursively"
                read -rp "Continue[y/n]:" response
                if [ "$response" == "y" ]; then
                        uninstall_radiopt
                fi

        else
                echo "Exiting..."
                exit 0
        fi
}

install_radiopt
