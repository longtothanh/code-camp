class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id]) # Tìm sách theo ID được truyền trong params
    @reviews = @book.reviews # Lấy tất cả reviews cho sách này
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      flash[:notice] = 'Book was successfully created.'
      redirect_to root_path
    else
      flash[:alert] = 'Book was failed to be created.'
      render :new
    end
  end

  def new
    @book = Book.new
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash.now[:danger] = "Delete book successfully!"
    redirect_to root_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :content)
  end
end
