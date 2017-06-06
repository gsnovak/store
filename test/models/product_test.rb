require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test 'Test valid product' do
    product = create(:product)
    assert product.valid?
  end

  test 'Invalid without name set' do
    product = create(:product)
    product.name = nil
    refute product.valid?, 'product valid without name'
    assert_not_nil product.errors[:name], 'no validation error for name'
  end

  test 'Invalid without available set' do
    product = create(:product)
    product.available = nil
    refute product.valid?, 'product valid without available set'
    assert_not_nil product.errors[:available], 'no validation error for available'
  end

  test 'Invalid without price' do
    product = create(:product)
    product.price = nil
    refute product.valid?, 'valid without price'
    assert_not_nil product.errors[:price], 'no validation error for price'
  end

  test 'Invalid without count' do
    product = create(:product)
    product.on_hand_count = nil
    refute product.valid?, 'valid without price'
    assert_not_nil product.errors[:on_hand_count], 'no validation error for on_hand_count'
  end
end
