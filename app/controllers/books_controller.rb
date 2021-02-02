class BooksController < ApplicationController
  
  def index
    @book = Book.new
    @books = Book.all
  end
  
  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    # 投稿を行ったuserのデータ表示用
    @book_user = @book.user
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "successfully!"
      redirect_to book_path(@book)
    else
      flash[:notice] = "error!"
      @books = Book.all
      render :index
    end  
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "successfully!"
      redirect_to book_path(@book)
    else
      flash[:notice] = "error!"
      render :edit
    end  
  end
  
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "successfully!"
    redirect_to books_path
  end
  
  # 投稿データのストロングパラメータ
  private
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
