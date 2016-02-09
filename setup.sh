#!/bin/bash
#
# Tiny piece of bash to manage a ~/.ssh/authorized_keys file on a server. Running the 
# script will 1) install a cron (hourly) to run #2 if one doesn't exist already, and 
# 2) download a list of authorized_keys and install it to the server. 
# 
# WARNING - This is vulnerable to a man-in-the-middle attack, so make sure you trust
# whoever is hosting your list (referenced by $keys below) and it's probably a good
# idea not to publish 'publicly' a list of server using this setup..

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 1 ] || die "You must specify the environment to run on (dev, ci or prd)"

# where should we pull a list of authorized_keys from?
keys=https://raw.githubusercontent.com/EmpireOne/ssh_keys/master/authorized_keys-prd-$1

# install the authorized_keys commant (pull, all good? mv)
cmd="mkdir -pm 700 ~/.ssh > /dev/null 2>&1 ; curl -Lk --write-out \%{http_code} $keys --output ~/.ssh/authorized_keys_dl 2> /dev/null | grep 200 > /dev/null && mv -f ~/.ssh/authorized_keys_dl ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys > /dev/null 2>&1;"

# make a cron job out of this
job="0 * * * * $cmd"

# install the cron job if it's not already installed.
cat <(fgrep -i -v "$cmd" <(crontab -l)) <(echo "$job") | crontab -

# run the command
eval $cmd
