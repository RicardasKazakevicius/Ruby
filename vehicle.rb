require './vehicle_information.rb'
# This class defines information about vehicle
class Vehicle
  attr_reader :make, :model, :license_plate

  def initialize(license_plate)
    @license_plate = license_plate.upcase
    @vehicle_information = VehicleInformation.new
    @vehicle_information.free
  end

  def make=(make)
    @make = make.upcase
  end

  def model=(model)
    @model = model.upcase
  end

  def reserve
    @vehicle_information.reserve
  end

  def free
    @vehicle_information.free
  end

  def year=(year)
    @vehicle_information.year = year
  end

  def price_for_hour=(price)
    @vehicle_information.price = price
  end

  def year
    @vehicle_information.year
  end

  def price_for_hour
    @vehicle_information.price
  end

  def reserved
    @vehicle_information.reserved
  end
end
