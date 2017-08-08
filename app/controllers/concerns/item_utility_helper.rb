module ItemUtilityHelper
  extend ActiveSupport::Concern

  def index
    @source_models = source_klass.active
  end

  def destroy
    @source_model.make_deleted!
    redirect_to sources_path
  end
end