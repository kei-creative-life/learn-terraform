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

## 2. EC2インスタンスを生成・削除してみる
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

## 4. WebサーバーにNginxをインストールして起動してみる
- セキュリティグループのインバウンドルールにport80番を追加
- user_dataを用いてnginxをインストールして起動する
![スクリーンショット 2024-07-15 0 00 04](https://github.com/user-attachments/assets/9ddd4638-4103-4048-b172-a68e92f84846)

## 5. WebサーバーにNuxt3プロジェクトをcloneして起動してみる
勉強のためにEC2にssh接続して以下を実行する

- voltaをインストール
```
curl https://get.volta.sh | bash
source ~/.bashrc
```
- nodeをインストール
```
volta install node
node -v
```
- gitをインストール
```
sudo dnf install git -y
```
- 鍵を生成
```
ssh-keygen -t ed25519 -C "githubに登録しているアドレス"
＊生成した鍵をgithubで登録
ssh -T git@github.com
```
- git clone
```
git clone git@github.com:kei-creative-life/nuxt3-project.git
```
- nuxtサーバーを起動
```
npm install
npm dev
```
- nginxの設定を変更
```
sudo vi /etc/nginx/conf.d/nuxt.conf

server {
    listen 80;
    server_name "EC2のパブリックIPアドレスを設定します";

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}

# 構文チェック
sudo nginx -t

# nginxをリロードする
sudo systemctl reload nginx
```
