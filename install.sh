set -e

echo install chef_work
TMP_DIR="/tmp/chef_work"
if [ ! -d ${TMP_DIR} ]; then
    mkdir ${TMP_DIR}
fi
if [ ! -d ${TMP_DIR} ]; then
    echo "can not create tmp dir "
    exit
fi

if [ ! -f /etc/lsb-release ]; then
    echo "This OS is not Ubuntu"
    exit
fi

cd ~/

if command -v git >> /dev/null ; then
    echo git is installed
else
    echo git is not installed
    (set -x; sh -c "sudo apt-get install -y -q git" )
fi 

if [ "`printenv | grep -i 'http_proxy'`" = "" ]; then
    #register proxy
    ANS="n"
    echo -n "register proxy? [y/N] >"
    #read ANS
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
    git config --global http.proxy "${http_proxy}"
fi


echo "modify sudoers"
TMP_SUDOERS=${TMP_DIR}/sudoers
sudo cat /etc/sudoers >${TMP_SUDOERS}
if [ "`cat ${TMP_SUDOERS} | grep env_keep | grep http_proxy`" = "" ] && [ "${http_proxy}" != "" ] ;then
    echo "   add env_keep"
    echo "Defaults env_keep=\"http_proxy https_proxy ftp_proxy\"" >> ${TMP_SUDOERS}
fi
USERNAME=`id -un`
if [ "`cat ${TMP_SUDOERS} | grep ${USERNAME} | grep NOPASSWD `" = "" ];then
    echo " add ${USERNAME} NOPASSWD"
    sed -i -e "s/^.*${USERNAME}.*$//g" ${TMP_SUDOERS}
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> ${TMP_SUDOERS}
fi
sudo cp ${TMP_SUDOERS} /etc/sudoers


if [ -d ~/chef_work ]; then
  sudo rm -rf ~/chef_work
fi
git clone https://github.com/kagerouttepaso/chef_work ~/chef_work

sudo rm -rf ~/.ssh

cd ~/chef_work
./install.sh

echo install finished
