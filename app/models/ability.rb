class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all
  end

  def useless
    puts 'Hello Foo Bar'
  end
end
