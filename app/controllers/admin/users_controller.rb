module Admin
  class UsersController < AdminController
    before_action :retreive_user_by_id, only: [:create, :edit, :update, :destroy]

    private

    def retreive_user_by_id
      @source_model = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:user_name, :email)
    end
  end
end
