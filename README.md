# README

# **こみゅにてぃあ**
<img width="1000" src="https://user-images.githubusercontent.com/72908323/136355869-25e88e94-21a3-4cd7-84fc-b6fc16c0c45f.png"><br>

# 概要
## 地域活性化を目的とした情報交換サービス
https://communiteer-app.com/<br>
一定の地域内(市町村程度)で個人・団体(社会福祉法人・学校法人など)間のボランティア等の情報を結び地域活性につなげるサービス<br>


## 制作背景
きっかけは友人ずてで誘われたボランティアにあります。<br>
サイトなどで募集されているボランティアではなく、友人ずてで知人の農業を手伝う(台風で落果する前に果実の収穫)ボランティアでした。その後、実際のボランティアの現状を調べてみたところ個人がボランティア活動を募集する場が少ないことを感じました。大型ボランティアサイト「activo(アクティボ)」や「Yahoo!ボランティア」などは個人よりも団体・法人の募集が多いように思います。<br>
また、ボランティアに参加しない理由として「経費(交通費など)の負担が大きい」「ボランティアに関する情報が得にくい」「募集している団体に不信感がある」などもありました。<br>
更にボランティア活動の実情を知りたいと思い「地域に特化したボランティアコーディネートをしている知人」に話を伺いました。<br>
その方は「得意ごとを地域で活かしたい人が潜在的にいる(地域の活性化につながる)のにそういう人を見つける手段が少ない」、「地域の市民活動団体(個人運営サロンなど)同士の横のつながりがないためそういった人たちが情報交換ができない」などの点も困っているといってました。<br>
また、私はある地域の福祉法人のHPを見ていて「社会福祉法人の人達が行ったボランティアや行事の活動の様子があまり発信されていない」という疑問もありました。<br>
そこで私は下記が行えるサービスがあればいいのではと考えました。<br>

## 使用技術
### フロントエンド
 - HTML/CSS
 - JavaScript
 - TailwindCSS（UIフレームワーク）
### バックエンド
 - Ruby 3.0.2
 - Ruby on Rails 6.1.4.1
 - MySQL 8.0.25
 - Rubocop（コード解析ツール）
 - RSpec（テスト）
### インフラ
 - AWS(IAM/VPC/EC2/RDS/S3/Route53/ACM/ALB)
 - Nginx
 - Puma
### 開発環境
 - VSCode
 - Git/GitHub
 - Docker/Docker-compose
 - CircleCI
 - Capistrano

## 機能一覧
### 基本機能
 - ユーザー機能(個人用・団体用の2種)
   - アカウント登録
   - ログイン・ログアウト
   - ゲストログイン
 - DM機能
   - DM相手一覧・最新メッセージの表示
   - 既読・未読の表示
   - ヘッダーにてアイコン表示による通知
   - メッセージの送信・削除(Actioncable)
 - マイページ
   - プロフィール編集
   - DM画面遷移
   - 投稿・応募・応援の各種表示(javascript)
 - 通知
   - 参加・承認・応援の通知
   - 画面遷移リンク(他者マイページ・募集詳細・応募詳細へ遷移)
   - ヘッダーにてアイコン表示による通知
### 投稿機能(現時点：ボランティア募集のみ)
 - 投稿
   - 新規作成
   - 画像添付・画像プレビュー(javascript)
 - 一覧
   - 投稿一部動的表示(TOP画面でSwiper使用)
 - 詳細
   - 削除・編集
   - 活動場所地図表示(Google Maps API使用)
   - 参加・応援(応援者一覧ページ遷移)・訪問数表示
   - 応募ページ遷移
   - 応募締切ボタン・応募者一覧ページ遷移
   - 応援ボタン(javascript)
   - 画面遷移リンク(自身・他者マイページ)
### 応募機能(現時点：ボランティア応募のみ)
 - 応募
   - 新規作成
 - 一覧
   - 未承諾・承諾の表示
   - 詳細ページ遷移
 - 詳細
   - 承諾ボタン
   - DM画面遷移
### 共通機能
 - ページネーション
 - もどるボタン(TOP画面・詳細ページ・一覧ページ遷移等)
 - レスポンシブ対応<br>

## 工夫・意識した点
**1. ポリモーフィック関連の使用**<br>
ユーザ登録には「個人用」と「団体用(法人や市営関連)」の2種類の作成を考えました。<br>
その際にID番号でどちらか特定するのが厳しかったため、<br>
ポリモーフィックを使用して個人用(User)と団体用(Group)の識別を行いました。<br>

**2. 見た目**<br>
シンプルなUI/UXおよびレスポンシブに対応を実装しました。<br>
また、投稿された最新情報はSwiperでスライド表示しており、<br>
あまり、画面下部までスクロールさせないようにしました。<br>

**3. 募集の締切**<br>
募集投稿には締切日を必須としており、<br>
日付を過ぎた場合はリアルタイムではないものの応募できないようにしました。<br>
また、ユーザ操作で締め切ることもできます<br>

**4. DMでのActionCableの使用**<br>
募集者と参加者の情報共有を簡単にするため、<br>
チャットのようにリアルタイム更新でメッセージの送信・削除をできるようにしました。(デモ動画あり)<br>

**5. Google Maps APIの使用**<br>
活動場所はモーダルを使用して地図表示できるようにしました。(デモ動画あり)<br><br>

### デモ動画
#### ActionCableを使用したDMの送信・削除
![DMデモ動画](https://user-images.githubusercontent.com/72908323/136690293-903b1cae-ac18-4a1c-ab77-af1caad9939d.gif)

#### Modleを使用した地図表示
![地図デモ動画](https://user-images.githubusercontent.com/72908323/136690332-ead55ebb-c23a-46b4-9d73-486b6e538bb3.gif)

## インフラ構成図
<img width="876" alt="communiteer_インフラ構成図" src="https://user-images.githubusercontent.com/72908323/136638723-8690609c-1d53-45b5-a783-4b3b8f31687e.png">

## ER図
<img width="908" alt="comuniteer_ER" src="https://user-images.githubusercontent.com/72908323/137623264-f2cadb95-a842-4486-b5d3-c202a8d62a9e.png"><br>
