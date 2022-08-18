# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Tag.create([
  { tag_name: 'ゴルフ場' },
  { tag_name: 'アドバイス' },
  { tag_name: '雑談' },
  { tag_name: 'グッズ' },
  { tag_name: '初心者' },
  { tag_name: 'ゴルフ好き' },
  { tag_name: '練習' }
])
