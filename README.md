chefの使い方
=======================

**このRecipeはUbuntu 13.10でうまく動きます**

### 環境のインストール

```bash
./install.sh
```

---

## chefの基本的な使い方

### repositoryの作り方

```bash
# レポジトリを作る。(このリポジトリみたいなものを作る)
rbenv exec bundle exec knife solo init chef-repo
cd chef-repo

# Recipeを作る
rbenv exec bundle exec knife cookbook create base -o site-cookbooks/

# chef-solo用ファイルを作る (knife-soloには必要ない)
vim ./solo.rb

# nodeごとにどんなRecipeを適用させるか設定する
vim ./nodes/hostname.json
```

### ローカル環境への適応方法

#### chef-solo使った方法(あまり推奨しない)

``` bash
sudo rbenv exec bundle exec chef-solo -c ./solo.rb -j ./nodes/localhost.json
```

#### Knife-solo使ったインストール(こっちのほうがおすすめ)
基本的に`install.sh`を叩いておけば、ローカルに対してchefが実行されるので、
下記のコマンドを頑張って入力する必要はない

```bash
rbenv exec bundle exec knife solo cook localhost
```

### ネットワークこしにChefる
#### 前提条件

- 対象PCへsshログインができること
- knife-solo中にめちゃめちゃパスワードを聞かれるので、SSHログインは公開鍵認証ができるようになっているとなお良い

#### 手順

1, 対象へ chefをインストールする

```bash
rbenv exec bundle exec knife solo prepare <hostname>
```

2, Jsonファイルを編集する

```bash
vim ./nodes/<hostname>.json
```

3, chefを起動する

```bash
rbenv exec bundle exec knife solo cook <hostname>
```
