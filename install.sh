echo install chef_work

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
    echo http_proxy is ${http_proxy}
fi

cd ~/
if builtin command -v git >> /dev/null ; then
    if [ ! -d ~/chef_work ]; then
        git clone https://github.com/kagerouttepaso/chef_work ~/chef_work
    fi
else
    echo git is not installed
fi

cd ~/chef_work
./install.sh

echo install finished
