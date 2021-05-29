# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'pdf/reader'

Book.destroy_all
puts 'Destroyed all books'

puts 'Creating Book'
pdf_prefix = Rails.root.join('app', 'assets', 'documents')

adjectives = [
  "different",
  "useful",
  "old",
  "healthy",
  "electrical",
  "expensive",
  "intelligent",
  "interesting",
  "happy",
  "wonderful",
  "competivie",
  "environmental",
  "powerful",
  "unusual",
  "cultural",
  "scared",
  "aggressive",
  "boring",
  "amazing",
  "poor"
]

nouns = [
  "bird",
  "work",
  "story",
  "color"
]

filenames = [ "sample_book.pdf", "sample_book_long.pdf" ]

(1..24).each do
  book = Book.new(
    title: "#{adjectives[rand(0..19)]} #{nouns[rand(0..3)]}"
  )
  book.content.attach(io: File.open(pdf_prefix.join(filenames[rand(0..1)])), filename: 'sample_book.pdf', content_type: 'application/pdf')
  if book.content

    # Create Text version of book
    book.text = []

    PDF::Reader.open(pdf_prefix.join('sample_book.pdf')) do |reader|
      reader.pages.each do |page|
        book.text << page.text
      end
    end

    if book.save
      puts "#{book.title} created"
    else
      puts 'Failed to create Lorem Tales'
    end
  else
    puts 'Failed to create Lorem Tales'
  end
end
