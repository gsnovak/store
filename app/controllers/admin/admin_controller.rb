module Admin
  class AdminController < ApplicationController
    load_and_authorize_resource

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to products_path
    end

    before_action :retrieve_source_model_by_id, only: [:edit, :update, :destroy, :show]
    layout 'admin/application'

    def index
      @source_models = source_klass.all
    end

    def new
      @source_model = source_klass.new
    end

    def create
      @source_model = source_klass.new(send("#{controller_name.singularize}_params"))

      if @source_model.save
        redirect_to sources_path
      else
        render 'edit'
      end
    end

    def update
      if @source_model.update(send("#{controller_name.singularize}_params"))
        redirect_to sources_path
      else
        render 'edit'
      end
    end

    def destroy
      @source_model.destroy
      redirect_to sources_path
    end

    private

    def source_path
      send("admin_#{controller_name.singularize}_path")
    end

    def sources_path
      send("admin_#{controller_name}_path")
    end

    def source_klass
      controller_name.singularize.classify.constantize
    end

    def retrieve_source_model_by_id
      @source_model = controller_name.singularize.classify.constantize.find(params[:id])
    end
  end
end
