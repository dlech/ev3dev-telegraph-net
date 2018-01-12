#!/usr/bin/env bash

BROKER="test.mosquitto.org"
#BROKER="localhost"

MAINTOPIC="ev3dev-telegraph-net/"

if [ $# -eq 0 ]
  then
    echo "Usage: recv-telegraph PERSON"
    exit 1
fi

#ME=Your name/handle
ME=$1

TOPIC=$MAINTOPIC$ME


echo
echo "recv-telegraph 1.0 - Jan2018"
echo "========================================================="
echo "Receives a message in the coding used by David Lechner in"
echo "      https://github.com/dlech/ev3dev-telegraph-net"
echo "========================================================="
echo "Broker:"$BROKER
echo "Topic: "$TOPIC
echo "========================================================="
echo

# read one char with NUL as separator but don't remove the NUL
while IFS= read -rn1 -d $'\0' code
do
     case $code in
        $'\u0000' )
            echo -n "A"
        ;;
        $'\u0001' )
            echo -n "B"
        ;;
        $'\u0002' )
            echo -n "C"
        ;;
        $'\u0003' )
            echo -n "D"
        ;;
        $'\u0004' )
            echo -n "E"
        ;;
        $'\u0005' )
            echo -n "F"
        ;;
        $'\u0006' )
            echo -n "G"
        ;;
        $'\u0007' )
            echo -n "H"
        ;;
        $'\u0008' )
            echo -n "I"
        ;;
        $'\u0009' )
            echo -n "J"
        ;;
        $'\u000A' )
            echo -n "K"
        ;;
        $'\u000B' )
            echo -n "L"
        ;;
        $'\u000C' )
            echo -n "M"
        ;;
        $'\u000D' )
            echo -n "N"
        ;;
        $'\u000E' )
            echo -n "O"
        ;;
        $'\u000F' )
            echo -n "P"
        ;;
        $'\u0010' )
            echo -n "Q"
        ;;
        $'\u0011' )
            echo -n "R"
        ;;
        $'\u0012' )
            echo -n "S"
        ;;
        $'\u0013' )
            echo -n "T"
        ;;
        $'\u0014' )
            echo -n "U"
        ;;
        $'\u0015' )
            echo -n "V"
        ;;
        $'\u0016' )
            echo -n "W"
        ;;
        $'\u0017' )
            echo -n "X"
        ;;
        $'\u0018' )
            echo -n "Y"
        ;;
        $'\u0019' )
            echo -n "Z"
        ;;
        $'\u001A' )
            echo -n " "
        ;;
        $'\u001B' )
            echo ""
        ;;
        *)
            echo -n "?"
        ;;
    esac
done < <( tail -n 1 | mosquitto_sub -h $BROKER -t $TOPIC -N )

# -N supresses EOL when printing payload ('\n')
