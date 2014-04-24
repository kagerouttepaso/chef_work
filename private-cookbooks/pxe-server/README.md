pxe-server Cookbook
===================
PXE Serverの構築を自動で行います


実行環境
------------
#### 仮想ホストマシン設定
ホストPCはインターネットに接続されている必要があります

#### 仮想マシン設定
このレシピの想定する仮想マシンの設定を下記にまとめます。  

- ネットワーク
    - アダプター1は `NAT` に設定してください
    - アダプター2は `ブリッジアダプター` を選択し、
      テスト機と接続する有線LANのデバイスを選択してください

#### OS設定
OSは `Ubuntu Server 13.10` を想定しています。  
プロキシ環境下でCHEFを実行するときは `/etc/environment` に、
`http_proxy` , `https_proxy` , `ftp_proxy` ,を定義して
再起動してから実行してください



使い方
-----
#### pxe-server::default
`pxe-server` をインストールするノードの `run_list` に追加してください  
PXE Serverの設定の一部は再起動するまで適応されないものがあるので、
Chefの実行後は仮想マシンを再起動してください。

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[pxe-server]"
  ]
}
```

PXE Serverの情報
----
#### 使い方
下記の手順で仮想マシンを立ち上げると、ホストPCの有線LANを使用してPXE Bootのテストが行えます。

1. クライアントPC(テストされる側のPC)とホストPC(テストする側のPC)を有線LANで接続します
2. `./PXEServer.vbox` をホストPCのVirtualBoxで読み込んでください  
3. 読み込んだ仮想マシン(PXEServer)の設定ウィンドウを開き、
   `仮想マシンの設定→ネットワーク→アダプター2` を下記のとおりに設定してください  
4. 仮想マシンを立ち上げます
5. クライアントPCを `PXE Boot` で立ち上げます
6. クライアントPCで `Ubuntu Desktop 13.10` が起動します

**アダプター2のネットワーク設定**

項目     | 内容
:--      | :--
割り当て | ブリッジアダプター
名前     | ホストPCの有線LANポートのデバイス


#### 設定情報
仮想マシンの設定は以下のとおりです

##### サーバーの情報
仮想マシン上のサーバーは下記のとおりに動作するよう設定されています

項目                   | 内容
:--                    | :--
サーバーのIPアドレス   | 192.168.150.10
DHCPの割り当てIP       | 192.168.150.201~249
PXE Bootで立ち上がるOS | Ubuntu Desktop 13.10 64bit

##### PXE Boot用の設定一覧
仮想マシンはUbuntu Server 12.10をもとに下記のとおりにパッケージの追加と、関連ファイルの編集が行われています

パッケージ名      | 用途
:--               | :--
isc-dhcp-server   | DHCPサーバー
tftpd-hpa         | TFTPサーバー
nfs-kernel-server | NFSサーバー
syslinux          | pxelinux.0のコピー元
grub-efi          | EFI版Grubの生成


変更したファイル                                   | 説明
:--                                                | :--
/etc/dhcp/dhcpd.conf                               | DHCPサーバーの設定を追加
/etc/exports                                       | NFSサーバーの設定を追加
/etc/default/tftpd-hpa                             | TFTPサーバーの設定を追加
/etc/rc.local                                      | Ubuntuのディスクイメージを自動でマウントするように設定
/etc/network/interfaces                            | ネットワークインターフェイスの追加
/var/lib/tftpboot/ubuntu-13.10-desktop-amd64.iso   | Ubuntuのディスクイメージ
/var/lib/tftpboot/image/ubuntu-13.10-desktop-amd64 | ディスクイメージのマウント先
/var/lib/tftpboot/pxelinux.0                       | /usr/lib/syslinux/pxelinux.0からコピーしたNBP
/var/lib/tftpboot/pxelinux.cfg/default             | NBPが参照する設定を追加
/var/lib/tftpboot/boot                             | UEFI用のブートローダー一式



License and Authors
-------------------
Authors: kitsunai daisuke
Licence: MIT
