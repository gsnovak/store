class Order < ApplicationRecord
  attr_accessor :credit_card_id

  belongs_to :user
  has_many :order_items
  has_one :payment

  self.state_machine({
    cart: [:placed],
    placed: [:canceled],
    canceled: []
   })

  def add_order_item item
    if item.instance_of? OrderItem
      order_items << item
    end
  end

  before_transition_to :placed do
    if order_items.to_a.sum(&:quantity) == 0
      errors[:base] << "Order must contain at least one item"
    end

    order_items.each do |item|
      if item.source.on_hand_count < item.quantity
        errors[:base] << item.errors.map{|field, field_errors| "#{field}: #{field_errors}"}
      end
    end

    #consume the orders nom nom nom <(-.-<)
    order_items.each do |item|
      item.source.on_hand_count -= item.quantity
      item.source.available = item.source.on_hand_count > 0
      unless item.source.save
        errors[:base] << item.errors.map{|field, field_errors| "#{field}: #{field_errors}"}
      end
    end

    payment = Payment.find_or_create_by(credit_card_id: credit_card_id, order_id: id)
    payment.amount = order_items.map(&:source).to_a.sum(&:price)

    errors.empty?
  end

  before_transition_to :canceled do
    order_items.each do |item|
      item.source.on_hand_count += item.quantity
      item.source.available = true
      unless item.source.save
        errors[:base] << item.source.errors.map{|field, field_errors| "#{field}: #{field_errors}"}
      end
    end
    if !payment.nil?
      unless payment.make_voided
        errors[:base] << payments.errors.map{|field, field_errors| "#{field}: #{field_errors}"}
      end

      unless payment.save
        errors[:base] << payments.errors.map{|field, field_errors| "#{field}: #{field_errors}"}
      end
    end
  end
end
