#!/bin/bash

FILENAME=$1

TLSAUTHKEY=`cat $FILENAME | grep "^tls-auth " | awk '{print $2}'`
CA=`cat $FILENAME | grep "^ca " | awk '{print $2}'`
KEY=`cat $FILENAME | grep "^key " | awk '{print $2}'`
CERT=`cat $FILENAME | grep "^cert " | awk '{print $2}'`

echo $TLSAUTHKEY
echo $CA
echo $KEY
echo $CERT
echo

NEWCONF=`cat $FILENAME`
NEWCONF=${NEWCONF/$TLSAUTHKEY/<tls-auth>}
NEWCONF=${NEWCONF/$CA/<ca>}
NEWCONF=${NEWCONF/$KEY/<key>}
NEWCONF=${NEWCONF/$CERT/<cert>}


echo -en "$NEWCONF"

echo -en "$NEWCONF" > $FILENAME.ovpn
echo -en "\n<ca>\n" >> $FILENAME.ovpn
cat $CA >> $FILENAME.ovpn
echo -en "\n</ca>\n" >> $FILENAME.ovpn
echo -en "\n<tls-auth>\n" >> $FILENAME.ovpn
cat $TLSAUTHKEY >> $FILENAME.ovpn
echo -en "\n</tls-auth>\n" >> $FILENAME.ovpn
echo -en "\n<key>\n" >> $FILENAME.ovpn
cat $KEY >> $FILENAME.ovpn
echo -en "\n</key>\n" >> $FILENAME.ovpn
echo -en "\n<cert>\n" >> $FILENAME.ovpn
cat $CERT >> $FILENAME.ovpn
echo -en "\n</cert>\n" >> $FILENAME.ovpn
