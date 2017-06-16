class Order < ApplicationRecord
  attr_accessor :credit_card_id

  belongs_to :user, dependent: :destroy,
  has_many :order_items
  has_one :payment

  self.state_machine({
    cart: [:placed],
    placed: [:canceled],
    canceled: []
   })

  def order_total
    order_items.map(&:source).to_a.sum(&:price)
  end

  before_transition_to :placed do
    if order_items.to_a.sum(&:quantity) == 0
      errors[:base] << "Order must contain at least one item"
    end

    order_items.each do |item|
      if item.source.on_hand_count < item.quantity
        errors[:base] << "There is not enough #{item.name} in inventory to complete your order."
      end
    end

    order_items.each do |item|
      item.source.on_hand_count -= item.quantity
      unless item.source.save
        item.errors.map{|field, field_errors| "#{field}: #{field_errors.join(",")}.join(", ")}"
      end
    end

    payment = Payment.find_or_create_by(credit_card_id: credit_card_id, order_id: id)
    payment.amount = order_total

    unless payment.make_completed
      errors[:base] << "Unable to compelete payment."
    end
    errors.empty?
  end

  before_transition_to :canceled do
    order_items.each do |item|
      item.source.on_hand_count += item.quantity
      unless item.source.save
        errors[:base] << "Unable to properly save #{item.source.name}"
      end
    end
    if !payment.nil?
      unless payment.make_voided
        errors[:payment] << "Could not change payment state to voided"
      end

      unless payment.save
        errors[:base] << "Unable to properly save #{item.source.name}"
      end
    end
    errors.empty?
  end
end
