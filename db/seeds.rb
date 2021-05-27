# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Book.destroy_all
puts 'Destroyed all books'

puts 'Creating Book'
pdf_prefix = Rails.root.join('app', 'assets', 'documents')
book = Book.new(
  title: 'Lorem Tales'
)
book.content.attach(io: File.open(pdf_prefix.join('sample_book.pdf')), filename: 'sample_book.pdf', content_type: 'application/pdf')
if book.save
  puts book.content
  puts 'Lorem Tales created'
else
  puts 'Failed to create Lorem Tales'
end
