require 'faker'

Group.create!(
  email: "group@guest.com", 
  password: "GroupGuest01", 
  name:  "ゲスト団体",
  phone_number: "0000000000", 
  base_address: "東京都新宿区西新宿2丁目8-1", 
  url: "http://www.communiteer.co.jp/", 
  group_category: 1
)
User.create!(
  email:    "user@guest.com",
  password: "UserGuest01",
  name:     "ゲスト"
)

2.times do |n|
  user_name      = Gimei.kanji
  group_address  = Gimei.address.kanji
  group_tel      = Faker::Number.number(digits: 11)
  group_url      = Faker::Internet.url
  group_category = Faker::Number.between(from: 0, to: 3)

  User.create!(
    email: "user#{n + 1}@com",
    name:  user_name,
    password: "User#{n+1}#{n+1}"
  )
  Group.create!(
    email: "group#{n + 1}@com", 
    password:"Group#{n + 1}", 
    name: "テスト団体#{n + 1}",
    phone_number: group_tel, 
    base_address: group_address, 
    url: group_url, 
    group_category: group_category
  )
end

title =["被災地 応援イベントのボランティア募集！",
        "第2回 近所の大川の大掃除大会開催","マラソン大会の運営のお手伝いボランティアスタッフ募集!!",
        "なし収穫ボランティア募集","子供キャンプのお手伝いして頂けるボランティア募集中！",
        "子供達に「食の大切さを伝える」ボランティア募集","ハロウィンイベント★スタッフ募集!",
        "のんびりお散歩同行！スタッフ募集","公園で遊んでいる子供を見守ってくれるボランティアさん募集"]
postable_type = ["User","Group"]

volunteer = Volunteer.create!(
  title: "地域のゴミ拾いボランティア募集", 
  place: "近所", 
  details:"ゴミ袋・手袋・トングはこちらで用意します", 
  schedule:"2022-04-16", 
  start_time:"18:18:00", 
  end_time:"20:18:00", 
  expenses:"現地までの移動費", 
  conditions:"特になし", 
  application_people: "20", 
  deadline: "2022-04-10",
  postable_id: "1", 
  postable_type:"Group"
)
volunteer.image.attach(io: File.open(Rails.root.join("app/assets/images/sample/no_image.jpg")), filename: "no_image.jpg")

9.times do |n|
  schedule_time  = Faker::Time.between_dates(from: Date.today + 31, to: Date.today + 60, period: :day) 
  deadline_time  = Faker::Time.forward(days: 30, period: :night)
  place          = Gimei.address.kanji
  people         = Faker::Number.between(from: 1, to: 30)
  id             = Faker::Number.between(from: 1, to: 3)
  
  volunteer = Volunteer.create!(
    title:              title[n],
    place:              place, 
    details:            "#{n + 1}", 
    schedule:           schedule_time , 
    start_time:         schedule_time , 
    end_time:           deadline_time, 
    expenses:           "#{n + 1}", 
    conditions:         "#{n + 1}", 
    application_people: people, 
    deadline:           deadline_time,
    postable_id:        id, 
    postable_type:      postable_type.sample
  )
  volunteer.image.attach(io: File.open(Rails.root.join("app/assets/images/sample/volunteer/sample#{n+1}.jpg")), filename: "sample#{n}.jpg")
end