# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# u = User.new
# u.email = "admin@test.com"
# u.password = "123456"
# u.password_confirmation = "123456"
# u.is_admin = true
# u.save!

Product.create!(title: "蚂蚁Z9 mini 10K", description: "详细参数： 额定算力：40.8k sol/s 5% 墙上功耗：1150W 10% 外箱尺寸：226毫米（L）*132毫米（W）*2...", quantity: 20, price: 30000, image: "http://phibytcrq.bkt.clouddn.com/z9%20mini%2010K.jpg")
Product.create!(title: "芯动A9", description: "详细参数： 芯动A9矿机规格参数： 哈 希 率：50ksol / s +/- 6％ 功 耗：620W +/- 5％ （正常模式，墙...", quantity: 20, price: 30000, image: "http://phibytcrq.bkt.clouddn.com/A9.jpg")
Product.create!(title: "蚂蚁矿机 S9j 14.5T", description: "详细参数： 蚂蚁矿机S9i14T规格参数： 1.额定算力：14TH / s 5％ 2.墙上功耗：1320W+10%（比特大陆...", quantity: 20, price: 30000, image: "http://phibytcrq.bkt.clouddn.com/s9j.jpg")
Product.create!(title: "芯动T2turbo—24T", description: "详细参数： 芯动T2T矿机规格参数： 算 法: SHA256 币 种: BTC/BCH 额定算力 : 24TH/S5% 墙上功耗: 198...", quantity: 20, price: 30000, image: "http://phibytcrq.bkt.clouddn.com/24t.jpg")
