# frozen_string_literal: true

# Model for abilities. Defines which users can do which actions.
class Ability
  include CanCan::Ability

  # Assignment of CanCanCan abilities
  def initialize(user)
    user ||= User.new

    # Guests - no functionality, can only view guest prompt
    if user.guest?
      cannot :manage, Ecf
      cannot :manage, Meeting
      cannot :manage, User
      can :guest_prompt, User
    end

    # Students - can create ecf, read ecf, edit existing ecf
    if user.student?
      can %i[read new create update update_persist edit submit], Ecf, user_id: user.id
      can :manage, Meeting
      can :manage, User
      can :guest_prompt, User
    end

    # Module leaders - can read ecfs with affected module relating to them
    if user.module_leader?
      can [:read], Ecf
      can :update_persist, Ecf
      cannot :manage, Meeting
      cannot :manage, User
      cannot :guest_prompt, User
      can :show, User, id: user.id
    end

    # Scrutiny panel members - can read + edit ecfs (notes), create + use meetings
    if user.scrutiny?
      can %i[read update_persist edit search], Ecf
      can [:read], Meeting
      can :view_details, Ecf
      cannot :manage, Outcome
      cannot %i[update destroy], Meeting
      cannot :manage, User
      cannot %i[showECFs guest_prompt], User
    end

    # Admins / Scrutiny chair - can manage every table
    if user.admin?
      can :manage, :all
      cannot :create, Ecf
      cannot :submit, Ecf
      cannot :guest_prompt, User
    end
  end
end
