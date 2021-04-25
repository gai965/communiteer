# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'user1@com', password:'User11', nickname: 'テストユーザー')
Group.create(email: 'group1@com', password:'Group1', name: 'こみんてぃあ学園', phone_number: '0120123456', base_address: '東京都', url: 'http://www.communiteer.co.jp/' , group_category: 1)