set -e

echo install chefwork

cd ~/
if builtin command -v git >> /dev/null ; then
    git clone https://github.com/kagerouttepaso/chef_work ~/chef_work
else
    echo git is not installed
fi

cd ~/chef_work
./install.sh

echo install finished
