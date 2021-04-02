class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @books_test = Book.all 
    @books = @user.books
    @book = Book.new
    @book.user_id = current_user
    
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
    @book.user_id = current_user.id
  end

  def edit
    @user = User.find(params[:id])
    if params[:id] == current_user.id
     @user = User.find(params[:id])
    render action: :edit
    else
     @user = current_user
    render action: :show
    end
    @books_test = Book.all 
    @books = @user.books
    @book = Book.new
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def book_params
    params.require(:book).permit(:title,:body)
  end
  

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  
end
