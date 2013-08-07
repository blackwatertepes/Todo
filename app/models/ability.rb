class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :manage, :all
  end
#- This should be removed, and placed with git
#- So should this comment
end
