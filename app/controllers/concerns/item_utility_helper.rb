module ItemUtilityHelper
  extend ActiveSupport::Concern

  def active_items
    source_klass.where(state: Coupon::ACTIVE)
  end
end