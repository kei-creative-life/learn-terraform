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

