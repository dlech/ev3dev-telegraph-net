#!/usr/bin/env bash

# send characters to ev3dev-telegraph through MQTT
# requires 'mosquitto_pub', in Ubuntu
# sudo apt-get install mosquitto-clients
#
# for debugging you can also listen with 
# mosquitto_sub -h $BROKER -t $TOPIC

BROKER="test.mosquitto.org"
MAINTOPIC="ev3dev-telegraph-net/"

if [ $# -eq 0 ]
  then
    echo "Usage: send2telegraph PERSON"
    exit 1
fi

#YOU=The person you want to talk to, like JorgePe
YOU=$1

TOPIC=$MAINTOPIC$YOU

echo
echo "send2telegraph 1.0 - Jan2017"
echo "========================================================="
echo "Converts a message to the coding used by David Lechner in"
echo "      https://github.com/dlech/ev3dev-telegraph-net"
echo "(only alphabet, SPACE and ENTER keys are sent)"
echo "========================================================="
echo "Broker:"$BROKER
echo "Topic: "$TOPIC
echo "========================================================="
echo

# data file
INPUT="/dev/stdin"

# telegraph codes
A="\x00"
B="\x01"
C="\x02"
D="\x03"
E="\x04"
F="\x05"
G="\x06"
H="\x07"
I="\x08"
J="\x09"
K="\x0A"
L="\x0B"
M="\x0C"
N="\x0D"
O="\x0E"
P="\x0F"
Q="\x10"
R="\x11"
S="\x12"
T="\x13"
U="\x14"
V="\x15"
W="\x16"
X="\x17"
Y="\x18"
Z="\x19"
SPC="\x1A"
RET="\x1B"


# function to send character through MQTT
function send {
    # -n do not output the trailing newline
    # -e enable interpretation of backslash escapes
    echo -ne $1 | mosquitto_pub -h $BROKER -t $TOPIC -s
}

# while loop
while IFS= read -r -n1 char
do
    # display one character at a time
#    echo  "$char"

    # identify and send
    case "$char" in
        "A"|"a")
            send $A
            ;;
        "B"|"b")
            send $B
            ;;
        "C"|"c")
            send $C
            ;;
        "D"|"d")
            send $D
            ;;
        "E"|"e")
            send $E
            ;;
        "F"|"f")
            send $F
            ;;
        "G"|"g")
            send $G
            ;;
        "H"|"h")
            send $H
            ;;
        "I"|"i")
            send $I
            ;;
        "J"|"j")
            send $J
            ;;
        "K"|"k")
            send $K
            ;;
        "L"|"l")
            send $L
            ;;
        "M"|"m")
            send $M
            ;;
        "N"|"n")
            send $N
            ;;
        "O"|"o")
            send $O
            ;;
        "P"|"p")
            send $P
            ;;
        "Q"|"q")
            send $Q
            ;;
        "R"|"r")
            send $R
            ;;
        "S"|"s")
            send $S
            ;;
        "T"|"t")
            send $T
            ;;
        "U"|"u")
            send $U
            ;;
        "V"|"v")
            send $V
            ;;
        "W"|"w")
            send $W
            ;;
        "X"|"x")
            send $X
            ;;
        "Y"|"y")
            send $Y
            ;;
        "Z"|"z")
            send $Z
            ;;
        " ")
            send $SPC
            ;;
        "\n"|"\r"|"$EOF")
            send $RET
            ;;
        *)
            echo $char is unknown
            ;;
    esac
done < "$INPUT"
