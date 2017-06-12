module Admin
  class UsersController < AdminController
    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

    def create
      retreive_user_by_id
      redirect_to admin_users_path
    end

    def show
      retreive_user_by_id
    end

    def edit
      retreive_user_by_id
    end

    def update
      retreive_user_by_id

      if @user.update(user_params)
        redirect_to @user
      else
        render 'edit'
      end
    end

    def destroy
      retreive_user_by_id
      @user.destroy

      redirect_to users_path
    end

    private
      def retreive_user_by_id
        @user = User.find(params[:id])
      end

    private
      def user_params
        params.require(:user).permit(:user_name, :email)
      end
  end
end
