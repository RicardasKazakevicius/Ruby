require 'date'
require './vehicle.rb'
require './user.rb'
# This class defines insurance cost for rent
class Insurance
  attr_reader :cost
  CONSTANT_24_YEARS = 365.25 * 24

  def calculate(rent, user)
    @cost = rent.price * 0.25
    @cost += cost * 0.1 unless
    Date.today - CONSTANT_24_YEARS >= user.birth_date
  end
end
