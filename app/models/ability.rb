# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user ||= User.new

    if user
      user.admin? ? admin : auth_user
    else
      guest
    end
  end

  def guest; end

  def auth_user
    guest
    can [:read, :import, :create_csv, :syncronaize], Provider
    can [:read, :create, :update, :import], Product
    can :manage, Mb
  end

  def admin
    can :manage, :all
  end
end
