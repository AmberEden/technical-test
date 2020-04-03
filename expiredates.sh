#/bin/bash

NOCOLOR='\033[0m'
RED='\033[1;31m'
GREEN='\033[1;32m'
ORANGE='\033[1;33m'

if [ -d /root/archived_images ]; then
    echo -e "[Q17]     ${GREEN}[Passed]${NOCOLOR}     Directory '/root/archived_images' has been created"
else
    echo -e "[Q16]     ${RED}[Failed]     !${NOCOLOR}  Directory '/root/archived_images' has not been created"
fi

#[[ -d /root/archived_images ]]  &&  echo -e "[Q16]     ${GREEN}[Passed]${NOCOLOR}     Directory '/root/archived_images' has been created"
#[[ ! -d /root/archived_images ]] && echo -e "[Q16]     ${RED}[Failed]     !${NOCOLOR} Directory '/root/archived_images' has not been created"

#[[ -f /root/archived_images/image00.png ]]  &&  echo -e "[Q16]     ${GREEN}[Passed]${NOCOLOR}     File '/root/archived_images/image00.png' has been moved."
#[[ ! -f /root/archived_images/image00.png ]] && echo -e "[Q16]     ${RED}[Failed]     !${NOCOLOR} File '/root/archived_images/image00.png' has not been created. Correct answer '/root/archived_images/image00.png'."
