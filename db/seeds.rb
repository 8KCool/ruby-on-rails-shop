# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# def time_point_string
#   Time.now.strftime("%H:%M:%S:%L")
# end

# def seedfile(fname)
#   File.open File.join(Rails.root, "public/content/seeds/", fname)
# end

# puts "#{time_point_string}: Start seeding"

# # Use code of file 'db/seeds_more.rb'. This is way to split big seeds.rb file.
# # You can use instance variables (@something) declared in that file.
# require_relative 'seeds_more'

# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --
# puts "#{time_point_string}: seed Static Files"
# = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = - = --

# sig = StaticFile.new
# sig.file = seedfile "example_pic.jpg"
# sig.save

# puts "#{time_point_string}: Seeding is done!"

NavItem.create!([
  { title: "JACKETS", url_type: 0, url_text: "#" },
  { title: "SWEATERS", url_type: 0, url_text: "#" },
  { title: "DRESSES", url_type: 0, url_text: "#" },
  { title: "SKIRTS", url_type: 0, url_text: "#" },
  { title: "PANTS", url_type: 0, url_text: "#" },
  { title: "SHORTS", url_type: 0, url_text: "#" },
  { title: "SHOES", url_type: 0, url_text: "#" },
  { title: "ACCESSORIES", url_type: 0, url_text: "#" }
])

Category.create!([
  { name: "JACKETS" },
  { name: "SWEATERS" },
  { name: "DRESSES" },
  { name: "SKIRTS" },
  { name: "PANTS" },
  { name: "SHORTS" },
  { name: "SHOES" },
  { name: "ACCESSORIES" }
])

30.times { |i| Product.create!([ { name: "product example#{i}", price: 450.07, count: 300, category_id: 7 } ]) }
