require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test 'valid state' do
    address = create(:address)
    assert address.valid?
  end

  test 'invalid without name' do
    address = create(:address)
    address.zip_code = nil
    refute address.valid?
    assert_not_nil address.errors[:name]
  end

  test 'invalid without abbreviation' do
    address = create(:address)
    address.state = nil
    refute address.valid?
    assert_not_nil address.errors[:state]
  end
end
