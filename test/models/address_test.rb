require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test 'valid state' do
    address = create(:address)
    assert address.valid?
  end

  test 'invalid without state/zip' do
    address = create(:address)
    address.zip_code = nil
    address.state = nil
    refute address.valid?
    assert_not_nil address.errors[:state]
    assert_not_nil address.errors[:zip_code]
  end
end
