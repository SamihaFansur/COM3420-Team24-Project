# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    # guests - no functionality, only show guest prompt
    if user.guest?
      cannot :manage, Ecf
      cannot :manage, Meeting
      cannot :manage, User
      can :guest_prompt, User
    end

    # students - can create ecf, read ecf, edit exisiting ecf
    if user.student?
      can [:read, :new, :create, :update, :update_persist, :edit, :submit], Ecf
      cannot :manage, Meeting
      cannot :manage, User
    end

    # module leaders - can read ecfs with effected module relating to them
    if user.module_leader?
      can [:read], Ecf
      cannot [:edit, :update_persist, :search], Ecf
      cannot :manage, Meeting
      cannot :manage, User
    end

    # scrutiny panel members - can read + edit ecfs (notes), create + use meetings
    if user.scrutiny?
      can [:read, :update_persist, :edit, :search], Ecf
      can [:new, :create, :read], Meeting
      cannot [:update, :destroy], Meeting
      can :manage, User
      cannot [:showECFs, :guest_prompt], User
    end

    # admins / scrutiny chair - can manage everything
    if user.admin?
      can :manage, :all
      cannot :create, Ecf
      cannot :submit, Ecf
      cannot :guest_prompt, User
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
