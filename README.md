# おみやげ情報共有SNS「おみやげ広場」
<img width="1427" alt="スクリーンショット 2023-04-28 19 14 45" src="https://user-images.githubusercontent.com/102449510/235124212-2a22b8b9-c858-4369-be58-0d7ac4398fd2.png">

## URL https://omiyagehiroba.xyz
<br><br>

# アプリ概要
おみやげ広場は自分や家族へのちょっとしたご褒美として購入する、おみやげの情報を共有するサービスです。
<br><br>
私の最近の楽しみは自分や家族にケーキやお饅頭などのおやつをおみやげとして買って帰ることです。  
新しいおみやげを探そうと食べログなどの飲食店を探すサービスで検索しますが、多くのサービスではイートインやお弁当なども含まれており、おみやげだけを探そうとするとなかなか大変でした。  
そこで、持って帰って食べるおみやげの情報のみを共有する専用のサービスを自分で立ち上げようと思い、このサービスを作成しました。
<br><br>
このサービスは誰もが知っている名店のケーキ屋さんのショートケーキから、路地裏にある穴場の和菓子屋さんの蓬餅まで、  
みんなとおすすめのおみやげ情報を共有できます。
<br><br>
おみやげ広場の使い方については当サービスのおみやげ広場とは？のページをご覧ください。
<br><br>

# こだわりポイント
* いいね機能ではajaxを使用して、非同期通信を行なっている。
* Google Maps APIを利用して、おみやげを購入した場所の位置情報を表示している。
* Bootstrapを用いてレスポンシブ対応をしている。
* AWSを使用し、ALBを通じて常時SSL通信をしている。
* CircleCIを使用し、テスト、ビルド、デプロイの自動化を行なっている。
<br><br>

# 使用技術
* ruby 2.7.7
* Rails 6.1.7
* MySQL 5.7
* Nginx
* Unicorn
* AWS
  * VPC
  * EC2
  * RDS
  * S3
  * Route53
  * ALB
  * ACM
* Docker/Docker-compose
* CircleCI CI/CD
* RSpec
* Google Maps API
<br><br>
  
# インフラ構成図
![AWS (1)](https://user-images.githubusercontent.com/102449510/236106495-857e758d-cb1a-4968-b7f0-3307fab3a8df.jpg)
<br><br>
<br><br>

# ER図
![omiyage_ER (1)](https://user-images.githubusercontent.com/102449510/235268812-cf0291d5-fff5-4743-95c9-01783d787a53.jpg)
<br><br>
<br><br>

# 機能一覧
* ユーザー登録、ログイン機能、ゲストログイン機能、退会機能(devise)
* 投稿機能
  * 画像投稿(Active Storage)
  * 位置情報表示機能(geocoder)
* いいね機能(ajax)
* コメント機能
* フォロー機能
* ページネーション機能(kaminari)
* 検索機能(ransack)
  * ソート機能
* 投稿画像ランダム表示機能
* フラッシュメッセージ機能(toastr)
<br><br>

# 非機能一覧
* テスト(Rspec)
  * 単体テスト(model)
  * 統合テスト(system)
* 初期データ(seeds.rb)
