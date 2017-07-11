
class Api::V1::BaseController < ApplicationController
  before_action :retrieve_source_model_by_id, only: [:edit, :update, :destroy, :show]

  def create
    @source_model = source_klass.new(send("#{controller_name.singularize}_params"))

    unless @source_model.save
      render status: 400, json: @source_model.errors
    end
  end

  def update
    unless @source_model.update(send("#{controller_name.singularize}_params"))
      render status: 400, json: @source_model.errors
    end
  end

  def destroy
    unless @source_model.destroy
      render status: 400, json: @source_model.errors
    end
  end

  private

  def source_path
    send("api_v1#{controller_name.singularize}_path")
  end

  def sources_path
    send("api_v1_#{controller_name}_path")
  end

  def source_klass
    controller_name.singularize.classify.constantize
  end

  def retrieve_source_model_by_id
    @source_model = controller_name.singularize.classify.constantize.find(params[:id])
  end
end
