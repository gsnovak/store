class AddCreatedByIdToStateChange < ActiveRecord::Migration[5.1]
  def change
    add_column :state_changes, :created_by_id, :integer
  end
end
