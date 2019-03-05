class UsersController < ApplicationController
  #skip_before_action :authorize ,only: [:new , :create]
  before_action :redirect_unless_admin, except: [:home]
  before_action :set_user, only: [:home,:show, :edit, :update, :destroy]

  def home

  end
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      if @user.save
        UserMailer.registration_confirmation(@user).deliver
        flash[:success] = "Please confirm your email address to continue"
        redirect_to login_url
      else
        flash[:error] = "Ooooppss, something went wrong!"
        render 'new'
      end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to home_user_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
def confirm_email
  user = User.find_by_confirm_token(params[:id])
  if user
    user.email_activate
    flash[:success]= "Welcome to the chatroom! Your email has been confirmed.
      Please sign in to continue."
      redirect_to login_path
  else
          flash[:error] = "Sorry. User does not exist"
      redirect_to root_url
  end
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user || User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :fname, :lname, :email, :password)
    end
end
