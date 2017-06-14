class Order < ApplicationRecord
  attr_accessor :credit_card_id

  validates :state, presence: true
  belongs_to :user
  has_many :order_items, as: :source
  has_one :payment

  self.state_machine({
    cart: [:placed],
    placed: [:cancelled],
    cancelled: []
   })

  before_transition_to :placed do
    if order_items.to_a.sum(&:quantity) == 0
      errors[:base] << "Order must contain at least one item"
    end

    order_items.each do |item|
      if item.source.on_hand_count < item.quantity
        errors[:base] << "There is not enough #{item.name} in inventory to complete your order."
      end
    end

    #consume the orders nom nom nom <(-.-<)
    order_items.each do |item|
      item.source.on_hand_count -= item.quantity
      item.source.available = item.on_hand_count > 0
      unless item.source.save
        errors[:base] << "Unable to properly save #{item.source.name}"
      end
    end

    payment = create_payment(credit_card_id: credit_card_id, order_id: self.id, state: pending)
    payment.amount = order_items.to_a.sum(&:price)

    unless payment.make_placed
      error[:payment] << "Error changing payment state to completed"
    end
    errors.empty?
  end

  before_transition_to :canceled do
    order_items.each do |item|
      item.source.on_hand_count += item.quantity
      item.source.available = true
      unless item.source.save
        errors[:base] << "Unable to properly save #{item.source.name}"
      end
    end

    unless payment.make_voided
      error[:payment] << "Error changing payment state to voided"
    end

    unless payment.save
      errors[:base] << "Unable to properly save #{item.source.name}"
    end
  end
end
