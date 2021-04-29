# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Group.create!(
  email: "group@guest.com", 
  password:"GroupGuest01", 
  name: "ゲスト団体",
  phone_number: "0000000000", 
  base_address: "東京都新宿区西新宿2丁目8-1}", 
  url: "http://www.communiteer.co.jp/", 
  group_category: 1
)
2.times do |n|
  User.create!(
    email: "user#{n + 1}@com",
    nickname: "テストユーザー#{n + 1}",
    password: "User#{n+1}#{n+1}"
  )
  Group.create!(
    email: "group#{n + 1}@com", 
    password:"Group#{n + 1}", 
    name: "テスト団体#{n + 1}",
    phone_number: "#{n + 1}120123456", 
    base_address: "東京都#{n + 1}", 
    url: "http://www.communiteer#{n + 1}.co.jp/", 
    group_category: 1
  )
end

10.times do |n|
  Volunteer.create!(
    title: "団体テスト投稿#{n + 1}", 
    place: "不明", 
    details:"#{n + 1}", 
    schedule:"2022-04-16", 
    start_time:"18:18:00", 
    end_time:"20:18:00", 
    expenses:"#{n + 1}", 
    conditions:"#{n + 1}", 
    application_people: "#{n + 1}", 
    deadline: "2022-04-10",
    postable_id: "#{1}", 
    postable_type:"Group"
  )
end