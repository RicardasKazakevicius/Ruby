require './time.rb'
# This class is for defining rent action
class Rent
  attr_reader :vehicle_price, :duration, :discount_code
  CONSTANT_DISCOUNT = 0.85
  MIN_PRICE = 0

  def vehicle_price=(vehicle_price)
    @vehicle_price = vehicle_price if vehicle_price > MIN_PRICE
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
end
=begin
(* 100).round / 100.0
  def discount_code_file=(code)
    @discount_code = code.to_s
    file = File.open('discount.yaml', 'w')
    YAML.dump(code, file)
    file.close
  end

  def price_with_discount(discount_code)
    discount = YAML.load_file('discount.yaml')
    vehicle_price * duration * CONSTANT_DISCOUNT if discount_code.eql?(discount)
  end
=end
