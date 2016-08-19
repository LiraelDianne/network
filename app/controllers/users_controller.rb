class UsersController < ApplicationController
  before_action :require_login, except: [:root, :main, :create, :login]

  def root
    redirect_to action: 'main'
  end

  def main
    @user = User.new
  end

  def login
    user = User.find_by email: params[:user][:email]
    unless user && user.authenticate(params[:user][:password])
      flash[:login_error] = "Invalid email and password combination."
      redirect_to action: 'main'
    else
      session[:user_id] = user.id
      redirect_to action: 'profile'
    end
  end

  def logout
    session.destroy
    redirect_to action: 'main'
  end

  def index
    @user = User.find(session[:user_id])
    friends = @user.friends.ids
    inviters = @user.inviters.ids
    invitees = User.joins(:invites).where(invites: {inviter: @user}).ids
    eliminated = friends.concat(inviters).concat(invitees).push(@user.id)
    puts "All eliminated ids:"
    puts eliminated
    puts 
    @users = User.where.not(id: eliminated)
    # get the users that are not self, in user's networks or invitations
  end

  def create
    @user = User.new(user_params)
    if @user.valid? 
      @user.save
      session[:user_id] = @user.id
      redirect_to action: 'profile'
    else 
      flash[:errors] = @user.errors.full_messages
      redirect_to action: 'main'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(params[:id])
    unless @user.update(user_params)
      flash[:errors] = @user.errors.full_messages
    end
    redirect_to action: 'profile'
  end

  private 
  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :description)
  end
end
