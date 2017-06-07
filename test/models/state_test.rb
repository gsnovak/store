require 'test_helper'

class StateTest < ActiveSupport::TestCase
  test 'valid state' do
    state = create(:state)
    assert state.valid?
  end

  test 'invalid without name' do
    state = create(:state)
    state.name = nil
    refute state.valid?
    assert_not_nil state.errors[:name]
  end

  test 'invalid without abbreviation' do
    state = create(:state)
    state.abbreviation = nil
    refute state.valid?
    assert_not_nil state.errors[:abbreviation]
  end
end
