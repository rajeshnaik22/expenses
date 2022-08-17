class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

  before_action :set_breadcrumbs

  def index 
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page params[:page]
  end

  def show
    breadcrumbs << @user.email
    #Resque.enqueue(TestWorker, 1)
  end

  def update
    respond_to do |format|
      puts @user
      if @user.update(user_params)
        Resque.enqueue(CreateThumbnailWorker, @user.id)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_user
    @user = User.find params["id"]
  end

  def set_breadcrumbs
    add_initial_breadcrumbs
    breadcrumbs.add "Users", users_path, class: "breadcrumb-item"
  end

  def user_params
    params.require(:user).permit(:email, :picture, role_ids: [])
  end

end
