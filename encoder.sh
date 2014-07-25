#!/bin/bash
function daemon {

while true; do

if [ -f /tmp/readytoprocess ]; then
echo "Grabbing subs track number"
TRACK=$(mkvinfo "`cat /tmp/readytoprocess`"  | grep "Track type: subtitles" -b3 | grep "Track number" | cut -f2 -d '(' | sed 's/[^0-9]//g')
TEMP=`cat /tmp/readytoprocess`
FILE=$(echo "'$TEMP'" | xargs basename)
echo "File to transcode is $FILE"
echo "Track number $TRACK for subs"
echo "Grabbing subs file"
mkvextract tracks "`cat /tmp/readytoprocess`" $TRACK:"/tmp/$FILE-temp.srt"
echo "Hardcoding subs"
mencoder "`cat /tmp/readytoprocess`" -sub "/tmp/$FILE-temp.srt" -o "/tmp/burned-in-subbed-video.mp4" -subfont 'Liberation Serif' -oac pcm -ovc lavc -lavcopts vbitrate=3000
rm /tmp/readytoprocess
rm /tmp/$FILE-tmp.srt
fi

sleep 1s

done

}

daemon >/tmp/temp.file 2>&1 &
disown
