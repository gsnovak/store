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

  def order_total
    order_items.to_a.sum{|oi| oi.source.price}
  end

  before_transition_to :placed do
    if order_items.to_a.sum(&:quantity) == 0
      errors[:base] << "Order must contain at least one item"
    end

    order_items.each do |item|
      puts "Quantity: #{item.inspect}, on hand count: #{item.source.on_hand_count}"
      if item.source.on_hand_count < item.quantity
        errors[:base] << item.errors.map{|field, field_errors| "#{field}: #{field_errors}"}
      end
    end

    order_items.each do |item|
      item.source.on_hand_count -= item.quantity
      unless item.source.save
        errors[:base] << item.errors.map{|field, field_errors| "#{field}: #{field_errors}"}
      end
    end

    payment = Payment.find_or_initialize_by(credit_card_id: user.credit_card.id, order_id: self.id)
    payment.amount = order_total
    payment.save

    unless payment.make_completed
      errors[:base] << "payment failed with #{payment.errors}"
    end
    errors.empty?
  end

  before_transition_to :canceled do
    order_items.each do |item|
      item.source.on_hand_count += item.quantity
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
    errors.empty?
  end
end
