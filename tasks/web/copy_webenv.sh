# https://github.com/sarbogast/buzzwordbingo/blob/starter/copy_webenv.sh
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

cp -rf ./webenv/$1/* web/ 

if [ $? -eq 0 ]
then
    echo "${green}Copied web assets for $1${reset}"
else 
    echo "${red}Failed to copy web assets for $1${reset}"
fi