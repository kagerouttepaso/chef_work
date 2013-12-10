chefの使い方
=======================

**このRecipeはUbuntu13.10でうまく動きます**


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
----------------------
##実行
###ローカル環境への適応方法

chef-solo使った方法

``` bash:bash
sudo chef-solo -c ./solo.rb -j ./nodes/localhost.json
```

Knife-solo使ったインストール

```bash:bash
knife solo cook localhost
```

##ネットワークこしにChefる
###前提条件

- 対象PCへsshログインができること
- knife-solo中にめちゃめちゃパスワードを聞かれるので、SSHログインは公開鍵認証ができるようになっているとなお良い

###手順

1, 対象へ chefをインストールする

```bash:bash
knife solo prepare <hostname>
```

2, Jsonファイルを編集する

```bash:bash
vim ./nodes/<hostname>.json
```

3, chefを起動する

```bash:bash
knife solo cook <hostname>
```
