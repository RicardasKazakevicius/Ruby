require 'date'
# This class defines user log in information
class UserInformation
  attr_reader :email, :password, :birth_date
  # 365.25 amerage number of days in the year
  CONSTANT_18_YEARS = 365.25 * 18

  def email=(email)
    return unless email.include? '@'
    @email = email
  end

  def password=(password)
    return unless password.length > 7
    @password = password
  end

  def birth_date=(birth_date)
    birth_date = Date.parse(birth_date)
    return unless Date.today >= birth_date + CONSTANT_18_YEARS
    @birth_date = birth_date
  end
end
