class Book < ApplicationRecord
  after_commit :parse_pdf
  has_one_attached :content

  private

  def parse_pdf
    return if text_previously_changed?

    tmp_text = ''

    content.open do |file|
      reader = PDF::Reader.new(file)
      reader.pages.each do |page|
        tmp_text << page.text
      end
    end
    update! text: tmp_text
  end
end
