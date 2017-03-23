#!/bin/bash
RAMBLE_SMTP_TO='default_recipient@mailserver.test'
RAMBLE_ALT_SMTP_TO='service_desk_ticket_creator@mailserver.test'
BODY='This is a test body'
SUBJECT='Notication from Ramble: This is a test'
MESSAGE_LEVEL='INFO'

while [ $# -gt 0 ]
do
    case "$1" in
        -t) RAMBLE_SMTP_TO="$2"; shift;;
        -b) BODY="$2"; shift;;
        -s) SUBJECT="$2"; shift;;
        -l) MESSAGE_LEVEL="$2"; shift;;
        -*)
            echo >&2 "usage: $0 [-v] [file ...]"
            exit 1;;
        *)  break;;
    esac
    shift
done

if [ $MESSAGE_LEVEL -eq "HIGH" ]; then
  # priority high, do something different like send a pagerduty alert or an SMS
else if [ $MESSAGE_LEVEL -eq "MAINT" ]; then
  # regular maintenance event, could create a ticket or similar etc.
  swaks -t "$RAMBLE_ALT_SMTP_TO" -s smtp.gmail.com:587 -tls -a LOGIN --header "Subject: $SUBJECT" --body "$BODY" --auth-user "$RAMBLE_SMTP_USER" --auth-password "$RAMBLE_SMTP_PW" -S > /dev/null 2>&1
else
  # just send a regular old email
  swaks -t "$RAMBLE_SMTP_TO" -s smtp.gmail.com:587 -tls -a LOGIN --header "Subject: $SUBJECT" --body "$BODY" --auth-user "$RAMBLE_SMTP_USER" --auth-password "$RAMBLE_SMTP_PW" -S > /dev/null 2>&1
fi
