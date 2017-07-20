class Api::V1::BaseController < ApplicationController
  load_and_authorize_resource
  before_action :retrieve_source_model_by_id, only: [:edit, :update, :destroy, :show]

  def create
    @source_model = source_klass.new(send("#{controller_name.singularize}_params"))

    if @source_model.save
      render status: 200, json: @source_model
    else
      render status: 400, json: @source_model.errors.full_messages
    end
  end

  def update
    if @source_model.update(send("#{controller_name.singularize}_params")) && @source_model.errors.empty?
      render status: 200, json: @source_model
    else
      render status: 400, json: @source_model.errors.full_messages
    end
  end

  def destroy
    if @source_model.destroy
      render status: 200, json: @source_model
    else
      render status: 400, json: @source_model.errors.full_messages
    end
  end

  private

  def source_klass
    controller_name.singularize.classify.constantize
  end

  def retrieve_source_model_by_id
    @source_model = controller_name.singularize.classify.constantize.find(params[:id])
  end
end