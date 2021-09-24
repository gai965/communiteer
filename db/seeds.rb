require 'faker'

membership = 6
posts      = 4
user       = []
group       = []

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

# membership.times do |n|
#   user_name      = Gimei.kanji
#   group_address  = Gimei.address.kanji
#   group_tel      = Faker::Number.number(digits: 11)
#   group_url      = Faker::Internet.url
#   # group_category = Faker::Number.between(from: 0, to: 3)

#   user[n+1] = User.create!(
#     email: "user#{n + 1}@com",
#     name:  user_name,
#     password: "User#{n+1}#{n+1}"
#   )
#   Group.create!(
#     email: "group#{n + 1}@com", 
#     password:"Group#{n + 1}", 
#     name: "団体テスト#{n + 1}",
#     phone_number: group_tel, 
#     base_address: group_address, 
#     url: group_url, 
#     group_category: 1
#   )
# end

# ボランティア投稿
title =["公園のゴミ拾いボランティア募集",
        "被災地 応援イベントのボランティア募集!"              ,"第2回 近所の大川の大掃除大会開催",
        "マラソン大会の運営のお手伝いボランティアスタッフ募集!!" ,"なし収穫ボランティア募集",
        "子供キャンプのお手伝いして頂けるボランティア募集中!"   ,"子供達に「食の大切さを伝える」ボランティア募集",
        "ハロウィンイベント★スタッフ募集!"                   ,"のんびりお散歩同行！スタッフ募集",
        "公園で遊んでいる子供を見守ってくれるボランティアさん募集","【未経験可】演劇イベントのスタッフ募集!!!",
        "【動画撮影・編集ボランティア】街を元気に!お店をめぐります","大規模合コンイベントの運営ボランティアスタッフ募集！"]
place =["東京都品川区二葉1-4-25", "熊本県人吉市",
        "神奈川県川崎市中原区小杉陣屋町２丁目２４−７", "テスト投稿4"]
# postable_type = ["User","Group"]
# id            = [1, 2, 3]
# group_volunteer = []

posts.times do |n|
  postable_type = ["User","Group"]
  schedule_time2  = Faker::Time.between_dates(from: Date.today + 31, to: Date.today + 60, period: :day) 
  deadline_time2  = Faker::Time.forward(days: 30, period: :night)

  volunteer = Volunteer.create!(
    title:              "#{title[n]}",
    place:              "#{place[n]}",
    details:            "0", 
    schedule:           schedule_time2,
    start_time:         schedule_time2, 
    end_time:           deadline_time2, 
    expenses:           "0", 
    conditions:         "0", 
    application_people: 1, 
    deadline:           deadline_time2,
    kind:               "Volunteer", 
    postable_id:        1, 
    postable_type:      "#{postable_type[n % 2]}"
    # postable_type:      "User"
  )
  volunteer.image.attach(io: File.open(Rails.root.join("app/assets/images/sample/volunteer/sample#{n}.jpg")), filename: "sample#{n}.jpg")
end



# posts.times do |n|
#   schedule_time1  = Faker::Time.between_dates(from: Date.today + 31, to: Date.today + 60, period: :day) 
#   schedule_time2  = Faker::Time.between_dates(from: Date.today + 31, to: Date.today + 60, period: :day) 
#   deadline_time1  = Faker::Time.forward(days: 30, period: :night)
#   deadline_time2  = Faker::Time.forward(days: 30, period: :night)
#   place1          = Gimei.address.kanji
#   place2          = Gimei.address.kanji
#   people          = Faker::Number.between(from: 1, to: 30)

#   group_volunteer[n] = Volunteer.create!(
#     title:              "#{title[n]}",
#     place:              "#{place1}", 
#     details:            "#{n + 1}", 
#     schedule:           schedule_time1, 
#     start_time:         schedule_time1, 
#     end_time:           deadline_time1, 
#     expenses:           "現地までの移動費", 
#     conditions:         "特になし", 
#     application_people: people, 
#     deadline:           deadline_time1,
#     postable_id:        "1", 
#     postable_type:      "Group"
#   )

#   volunteer = Volunteer.create!(
#     title:              "#{title[12 - n]}",
#     place:              "#{place2}", 
#     details:            "#{12 - n}", 
#     schedule:           schedule_time2 , 
#     start_time:         schedule_time2 , 
#     end_time:           deadline_time2, 
#     expenses:           "#{12 - n}", 
#     conditions:         "#{12 - n}", 
#     application_people: people, 
#     deadline:           deadline_time2,
#     postable_id:        id.sample, 
#     postable_type:      "#{postable_type.sample}"
#   )
#   group_volunteer[n].image.attach(io: File.open(Rails.root.join("app/assets/images/sample/volunteer/sample#{n}.jpg")), filename: "sample#{n}.jpg")
#   volunteer.image.attach(io: File.open(Rails.root.join("app/assets/images/sample/volunteer/sample#{12 - n}.jpg")), filename: "sample#{12 - n}.jpg")
# end

# ボランティア申し込み
  tel    = Faker::Number.number(digits: 11)
  people = Faker::Number.between(from: 1, to: 30)
  inquiry= Faker::Number.number(digits: 100)
  joinvolunteer = JoinVolunteer.create!(
    name:          user[0].name,
    phone_number:  tel,
    number:        people,
    inquiry:       inquiry,
    accept_flag:   false,
    volunteer_id:  2,
    joinable:      user[0]
  )

# ボランティア申し込み
# (membership+1).times do |n|
#   tel      = Faker::Number.number(digits: 11)
#   posts.times do |i|
#     people = Faker::Number.between(from: 1, to: 30)
#     inquiry= Faker::Number.number(digits: 100)
#     joinvolunteer = JoinVolunteer.create!(
#       name:          user[n].name,
#       phone_number:  tel,
#       number:        people,
#       inquiry:       inquiry,
#       accept_flag:   false,
#       volunteer_id:  "#{2*i+1}",
#       joinable:      user[n]
#     )
#     group_volunteer[i].participant_number += joinvolunteer.number
#     group_volunteer[i].save
#   end
# end

# 応援(ボランティア投稿)
# (membership+1).times do |n|
#   posts.times do |i|
#     Cheer.create!(
#       cheerable_id:    "#{n+1}",
#       cheerable_type:  postable_type[0],
#       targetable_id:   "#{2*i+1}",
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
