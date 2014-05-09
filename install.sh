set -e
if [ ! -f /etc/lsb-release ]; then
    echo "This OS is not Ubuntu"
    exit
fi

echo "install chef_work"

echo "create tmp_dir"
TMP_DIR="/tmp/chef_work"
if [ ! -d ${TMP_DIR} ]; then
    mkdir ${TMP_DIR}
fi
if [ ! -d ${TMP_DIR} ]; then
    echo "    can not create tmp dir "
    exit
fi

echo "1.modify sudoers"
TMP_SUDOERS=${TMP_DIR}/sudoers
sudo cat /etc/sudoers >${TMP_SUDOERS}
USERNAME=`id -un`
if [ "`cat ${TMP_SUDOERS} | grep ${USERNAME} | grep NOPASSWD `" = "" ];then
    echo "    add ${USERNAME} NOPASSWD"
    sed -i -e "s/^.*${USERNAME}.*$//g" ${TMP_SUDOERS}
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> ${TMP_SUDOERS}
fi
if [ "`cat ${TMP_SUDOERS} | grep env_keep | grep NOPASSWD `" = "" ];then
    echo "    add env_proxy"
    sed -i -e "s/^.*env_keep*$//g" ${TMP_SUDOERS}
    echo "Defaults env_keep=\"http_proxy https_proxy ftp_proxy\"" >> ${TMP_SUDOERS}
fi
sudo cp ${TMP_SUDOERS} /etc/sudoers

echo "2.proxy setting"
if [ "`printenv | grep -i 'http_proxy'`" = "" ]; then
    #register proxy
    ANS="n"
    echo -n "    register proxy? [y/N] >"
    exec 0</dev/tty               
    read ANS
    if [ "${ANS}" = "y" ] || [ "${ANS}" = "Y" ] ; then
        while :
        do
            echo -n "    write proxy address i.e. http://proxy.com:port \n    >"
            exec 0</dev/tty               
            read PROXY
            echo -n "    http_proxy is ${PROXY} \n    can you register? [y/n] >"
            exec 0</dev/tty               
            read ANS
            if [ "${ANS}" = "y" ] || [ "${ANS}" = "Y" ] ; then
                echo "    export proxy"
                export http_proxy="${PROXY}"
                export https_proxy="${PROXY}"
                export ftp_proxy="${PROXY}"
                break
            elif [ "${ANS}" = "n" ] || [ "${ANS}" = "N" ] ; then
                break
            fi
        done
    fi
else
    echo "    http_proxy is ${http_proxy}"
fi

if [ "`printenv | grep -i 'http_proxy'`" != "" ]; then
    echo "    modify /etc/environment"
    TMP_ENVIRONMENT=${TMP_DIR}/environment
    sudo cat /etc/environment >${TMP_ENVIRONMENT}
    sed -i -e "s/^.*http_proxy.*$//g" ${TMP_ENVIRONMENT}
    sed -i -e "s/^.*https_proxy.*$//g" ${TMP_ENVIRONMENT}
    sed -i -e "s/^.*ftp_proxy.*$//g" ${TMP_ENVIRONMENT}
    sed -i -e "s/^.*HTTP_PROXY.*$//g" ${TMP_ENVIRONMENT}
    sed -i -e "s/^.*HTTPS_PROXY.*$//g" ${TMP_ENVIRONMENT}
    sed -i -e "s/^.*FTP_PROXY.*$//g" ${TMP_ENVIRONMENT}
    echo "http_proxy=\"${http_proxy}\"" >> ${TMP_ENVIRONMENT}
    echo "https_proxy=\"${http_proxy}\"" >> ${TMP_ENVIRONMENT}
    echo "ftp_proxy=\"${http_proxy}\"" >> ${TMP_ENVIRONMENT}
    sudo cp ${TMP_ENVIRONMENT} /etc/environment
fi

echo "3.install packages"
if command -v git >> /dev/null ; then
    echo "    git is installed"
else
    echo "    git is not installed"
    sudo apt-get install -y -q git >/dev/null
fi 
if [ "`printenv | grep -i 'http_proxy'`" != "" ]; then
    git config --global http.proxy "${http_proxy}"
fi

if command -v sshd >> /dev/null ; then
    echo "    ssh-server is installed"
else
    echo "    ssh-server is not installed"
    sudo apt-get install -y -q openssh-server >/dev/null
fi 


if [ -d ~/chef_work ]; then
  sudo rm -rf ~/chef_work
fi
git clone https://github.com/kagerouttepaso/chef_work ~/chef_work

sudo rm -rf ~/.ssh

cd ~/chef_work
./install.sh

echo install finished
