require 'faker'

membership = 6
posts      = 7
user       = []
group      = []
volunteer  = []

# ユーザ登録
group[0] = Group.create!(
  email: "group@guest.com", 
  password: "GroupGuest01", 
  name:  "ゲスト団体",
  phone_number: "0000000000", 
  base_address: "東京都新宿区西新宿2丁目8-1", 
  url: "http://www.communiteer.co.jp/", 
  group_category: 1
)
user[0] = User.create!(
  email:    "user@guest.com",
  password: "UserGuest01",
  name:     "ゲスト"
)

membership.times do |n|
  user_name      = Gimei.kanji
  group_name     = Gimei.last.romaji
  group_address  = Gimei.address.kanji
  group_tel      = Faker::Number.number(digits: 11)
  group_url      = Faker::Internet.url
  group_category = Faker::Number.between(from: 0, to: 3)

  user[n+1] = User.create!(
    email: "user#{n + 1}@com",
    name:  Gimei.kanji,
    password: "User#{n+1}#{n+1}"
  )
  Group.create!(
    email: "group#{n + 1}@com", 
    password:"Group#{n + 1}", 
    name: "#{group_name}団体",
    phone_number: group_tel, 
    base_address: group_address, 
    url: group_url, 
    group_category: group_category
  )
end

# ボランティア投稿
title =["公園のゴミ拾いボランティア募集","被災地 応援イベントのボランティア募集!",
        "第2回 近所の大川の大掃除大会開催","マラソン大会の運営のお手伝いボランティアスタッフ募集!!",
        "なし収穫ボランティア募集","子供キャンプのお手伝いして頂けるボランティア募集中!",
        "子供達に「食の大切さを伝える」ボランティア募集","ハロウィンイベント★スタッフ募集!",
        "のんびりお散歩同行！スタッフ募集","公園で遊んでいる子供を見守ってくれるボランティアさん募集",
        "【未経験可】演劇イベントのスタッフ募集!!!","【動画撮影・編集ボランティア】街を元気に!お店をめぐります",
        "大規模合コンイベントの運営ボランティアスタッフ募集！","小学生登下校見守り隊員募集！！"]

place =["東京都品川区二葉1-4-25","熊本県人吉市",
        "神奈川県川崎市中原区小杉陣屋町２丁目２４−７", "東京都新宿区西新宿２丁目８−１",
        "千葉県白井市富塚1142-3", "神奈川県足柄下郡箱根元箱根１６４",
        "千葉県柏市若柴294-5 アークス柏の葉101","神奈川県川崎市川崎区小川町４−１",
        "京都府京都市上京区京都御苑３","東京都渋谷区代々木神園町２−１",
        "埼玉県さいたま市南区根岸１丁目７−１","北九州市小倉北区黄金1丁目1-23",
        "横浜市西区北幸1丁目4番1号","学校の通学路エリア"]

details =["当日は動きやすい格好でお越しください。ゴミ袋・手袋・トング等はこちらで準備します。",
          "詳細は参加承認後にダイレクトメールでご連絡する形となります。",
          "上流から下流までをエリア分担して実施します。",
          "詳しくは「https://〇〇」を確認してください。",
          "気になる方は募集者名をクリックしてそこからDMください!!",
          "デイキャンプの見守りとなりますので寝袋などの宿泊用品は必要ありません。",
          "実際に調理も行いますのでエプロンのご持参をよろしくお願い致します。",
          "",
          "のんびりお散歩しましょう♪",
          "水場がありますので、注意深く見ていただければ幸いです",
          "詳細の確認・ご不明点はDMにて。",
          "",
          "活動日は記載の日になりますが、1度お越ししてくれた方には今後の参加もご依頼する可能性があります。",
          "参加人数に応じてエリアの配置場所と配置人数をお伝えする形になります。なるべくご自宅から近いエリアを担当していただくようにこちらでも配慮致します。"]

expenses =["現地までの移動費は自己負担になります。", "作業後に現地に宿泊する場合は自己負担となります",
           "特に経費は必要ありません。","現地までの移動費は自己負担になります。",
           "経費は必要ありません。","デイキャンプ利用金額がかかります。",
           "調理の時間もあるため材料費の自己負担があります。※2000円","現地までの移動費は自己負担になります。",
           "特に必要ありません。","特に必要ありません。",
           "現地までの移動費は自己負担になります。","特に必要ありませんが、お店巡りで自身が飲食をする場合は自己負担となります",
           "現地までの移動費は自己負担になります。","見守り隊用の服と帽子の金額がかかります。"]
conditions = ["特に応募条件はございません。気軽にご参加いただければと思います。", "今回は肉体労働が主な作業となりますので、体力のある方・若い方に来ていただければ幸いです。",
              "近郊に住んでいる方々に参加していただきたいです。", "頑張っている方を支えたい方募集中です",
              "誰でも大歓迎です!!", "子供と遊ぶのが好き人",
              "子供に教える上で事前に配布する資料にて勉強してくれる方お願い致します。", "仮装するのOKって方募集してます",
              "のんびりお散歩を楽しめる方", "子供にしっかり注意できる方よろしくお願いします。",
              "誰でも募集してます。小道具作りなどもしますので手先が器用な方はなお歓迎!", "一緒に動画を盛り上げてくれる方、一緒に作りましょう♪",
              "当日、フォーマルな格好で来てくださる方", "どなたでも。よろしくお願いします。"]
id            = [1, 2, 3]
postable_type = ["User","Group"]

posts.times do |n|
  schedule_time  = Faker::Time.between_dates(from: Date.today + 31, to: Date.today + 60, period: :morning) 
  deadline_time  = Faker::Time.forward(days: 30, period: :evening)
  people         = Faker::Number.between(from: 5, to: 30)

  volunteer[n] = Volunteer.create!(
    title:              "#{title[n]}",
    place:              "#{place[n]}",
    details:            "#{details[n]}",
    schedule:           schedule_time,
    start_time:         schedule_time, 
    end_time:           deadline_time, 
    expenses:           "#{expenses[n]}", 
    conditions:         "#{conditions[n]}", 
    application_people: people, 
    deadline:           deadline_time,
    kind:               "Volunteer", 
    postable_id:        id.sample, 
    postable_type:      "#{postable_type.sample}"
  )
  volunteer[n].image.attach(io: File.open(Rails.root.join("app/assets/images/sample/volunteer/sample#{n}.jpg")), filename: "sample#{n}.jpg")
end


# ボランティア申し込み
# ゲストユーザ
tel     = Faker::Number.number(digits: 11)
no_post = Volunteer.where.not(postable_id: 1, postable_type: 'User')

(no_post.length / 2).times do |i|
  people = Faker::Number.between(from: 1, to: 10)
  joinvolunteer = JoinVolunteer.create!(
    name:          user[0].name,
    phone_number:  tel,
    number:        people,
    inquiry:       "",
    accept_flag:   false,
    volunteer_id:  no_post[i][:id],
    joinable:      user[0]
  )
  volunteer[i].participant_number += joinvolunteer.number
  volunteer[i].save
end

# その他ユーザ
(3..6).each do |n|
  tel      = Faker::Number.number(digits: 11)
  posts.times do |i|
    people = Faker::Number.between(from: 1, to: 10)
    joinvolunteer = JoinVolunteer.create!(
      name:          user[n].name,
      phone_number:  tel,
      number:        people,
      inquiry:       "",
      accept_flag:   false,
      volunteer_id:  "#{i+1}",
      joinable:      user[n]
    )
    volunteer[i].participant_number += joinvolunteer.number
    volunteer[i].save
  end
end

# 応援(ボランティア投稿)

# ゲストユーザ
no_post.length.times do |i|
  Cheer.create!(
    cheerable_id:    1,
    cheerable_type:  "User",
    targetable_id:   no_post[i][:id],
    targetable_type: "Volunteer"
  )
end

# その他ユーザ
(3..6).each do |n|
  posts.times do |i|
    Cheer.create!(
      cheerable:  user[n],
      targetable: volunteer[i]
    )
  end
end


my_post = Volunteer.where(postable_id: 1, postable_type: 'User')

# 通知(応援)
(3..6).each do |n|
  my_post.length.times do |i|
    notification = user[n].active_notifications.new(
      post_id:          my_post[i][:id],
      linkable:         my_post[i],
      receiveable_id:   1,
      receiveable_type: "User",
      action:           "cheer"
    )
    notification.save!
  end
end

# 通知(ボランティア参加)
(3..6).each do |n|
  my_post.length.times do |i|
    join = JoinVolunteer.find_by(volunteer_id: my_post[i][:id], joinable_id: user[n].id)
    notification = user[n].active_notifications.new(
      post_id:          my_post[i][:id],
      linkable:         join,
      receiveable_id:   1,
      receiveable_type: "User",
      action:           "join_volunteer"
    )
    notification.save!
  end
end
