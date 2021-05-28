class BooksController < ApplicationController
  require 'pdf/reader'
  require 'RMagick'

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @content = @book.content if @book.content.attached?
  end

  def create
    book = Book.new(book_params)
    # Save PDF
    book.content.attach(params[:book][:content])
    # Extract first page as thumbnail
    pdf_images = Magick::ImageList.new(File.open(params[:book][:content]))
    first_page = pdf_images.first
    filename = params[:book][:content].original_filename.gsub('.pdf', '.jpeg')
    # thumb = first_page.write(Rails.root.join('app', 'assets', 'images', filename))
    book.thumbnail.attach(io: StringIO.new(first_page.to_s), filename: filename)

    if book.save
      redirect_to book_path(book)
    else
      render :new
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      redirect_to books_path
    else
      render :show
    end
  end

  def reader
    @book = Book.find(params[:book_id])
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :content)
  end
end
