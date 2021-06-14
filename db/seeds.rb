require 'faker'

membership = 2

# ユーザ登録
group = Group.create!(
  email: "group@guest.com", 
  password: "GroupGuest01", 
  name:  "ゲスト団体",
  phone_number: "0000000000", 
  base_address: "東京都新宿区西新宿2丁目8-1", 
  url: "http://www.communiteer.co.jp/", 
  group_category: 1
)
user = User.create!(
  email:    "user@guest.com",
  password: "UserGuest01",
  name:     "ゲスト"
)

membership.times do |n|
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
    name: "団体テスト#{n + 1}",
    phone_number: group_tel, 
    base_address: group_address, 
    url: group_url, 
    group_category: group_category
  )
end

# ボランティア投稿
title =["地域のゴミ拾いボランティア募集",
        "被災地 応援イベントのボランティア募集!"              ,"第2回 近所の大川の大掃除大会開催",
        "マラソン大会の運営のお手伝いボランティアスタッフ募集!!" ,"なし収穫ボランティア募集",
        "子供キャンプのお手伝いして頂けるボランティア募集中!"   ,"子供達に「食の大切さを伝える」ボランティア募集",
        "ハロウィンイベント★スタッフ募集!"                   ,"のんびりお散歩同行！スタッフ募集",
        "公園で遊んでいる子供を見守ってくれるボランティアさん募集","【未経験可】演劇イベントのスタッフ募集!!!",
        "【動画撮影・編集ボランティア】街を元気に!お店をめぐります","大規模合コンイベントの運営ボランティアスタッフ募集！"]
postable_type = ["User","Group"]
id            = [1, 2, 3]
group_volunteer = []


7.times do |n|
  schedule_time  = Faker::Time.between_dates(from: Date.today + 31, to: Date.today + 60, period: :day) 
  deadline_time  = Faker::Time.forward(days: 30, period: :night)
  place          = Gimei.address.kanji
  people         = Faker::Number.between(from: 1, to: 30)

  group_volunteer[n] = Volunteer.create!(
    title:              title[n],
    place:              place, 
    details:            "#{n + 1}", 
    schedule:           schedule_time , 
    start_time:         schedule_time , 
    end_time:           deadline_time, 
    expenses:           "現地までの移動費", 
    conditions:         "特になし", 
    application_people: people, 
    deadline:           deadline_time,
    postable_id:        "1", 
    postable_type:      "Group"
  )

  volunteer = Volunteer.create!(
    title:              title[12 - n],
    place:              place, 
    details:            "#{12 - n}", 
    schedule:           schedule_time , 
    start_time:         schedule_time , 
    end_time:           deadline_time, 
    expenses:           "#{12 - n}", 
    conditions:         "#{12 - n}", 
    application_people: people, 
    deadline:           deadline_time,
    postable_id:        id.sample, 
    postable_type:      postable_type.sample
  )
  group_volunteer[n].image.attach(io: File.open(Rails.root.join("app/assets/images/sample/volunteer/sample#{n}.jpg")), filename: "sample#{n}.jpg")
  volunteer.image.attach(io: File.open(Rails.root.join("app/assets/images/sample/volunteer/sample#{12 - n}.jpg")), filename: "sample#{12 - n}.jpg")
end

# 応援(ボランティア投稿)
# (membership+1).times do |n|
#   3.times do |i|
#     Cheer.create!(
#       cheerable_id:    "#{n+1}",
#       cheerable_type:  postable_type[0],
#       targetable_id:   "#{i+1}",
#       targetable_type: "Volunteer"
#     )
#   end
# end

# 通知(応援)
# 7.times do |n|
#   notification = user.active_notifications.new(
#     post_id:          group_volunteer[n].id,
#     linkable:         group_volunteer[n],
#     receiveable_id:   "1",
#     receiveable_type: "Group",
#     action:           "cheer"
#   )
#   notification.save!
# end