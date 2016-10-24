# This class describes vehicle year and price
class VehicleInformation
  attr_reader :year, :price, :reserved

  def year=(year)
    today = Date.today
    year = Date.parse(year)

    return unless today >= year
    @year = year
  end

  def price=(price)
    return unless price.is_a? Numeric
    @price = price
  end

  def reserve
    @reserved = true
  end

  def free
    @reserved = false
  end
end
