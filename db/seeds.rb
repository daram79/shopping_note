# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User.create(email: "shimtong1004@gmail.com", nick: "admin", birthday: "1979-08-15", password: 'ejrdud1004', password_confirmation: 'ejrdud1004')
#User.create(email: "mayin1q84@gmail.com", nick: "admin2", birthday: "1979-07-26", password: 'ejrdud1004', password_confirmation: 'ejrdud1004')
FeedType.create(name: "공개")
FeedType.create(name: "친구공개")
FeedType.create(name: "비공개")
