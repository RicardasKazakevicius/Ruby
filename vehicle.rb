require './vehicle_information.rb'
# This class defines information about vehicle
class Vehicle
  attr_reader :make, :model, :license_plate

  def initialize(license_plate)
    @license_plate = license_plate.upcase
    @vehicle_information = VehicleInformation.new
    @vehicle_information.free
  end

  def self.get_by_number(number)
    Vehicle.list[number - 1]
  end

  def create
    different_vehicle = true
    YAML.load_stream(File.open('vehicles.yaml')) do |vehicle_object|
      different_vehicle = false if vehicle_object.license_plate == license_plate
    end

    return unless different_vehicle
    write_to_file
  end

  def write_to_file
    file = File.open('vehicles.yaml', 'a+')
    YAML.dump(self, file)
    file.close
  end

  # returns all vehicle object from yaml file
  def self.list
    vehicle_list = []
    YAML.load_stream(File.open('vehicles.yaml')) do |vehicle_object|
      vehicle_list << vehicle_object
    end
    vehicle_list
  end

  def self.not_reserved
    vehicle_list = []
    YAML.load_stream(File.open('vehicles.yaml')) do |vehicle_object|
      vehicle_list << vehicle_object unless vehicle_object.reserved
    end
    vehicle_list
  end

  def delete
    vehicle_list = Vehicle.list
    file = File.open('vehicles.yaml', 'w')
    file.close
    vehicle_list.each do |vehicle|
      vehicle.write_to_file unless vehicle.license_plate == license_plate
    end
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
