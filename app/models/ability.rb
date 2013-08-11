class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all
  end

  #- This method is useless, and it's just for reason testing
  def useless
    puts 'Hello World'
  end
end
