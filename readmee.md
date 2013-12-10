chefの使い方
=======================

##環境のインストール

```bash:bash
sudo apt-get install ruby2.0
sudo apt-get install ruby2.0-dev
sudo apt-get install  chef
sudo gem install knife-solo
knife configure
```

##repositoryの作り方

```bash:bash
knife solo init chef-repo
cd chef-repo
knife cookbook create base -o site-cookbooks/
vim ./solo.rb
vim ./nodes/localhost.json
```

##ローカル環境への適応方法

``` bash:bash
sudo chef-solo -c ./solo.rb -j ./nodes/localhost.json
```
