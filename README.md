chefの使い方
=======================

**このRecipeはUbuntu13.10でうまく動きます**


##環境のインストール

```bash:bash
#なにはなくともRuby
sudo apt-get install ruby2.0
#Kinife-soloに必要っぽい
sudo apt-get install ruby2.0-dev
#gemでもインストールできるらしいけど、今回はaptをつかう
sudo apt-get install  chef
#knife-soloは必須です
sudo gem install knife-solo
#初回のみコンフィグを行う。
#いろいろ聞かれるけど全部yで問題なし
knife configure

#サードパーティー製のRecipeを使うならこれもインストールしておく
sudo gem i berkshelf
```

##repositoryの作り方

```bash:bash
#レポジトリを作る。
knife solo init chef-repo
cd chef-repo

#Recipeを作る
knife cookbook create base -o site-cookbooks/

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
sudo chef-solo -c ./solo.rb -j ./nodes/localhost.json
```

####Knife-solo使ったインストール

```bash:bash
knife solo cook localhost
```

###ネットワークこしにChefる
####前提条件

- 対象PCへsshログインができること
- knife-solo中にめちゃめちゃパスワードを聞かれるので、SSHログインは公開鍵認証ができるようになっているとなお良い

####手順

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
