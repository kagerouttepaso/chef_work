chefの使い方
=======================

**このRecipeはUbuntu 14.04でうまく動きます**

### 環境のインストール

1. proxyの設定があるなら済ます
    - `ubuntu14.04`
    - `ubuntu14.04` だと、Sudoで環境変数を引き継げないみたい
    - `sudo vim /etc/enviroments` `sudo visudo` でプロキシ設定を入れのが最短？？
1. `openssh-server` をインストール
1. `localhost` にsshログインできるようにする
1. 下記のコマンド実行


**/etc/enviroments**

```
http_proxy="http://proxy.com:port"
https_proxy="http://proxy.com:port"
ftp_proxy="http://proxy.com:port"
no_proxy="localhost 192.168.*.*"
```

**/etc/suなんとか**

```
Defaults  env_keep="http_proxy https_proxy ftp_proxy no_proxy"
```

**コマンド**

```bash
./install.sh localhost init
```

---

## chefの基本的な使い方

### repositoryの作り方

``` bash
# レポジトリを作る。(このリポジトリみたいなものを作る)
rbenv exec bundle exec knife solo init chef-repo
cd chef-repo

# Recipeを作る
rbenv exec bundle exec knife cookbook create <recipe_name> -o site-cookbooks/

# nodeごとにどんなRecipeを適用させるか設定する
vim ./nodes/<hostname>.json
```

### ローカル環境への適応方法

#### Knife-solo使ったインストール
基本的に`install.sh`を叩いておけば、ローカルに対してchefが実行されるので、
下記のコマンドを頑張って入力する必要はない

```bash
rbenv exec bundle exec knife solo cook localhost
#or
./install.sh
```

### ネットワーク越しにChefる
#### 前提条件

- 対象PCへsshログインができること
- knife-solo中にめちゃめちゃパスワードを聞かれるので、SSHログインは公開鍵認証ができるようになっているとなお良い

#### 手順

1, 対象へ chefをインストールする

```bash
rbenv exec bundle exec knife solo prepare <hostname>
#or
./install.sh <hostname> init
```

2, Jsonファイルを編集する

```bash
vim ./nodes/<hostname>.json
```

3, chefを起動する

```bash
rbenv exec bundle exec knife solo cook <hostname>
#or
./install.sh <hostname>
```
