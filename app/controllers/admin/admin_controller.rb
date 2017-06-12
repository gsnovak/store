module Admin
  class AdminController < ApplicationController
    before_action :authorized?

    def index
      @source_models = source_model.all
    end

    def new
      @source_model = source_model.new
    end

    def create
      @source_model = source_model.new(send("#{generate_source_str_s}_params"))

      if @source_model.save
        redirect_to send("admin_#{generate_source_str_p}_path")
      else
        render 'new'
      end
    end

    def show
    end

    def edit
    end

    def update
      if @source_model.update(send("admin_#{generate_source_str_s}_path"))
        redirect_to send("admin_#{generate_source_str_p}_path")
      else
        render 'edit'
      end
    end

    def destroy
      @source_model.destroy

      redirect_to send("admin_#{generate_source_str_p}_path")
    end

    private

    def authorized?
      if current_user.nil? or !current_user.admin?
        flash[:error] = "You are not authorized to view that page."
        redirect_to '/'
      end
    end

    def generate_source_str_s
      controller_name.singularize
    end

    def generate_source_str_p
      controller_name
    end

    def source_model
      controller_name.singularize.classify.constantize
    end
  end
end
