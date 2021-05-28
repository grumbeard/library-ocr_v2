class Book < ApplicationRecord
  require 'rmagick'

  after_commit :parse_pdf
  # after_commit :create_thumbnail
  has_one_attached :content
  has_one_attached :thumbnail

  private

  def parse_pdf
    return if text_previously_changed? || destroyed?

    tmp_text = ''

    content.open do |file|
      reader = PDF::Reader.new(file)
      reader.pages.each do |page|
        tmp_text << page.text
      end
    end
    update! text: tmp_text unless destroyed?
  end

  # def create_thumbnail
  #   return if thumbnail_previously_changed?

  #   pdf = Magick::ImageList.new(url_for(content))
  #   thumb = pdf.first
  #   thumbnail.attach(io: thumb, filename: 'sample_book.pdf', content_type: 'application/pdf')
  # end
end
