#!/bin/bash

NOCOLOR='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'
ORANGE='\033[1;33m'

IP=`curl -s 4.icanhazip.com`

if [ "`grep -c -i '^john' /etc/passwd`" -eq 1 ]; then
    echo -e "[Q10]     ${GREEN}[Passed]${NOCOLOR}     User 'john' exists"
else
    echo -e "[Q10]     ${RED}[Failed]     !${NOCOLOR} User 'john' does not exist"
fi

if [ "`grep -c -i '^john' /etc/passwd`" -eq 1 ] && [ "`chage -l john | grep Account | awk '{ print $4}'`" != "never" ]; then
    if [ "` chage -l john | grep Account | awk '{ print $4,$5,$6}'`" == "`date '+%b %d, %Y' -d '+7 days'`" ]; then
        echo -e "[Q11]     ${GREEN}[Passed]${NOCOLOR}     john's account expires on the `chage -l john | grep Account | awk '{ print $4,$5,$6}'`"
    else
        echo -e "[Q11]     ${ORANGE}[Partial]    !${NOCOLOR} john's account expires but not in 7 days - `chage -l john | grep Account | awk '{ print $4,$5,$6}'`"
    fi
else
    echo -e "[Q11]     ${RED}[Failed]     !${NOCOLOR} john's account does not have an expire set"
fi

if [ "`hostname`" == "mail.padawan.test" ]; then
    echo -e "[Q12]     ${GREEN}[Passed]${NOCOLOR}     The hostname = `hostname`"
else
    echo -e "[Q12]     ${RED}[Failed]     !${NOCOLOR} The hostname = `hostname`. Correct answer = mail.padawan.test"
fi

if [ "`php -m | grep -c bcmath`" -eq 1 ]; then
    echo -e "[Q13]     ${GREEN}[Passed]${NOCOLOR}     php-bcmath is installed"
else
    echo -e "[Q13]     ${RED}[Failed]     !${NOCOLOR} php-bcmath is not installed"
fi

if [ "`grep memory_limit /etc/php.ini | grep -v '#\|;' | cut -d= -f2 | awk '{$1=$1};1'`" == "512M" ]; then
    echo -e "[Q14]     ${GREEN}[Passed]${NOCOLOR}     memory_limit=512M"
else
    echo -e "[Q14]     ${RED}[Failed]     !${NOCOLOR} memory_limit=`grep memory_limit /etc/php.ini | awk '{print $3}'`. Correct answer = 512M"
fi

if [ "`timedatectl | grep -c Europe/London`" -eq 1 ]; then
    echo -e "[Q15]     ${GREEN}[Passed]${NOCOLOR}     Time Zone is Europe/London"
else
    echo -e "[Q15]     ${RED}[Failed]     !${NOCOLOR} Time Zone is `timedatectl | grep "Time zone" | awk '{print $3}'`.  Correct answer = Europe/London"
fi

if [ -d /root/archived_images ]; then
    echo -e "[Q16]     ${GREEN}[Passed]${NOCOLOR}     Directory '/root/archived_images' has been created"
else
    echo -e "[Q16]     ${RED}[Failed]     !${NOCOLOR}  Directory '/root/archived_images' has not been created"
fi

if [ -f /root/archived_images/image00.png ]; then
    echo -e "[Q17]     ${GREEN}[Passed]${NOCOLOR}     File is present: '/root/archived_images/`ls /root/archived_images`'."
elif [ -f /root/archived_images/image* ]; then
    echo -e "[Q17]     ${ORANGE}[Partial]    !${NOCOLOR} Incorrect file present: `ls /root/archived_images`"
else
    echo -e "[Q17]     ${RED}[Failed]     !${NOCOLOR} File is not present '/root/archived_images/image00.png'."
fi

if [ "`curl -s -o /dev/null -w "%{http_code}"  http://$IP/wp-login.php`" -eq 200 ]; then
    echo -e "[Q18]     ${GREEN}[Passed]${NOCOLOR}     Able to reach the wordpress website. "
else
    echo -e "[Q18]     ${RED}[Failed]     !${NOCOLOR} Unable to access wordpress."
fi

if [ "`find /var/www/vhosts/demo.com/wp-content/uploads/ -type f -size +8M | wc -l`" -ge 1 ]; then
    echo -e "[Q19]     ${GREEN}[Passed]${NOCOLOR}     File has been uploaded"
else
    echo -e "[Q19]     ${RED}[Failed]     !${NOCOLOR} File has not been uploaded to /var/www/vhosts/demo.com/wp-content/uploads. `grep upload_max_filesize /etc/php.ini` `grep post_max_size /etc/php.ini`"
fi

if [ "`curl -s -o /dev/null -w "%{http_code}"  http://$IP/question20.php`" -eq 200 ]; then
    echo -e "[Q20]     ${GREEN}[Passed]${NOCOLOR}     Script ran successfully, `grep max_execution_time /etc/php.ini`"
else
    echo -e "[Q20]     ${RED}[Failed]     !${NOCOLOR} Script does not run successfully, `grep max_execution_time /etc/php.ini`"
fi

if [ "`curl -s -o /dev/null -w "%{http_code}" http://$IP:8080`" -eq 200 ]; then
    echo -e "[Q21]     ${GREEN}[Passed]${NOCOLOR}     Able to connect on port 8080"
else
    echo -e "[Q21]     ${RED}[Failed]     !${NOCOLOR} Unable to connect on port 8080"
fi

if [ "`curl -s -o /dev/null -w "%{http_code}" http://$IP/phpinfo.php`" -eq 200 ]; then
    echo -e "[Q21]     ${GREEN}[Passed]${NOCOLOR}     Permissions error resolved and phpinfo page returns a 200 ok"
else
    echo -e "[Q21]     ${RED}[Failed]     !${NOCOLOR} Unable to return the phpinfo page."
fi

if [ "`find /root/backup -type f | wc -l`" -gt 0 ]; then
    echo -e "[Q22]     ${GREEN}[Passed]${NOCOLOR}     Contents found in /root/backup  - check there is a .sql here"
else
    echo -e "[Q22]     ${RED}[Failed]     !${NOCOLOR} No contents found in /root/backup"
fi
