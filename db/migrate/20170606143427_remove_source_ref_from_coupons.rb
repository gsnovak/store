class RemoveSourceRefFromCoupons < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:coupons, :source, polymorphic: true)
  end
end
