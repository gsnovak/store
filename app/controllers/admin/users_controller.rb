module Admin
  class UsersController < AdminController

    private

    def user_params
      params.require(:user).permit(:user_name, :email)
    end
  end
end
