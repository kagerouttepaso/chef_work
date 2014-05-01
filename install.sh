echo install chef_work
#TMP_DIR="/var/tmp/chef_work"
#mkdir ${TMP_DIR}
#if [ ! -d ${TMP_DIR} ]; then
#    echo "can not create tmp dir "
#    exit
#fi

if [ ! -f /etc/lsb-release ]; then
    echo "This OS is not Ubuntu"
    exit
fi

if [ "`printenv | grep -i 'http_proxy'`" = "" ]; then
    #register proxy
    ANS="n"
    echo -n "register proxy? [y/N] >"
    read ANS
    if [ "${ANS}" = "y" ] || [ "${ANS}" = "Y" ] ; then
        while :
        do
            echo -n "write proxy address i.e. http://proxy.com:port \n >"
            read PROXY
            echo -n "http_proxy is ${PROXY} \ncan you register? [y/n] >"
            read ANS
            if [ "${ANS}" = "y" ] || [ "${ANS}" = "Y" ] ; then
                echo "export proxy"
                export http_proxy="${PROXY}"
                export https_proxy="${PROXY}"
                export ftp_proxy="${PROXY}"
                echo "[http]\n proxy = ${PROXY}" >> ~/.gitconfig
                break
            elif [ "${ANS}" = "n" ] || [ "${ANS}" = "N" ] ; then
                break
            fi
        done
    fi
else
    echo "http_proxy is ${http_proxy}"

    if [ -f ~/.gitconfig ] && [ "`cat ~/.gitconfig | grep -i proxy`" != "" ] ; then
        echo "git proxy setting"
    else
        git config --global http.proxy "${PROXY}"
    fi
fi

if [ `cat /etc/lsb-release| grep RELEASE|sed -e "s/.*=\(.*\)/\1/"` = "14.04" ]; then
    while [ "`sudo cat /etc/sudoers | grep env_keep | grep http_proxy`" = "" ] && [ "${http_proxy}" != "" ] ; do
        echo "please write env_keep on /etc/sudoers"
        echo "i.e) Default env_keep=\"http_proxy\""
        echo "Please Enter run visudo"
        read ANS
        sudo visudo
    done
fi

cd ~/
if command -v git >> /dev/null ; then
    if [ ! -d ~/chef_work ]; then
        git clone https://github.com/kagerouttepaso/chef_work ~/chef_work
    fi
else
    echo git is not installed
fi

cd ~/chef_work
./install.sh

echo install finished
