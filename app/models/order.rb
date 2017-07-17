class Order < ApplicationRecord
  attr_accessor :credit_card_id

  belongs_to :user
  has_many :order_items
  has_one :payment,
          inverse_of: :order


  self.state_machine({
    cart: [:placed],
    placed: [:canceled],
    canceled: []
   })

  has_many :state_changes, autosave: false, as: :source, inverse_of: :source

  def order_total
    order_items.to_a.sum{|oi| oi.source.price}
  end

  before_transition_to :placed do
    if order_items.to_a.sum(&:quantity) == 0
      errors[:base] << "Order must contain at least one item"
    end

    order_items.each do |item|
      if item.source.on_hand_count < item.quantity
        errors[:base] << "There's not enough inventory to fulfill order!"
      end
    end

    payment = Payment.find_or_initialize_by(credit_card_id: user.credit_card.id, order_id: self.id)
    payment.amount = order_total
    payment.save

    unless payment.make_completed
      payment.errors.full_messages.each do |msg|
        errors[:base] << "Payment Error: #{msg}"
      end
    end
    errors.empty?
  end

  after_transition_to :placed do
    OrderMailer.send_placement_email(id).deliver

    order_items.each do |item|
      item.source.on_hand_count -= item.quantity
      unless item.source.save
        errors[:base] << item.errors.map{|field, field_errors| "#{field}: #{field_errors}"}
      end
    end
  end

  before_transition_to :canceled do
    if not payment.make_voided
      payment.errors.full_messages.each do |msg|
        errors[:base] << "Payment Error: #{msg}"
      end
    end
    errors.empty?
  end

  after_transition_to :canceled do
    order_items.each do |item|
      item.source.on_hand_count += item.quantity
      unless item.source.save
        errors[:base] << item.source.errors.map{|field, field_errors| "#{field}: #{field_errors}"}
      end
    end
  end
end
