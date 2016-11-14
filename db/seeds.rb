# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'random_data'

#Create Posts
50.times do
  #Adding a ! to the method instructs it raise an error if there's the problem with the data we're seeding.
  Post.create!(
  #Initially here, we referenced a class that doesn't exist.  This is wishful coding but ok.  :)
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )
end

posts = Post.all

#Create comments
#using an integer on .times will make sure this thing will run x times.
100.times do
  Comment.create!(
    # call sample on the array returned by Post.all in order to pick a random post to associate with each comment.
    post: posts.sample,
    body: RandomData.random_paragraph
  )
end

#Assignment 17 code
puts "#{Post.count}"
Post.find_or_create_by(
  title: "New unique post title",
  body: "New unique post body"
)
puts "#{Post.count}"

post = Post.find_by_title("New unique post title")

puts "#{Comment.count}"

Comment.find_or_create_by(
  post: post,
  body: "New unique comment body"
)

puts "#{Comment.count}"

puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"

puts Post.all
