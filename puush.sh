#!/bin/bash
USER=$(whoami)
PUUSH_API_KEY="put your api key here"
IMAGENAME="puush"$(date +%F-%T).png


if [ -d "$HOME/images/caps" ]
        then
                echo "Puush directory exists at $HOME/images/caps"
        else
                mkdir -p $HOME/images/caps
                if [ "$?" == "1" ]
                        then
                                echo "Can't create puush folder"
                                exit
                        else
                                echo "Puush directory created at $HOME/images/caps"
                        fi
fi

if [ "$1" == "-s" ]
        then
                scrot -s /tmp/$IMAGENAME -e 'mv $f ~/images/caps'
                FILE=$HOME/images/caps/$IMAGENAME
fi

if [ "$1" == "-f" ]
        then
                if [ -z $2 ]
			then
				echo "No file selected"
				exit
		fi
		FILE=$2
fi
if [ -z $1 ]
        then
                FILE="$HOME/images/caps/$IMAGENAME"
		scrot /tmp/$IMAGENAME -e 'mv $f ~/images/caps'
fi

URL=$(curl -k "https://puush.me/api/up" -# -F "k=$PUUSH_API_KEY" -F "z=poop" -F "f=@$FILE" | cut -f2 -d ',')
echo $URL
echo $URL | xclip -selection c
exit
