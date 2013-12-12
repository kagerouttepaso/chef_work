chefの使い方
=======================

**このRecipeはUbuntu13.10でうまく動きます**


##環境のインストール

```bash:bash
#もしお仕事なら
./install.sh oshigoto
#プライベートユース
./install.sh
```

##repositoryの作り方

```bash:bash
#レポジトリを作る。
bundle exec knife solo init chef-repo
cd chef-repo

#Recipeを作る
bundle exec knife cookbook create base -o site-cookbooks/

#chef-solo用ファイルを作る (knife-soloには必要ない)
vim ./solo.rb

#nodeごとにどんなRecipeを適用させるか設定する
vim ./nodes/localhost.json
```
----------------------
##実行
###ローカル環境への適応方法

####chef-solo使った方法

``` bash:bash
sudo bundle exec chef-solo -c ./solo.rb -j ./nodes/localhost.json
```

####Knife-solo使ったインストール

```bash:bash
bundle exec knife solo cook localhost
```

###ネットワークこしにChefる
####前提条件

- 対象PCへsshログインができること
- knife-solo中にめちゃめちゃパスワードを聞かれるので、SSHログインは公開鍵認証ができるようになっているとなお良い

####手順

1, 対象へ chefをインストールする

```bash:bash
bundle exec knife solo prepare <hostname>
```

2, Jsonファイルを編集する

```bash:bash
vim ./nodes/<hostname>.json
```

3, chefを起動する

```bash:bash
bundle exec knife solo cook <hostname>
```
