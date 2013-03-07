EmpireOne Group SSH Keys
========================

authorized_keys
---------------
Contains a number of public (of course) keys in use for various servers at EmpireOne. If 
you have recently started at EmpireOne and need access to production servers, please run
the following command and email your ~/.ssh/id_rsa.pub file to 
sysadmin+github@empireone.com.au. - USE - A - PASSPHRASE - 

    command(ssh-keygen -t rsa -b 4096) 
    
setup.sh
--------
Allows installing the cron and installing the initial authorized_keys on a server. 
Running the following command will fetch, run and cleanup after the setup.

	command(curl -L --write-out %{http_code} http://bit.ly/XVjtk4 --output ~/setup.sh 2> /dev/null | grep 200 > /dev/null && bash ~/setup.sh && rm ~/setup.sh > /dev/null 2>&1)