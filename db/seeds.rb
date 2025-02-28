# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'

puts "Cleaning database..."
Article.destroy_all
puts "Database clean!"

# turn photo_urls into an array
articles = [
  {
    title: "The Great Döner Debate",
    body: "After three years in Berlin, I’m still trying to decide which Döner shop is the best. The neighborhood loyalty runs deep, but let's be honest—it's all about who gives you extra garlic sauce without judgment.",
    photo_urls: ["https://plus.unsplash.com/premium_photo-1723921226499-9309781ff0f3?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", "https://images.unsplash.com/photo-1561760041-ca62af0d9047?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"]
  },
  {
    title: "Biking Through Berlin: An Extreme Sport",
    body: "Today I narrowly avoided three pedestrians, a tram, and an angry schnauzer while biking through Kreuzberg. I might need hazard pay for every trip I take. Or at least a medal for bravery.",
    photo_urls: ["https://images.unsplash.com/photo-1526321391769-26f7321e469d?q=80&w=2948&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"]
  },
  {
    title: "Why Does My Coffee Take So Long?",
    body: "Berlin baristas seem to take \"slow living\" very seriously. I ordered an oat milk flat white at 9am, and by the time I got it, I had time to reconsider all my life choices. Worth the wait? Maybe.",
    photo_urls: ["https://images.unsplash.com/photo-1453614512568-c4024d13c247?q=80&w=2832&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"]
  },
  {
    title: "Club Queuing: Berlin’s Ultimate Endurance Test",
    body: "It’s 3am, and I’m still in line. Someone's playing techno on a Bluetooth speaker, and I’ve made three new friends. Will I get into Berghain? No. But at least I’ll have a story to tell.",
    photo_urls: ["https://images.unsplash.com/photo-1546589643-b2e969dca58b?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"]
  },
  {
    title: "Lost in Translation: My German Language Struggles",
    body: "I thought I ordered a \"small\" beer. Turns out, in Berlin, there’s no such thing. I now have a liter of Pilsner, a raised eyebrow from the bartender, and no idea what I’m supposed to do with this.",
    photo_urls: ["https://images.unsplash.com/photo-1654939802358-5decf93d9bc2?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"]
  }
]

# change name of each article to avoid confusion
articles.each do |article_info|
  article = Article.new(title: article_info[:title], body: article_info[:body])
  # iterate over each hash's photo_urls
  article_info[:photo_urls].each do |url|
    file = URI.parse(url).open
    # attach each one as photos
    article.photos.attach(io: file, filename: "#{url}.png", content_type: "image/png")
  end
  article.save!
  puts "Created #{article.title}!"
end
