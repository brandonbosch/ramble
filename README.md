Ramble is a simple cli alert tool to be used in bash scripts. It currently only sends via gmail smtp but SMS and pagerduty alerts would be cool in the future.

## Prerequisites

Included is a setup script for Ubuntu 16.04 and 16.10. Ramble uses [swaks](https://linux.die.net/man/1/swaks) to send mail. If you're on another distro that has Swaks, you should configure the following environment variables before use:

```bash
$RAMBLE_SMTP_TO=recipient@gmail.com
$RAMBLE_SMTP_USER=gmail_user@gmail.com
$RAMBLE_SMTP_PW=your_password
```

## Installation

Get a copy of the repo and run setup.sh:

```bash
git clone https://github.com/brandonbosch/ramble

cd ramble

chmod +x setup.sh ramble.sh

. /setup.sh (the space is important)

cp ramble.sh /usr/sbin/ramble

```

## Usage

The simplest way to use is just run ramble. It will mail a test message to the default $RAMBLE_SMTP_TO value:

```bash
ramble
```
You can supply any or none of these options:

```bash
ramble -t myrecipient@gmail.com -s "Test Subject" -b "Test Body"
```
