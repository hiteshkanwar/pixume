class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.role == "admin"
      can :access, :rails_admin # only allow admin users to access Rails Admin
      can :dashboard
      can :manage, :all

    elsif user.role == "recruiter"
      can :search_pixsume
      can :read, [User]
      can :manage, [User], :id => user.id
      can :manage, [Achievement, Education, Experience, SkillSet],  :user_id => user.id
      can :manage, [AchievementCategory, SkillCategory]

    elsif user.role == "default"
      can :read, [User]
      can :manage, [User], :id => user.id
      can :manage, [Achievement, Education, Experience, SkillSet],  :user_id => user.id
      can :manage, [AchievementCategory, SkillCategory]

    else # guest user
      can :read, [User]
      can :read, [Achievement, Education, Experience, SkillSet]
      can :read, [AchievementCategory, SkillCategory]
    
    end
    
  end
end
