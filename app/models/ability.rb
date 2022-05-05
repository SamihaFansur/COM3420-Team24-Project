# frozen_string_literal: true

# Model for abilities. Defines which users can do which actions.
class Ability
  include CanCan::Ability

  # assignment of CanCanCan abilities
  def initialize(user)
    user ||= User.new

    # guests - no functionality, can only view guest prompt
    if user.guest?
      cannot :manage, Ecf
      cannot :manage, Meeting
      cannot :manage, User
      can :guest_prompt, User
    end

    # students - can create ecf, read ecf, edit exisiting ecf
    if user.student?
      can %i[read new create update update_persist edit submit], Ecf
      cannot :manage, Meeting
      cannot :manage, User
      cannot :guest_prompt, User
    end

    # module leaders - can read ecfs with affected module relating to them
    if user.module_leader?
      can [:read], Ecf
      cannot %i[edit update_persist search], Ecf
      cannot :manage, Meeting
      cannot :manage, User
      cannot :guest_prompt, User
    end

    # scrutiny panel members - can read + edit ecfs (notes), create + use meetings
    if user.scrutiny?
      can %i[read update_persist edit search], Ecf
      can [:read], Meeting
      can :view_details, Ecf
      cannot :manage, Outcome
      cannot %i[update destroy], Meeting
      cannot :manage, User
      cannot %i[showECFs guest_prompt], User
    end

    # admins / scrutiny chair - can manage every table
    if user.admin?
      can :manage, :all
      cannot :create, Ecf
      cannot :submit, Ecf
      cannot :guest_prompt, User
    end
  end
end
