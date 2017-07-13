class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new
      alias_action :create, :read, :update, :destroy, to: :crud

      if user.admin?
        can :manage, :all
      else
        can :crud, OrderItem
        can :read, Product
        can :manage, Order, user_id: user.id
        can :crud, CreditCard, user_id: user.id
        can :crud, Address, user_id: user.id
        can :crud, State
      end
  end
end
