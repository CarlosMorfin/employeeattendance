# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
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
    if user.present?  # additional permissions for logged in users (they can read their own posts)
      can :read, Attendance, employee_id: user.employee_id
      can :read, User,                id: user.id
      can :read, Employee,            id: user.employee_id

      if user.roles.include?(Role.find_by(code: 'administrator'))  # additional permissions for administrators
        can :manage, Attendance
        can :manage, User
        can :manage, Employee
      end
    end

    user.roles.each { |role| send(role.code) }

    # user.roles.each { |role| send(role.code) } if user.active?

    alias_action :read, :update, to: :modify

    # Default permitssión for a users without roles
    # can :show, :admin_dashboard
  end

  def administrator
    can :show,                   :admin_root
    can :manage,                 :admin_employees
    can :manage,                 :admin_attendances
    can [:show, :edit, :update], :admin_employees_users
    can [:index, :index_all],    :admin_employees_attendances
  end

  def employee
    can :show, :admin_root
    can :read, :admin_employees_attendances
    can :read, :admin_employees_users
    can :show, :admin_employees
  end

end
