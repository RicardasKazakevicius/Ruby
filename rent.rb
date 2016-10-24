require './time.rb'
# This class is for defining rent action
class Rent
  attr_reader :vehicle_price, :duration, :discount_code
  CONSTANT_DISCOUNT = 0.85

  def vehicle_price=(vehicle_price)
    return unless vehicle_price > 0
    @vehicle_price = vehicle_price
  end

  def duration=(time)
    @duration = time.duration
  end

  def price
    price = vehicle_price * duration
    if duration >= 24
      price * 0.5
    else
      price
    end
  end

  def start(user, vehicle)
    user.amount_to_pay = price
    vehicle.reserve
  end
=begin
  def discount_code=(code)
    @discount_code = code.upcase
  end

  def price_with_discount
    vehicle_price * duration * CONSTANT_DISCOUNT
  end
=end
end
