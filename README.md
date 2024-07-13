# Terraformの学習記録

## 1. Terraformを導入してNginxを起動してみる
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
- main.tfを作成してnginxを起動するファイルを作成
- terraformのprojectを初期化
```
terraform init
```
- applyコマンドでNginxを起動してみる
```
terraform apply
```
- dockerコマンドでcontainerの起動状況を確認する
```
$ docker ps
CONTAINER ID        IMAGE                     COMMAND                  CREATED             STATUS              PORTS                    NAMES
425d5ee58619        e791337790a6              "nginx -g 'daemon of…"   20 seconds ago      Up 19 seconds       0.0.0.0:8000->80/tcp     tutorial
```
- destroyコマンドでcontainerを止める
```
terraform destroy
```

## 2.EC2インスタンスを生成・削除してみる
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build
- EC2生成する設定をmain.tfに記載する
  - 東京RegionだとVPCやサブネットの生成が事前に必要となる
- 各用語について理解する
  - Terraform Block
  - Providers
  - Resources
- 環境変数を`variables.tf`に定義してmain.tfで参照する
- applyコマンドでインスタンスを生成できることを確認する
- destroyコマンドでインスタンスを削除できること確認する

## 3. サブネットをインターネット接続できるようにする
- VPC作成
- インターネットゲートウェイを作成
- サブネットを作成
  - パブリックサブネット用にサブネットを作成
- ルートテーブルを作成
  - インターネットゲートウェイを作成しただけだとインターネット接続できない