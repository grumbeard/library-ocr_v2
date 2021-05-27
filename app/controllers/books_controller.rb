class BooksController < ApplicationController
  require 'pdf/reader'

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @content = @book.content if @book.content.attached?
  end

  def create
    book = Book.new(book_params)
    book.content.attach(params[:content])
    if book.content
      book.parse_pdf(book, book.content)
      if book.save
        redirect_to book_path(book)
      else
        render :new
      end
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

  def parse_pdf(book, pdf)
    # Create Text version of book
    book.text = ''

    PDF::Reader.open(pdf) do |reader|
      reader.pages.each do |page|
        book.text << page.text
      end
    end
  end

  def book_params
    params.require(:book).permit(:title, :content)
  end
end
