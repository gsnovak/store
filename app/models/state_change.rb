class StateChange < ApplicationRecord
  default_scope { order('state_changes.created_at ASC') }
  validates :previous_state, :next_state, :source_id, :source_type, presence: true
  belongs_to :created_by, class_name: User.name
  belongs_to :source, polymorphic: true
end
