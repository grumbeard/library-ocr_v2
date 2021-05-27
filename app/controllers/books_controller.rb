class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @content = @book.content if @book.content.attached?
  end

  def create
    book = Book.new(book_params)
    if book.save
      book.content.attach(params[:content])
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

  private

  def book_params
    params.require(:book).permit(:title, :content)
  end
end
