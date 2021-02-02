class UsersController < ApplicationController
  
  def index
    @users = User.all
    # 投稿用
    @user_book = current_user.books.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    # 投稿用
    @user_book = current_user.books.new
  end
  
  # 投稿用
  def create
    @user_book = Book.new(userbook_params)
    @user_book.user_id = current_user.id
    if @user_book.save
      flash[:notice] = "successfully!"
      redirect_to book_path(@user_book)
    else
      flash[:notice] = "error!"
      render 'books/index'
    end    
  end
  
  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:notice] = "権限がありません"
      redirect_to user_path(current_user)
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "successfully!"
      redirect_to user_path(current_user.id)
    else
      render :edit
    end  
  end
  
  # ユーザーデータのストロングパラメータ
  private
  
  def userbook_params
    params.require(:book).permit(:title, :body)
  end
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end
