class BooksController < ApplicationController
  require 'pdf/reader'
  include Rails.application.routes.url_helpers

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
    book.content.attach(params[:book][:content])
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
