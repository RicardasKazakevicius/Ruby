require './user_information.rb'
require './user_finances.rb'
# This class defines information about user
class User
  attr_reader :name, :surname

  def initialize
    @user_information = UserInformation.new
    @user_finances = UserFinances.new
  end

  def name=(name)
    @name = name.capitalize
  end

  def surname=(surname)
    @surname = surname.capitalize
  end

  def email=(email)
    @user_information.email = email
  end

  def password=(password)
    @user_information.password = password
  end

  def birth_date=(birth_date)
    @user_information.birth_date = birth_date
  end

  def amount_to_pay=(amount_to_pay)
    @user_finances.amount_to_pay = amount_to_pay
  end

  def email
    @user_information.email
  end

  def password
    @user_information.password
  end

  def birth_date
    @user_information.birth_date
  end

  def amount_to_pay
    @user_finances.amount_to_pay
  end
end
