#!/bin/bash
RAMBLE_SMTP_TO='default_recipient@mailserver.test'
BODY='This is a test body'
SUBJECT='Notication from Ramble: This is a test'

while [ $# -gt 0 ]
do
    case "$1" in
        -t) RAMBLE_SMTP_TO="$2"; shift;;
        -b) BODY="$2"; shift;;
        -s) SUBJECT="$2"; shift;;
        -*)
            echo >&2 "usage: $0 [-v] [file ...]"
            exit 1;;
        *)  break;;     # terminate while loop
    esac
    shift
done

swaks -t "$RAMBLE_SMTP_TO" -s smtp.gmail.com:587 -tls -a LOGIN --header "Subject: $SUBJECT" --body "$BODY" --auth-user "$RAMBLE_SMTP_USER" --auth-password "$RAMBLE_SMTP_PW" -S > /dev/null 2>&1
