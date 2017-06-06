class RemoveSourceRefFromProducts < ActiveRecord::Migration[5.1]
  def change
    remove_reference(:products, :source, polymorphic: true)
  end
end
