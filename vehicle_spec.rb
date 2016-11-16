require './spec_helper.rb'
require './vehicle.rb'
RSpec.describe Vehicle do
  subject(:vehicle) { described_class.new('AFS:124') }

  it 'sets license plate' do
    expect(vehicle.license_plate).to eq('AFS:124')
  end

  it 'make is in capitalize letters' do
    vehicle.make = 'honda'
    expect(vehicle.make).to eq('HONDA')
  end

  it 'model is in capitalize letters' do
    vehicle.model = 'civic'
    expect(vehicle.model).to eq('CIVIC')
  end

  it 'sets vehicle year' do
    vehicle.year = '2005-09-22'
    expect(vehicle.year).to eq(Date.parse('2005-09-22'))
  end

  it 'does not sets vehicle year if date is letter than now' do
    vehicle.year = '2018-01-02'
    expect(vehicle.year).to be_nil
  end

  it 'sets rent price' do
    vehicle.price_for_hour = 50
    expect(vehicle.price_for_hour).to eq(50)
  end

  it 'does not sets rent price if argument is not number' do
    vehicle.price_for_hour = '50'
    expect(vehicle.price_for_hour).not_to eq('50')
  end

  it 'reserves vehicle' do
    vehicle.reserve
    expect(vehicle.reserved).to eq(true)
  end

  it 'end reserve for vehicle' do
    vehicle.reserve
    vehicle.free
    expect(vehicle.reserved).to eq(false)
  end

  it 'checks if same vehicle cannot be stored in the file' do
    vehicle.make = 'Lexus'
    vehicle.create
    vehicle_temp = described_class.new('LEK:111')
    vehicle_temp.make = 'Toyota'
    vehicle.create
    temp = vehicle
    YAML.load_stream(File.open('vehicles.yaml')) do |vehicle_object|
      temp = vehicle_object if vehicle_object.license_plate.eql?('LEK:111')
    end
    expect(temp.make).to eq('LEXUS')
    described_class.delete(vehicle.license_plate)
    described_class.delete(vehicle_temp.license_plate)
  end

  it 'checks if method gets all vehicles from file' do
    test_vehicles = Array[]

    vehicle1 = described_class.new('AKL:340')
    vehicle1.make = 'HONDA'
    vehicle1.model = 'Accord'
    vehicle1.year = '2010-02-11'
    vehicle1.price_for_hour = 10

    vehicle2 = described_class.new('KKA:312')
    vehicle2.make = 'Fiat'
    vehicle2.model = '500'
    vehicle2.year = '2011-10-21'
    vehicle2.price_for_hour = 5

    vehicle3 = described_class.new('AAS:332')
    vehicle3.make = 'Subaru'
    vehicle3.model = 'Forester'
    vehicle3.year = '2008-01-11'
    vehicle3.price_for_hour = 8

    test_vehicles = Array[]
    test_vehicles_list = Array[]

    test_vehicles_list << vehicle1
    test_vehicles_list << vehicle2
    test_vehicles_list << vehicle3

    test_vehicles_list.each do |vehicle|
      test_vehicles << vehicle.license_plate
      test_vehicles << vehicle.make
      test_vehicles << vehicle.model
      test_vehicles << vehicle.year
      test_vehicles << vehicle.price_for_hour
    end

    vehicles = Array[]
    vehicles_list = described_class.list
    vehicles_list.each do |vehicle|
      vehicles << vehicle.license_plate
      vehicles << vehicle.make
      vehicles << vehicle.model
      vehicles << vehicle.year
      vehicles << vehicle.price_for_hour
    end

    expect(vehicles).to eq(test_vehicles)
  end

  it 'checks if vehicles is stored in the file' do
    vehicle1 = described_class.new('AKL:340')
    vehicle1.make = 'HONDA'
    vehicle1.model = 'Accord'
    vehicle1.year = '2010-02-11'
    vehicle1.price_for_hour = 10

    vehicle2 = described_class.new('KKA:312')
    vehicle2.make = 'Fiat'
    vehicle2.model = '500'
    vehicle2.year = '2011-10-21'
    vehicle2.price_for_hour = 5

    vehicle3 = described_class.new('AAS:332')
    vehicle3.make = 'Subaru'
    vehicle3.model = 'Forester'
    vehicle3.year = '2008-01-11'
    vehicle3.price_for_hour = 8

    test_file = File.open('test_vehicles.yaml', 'w')
    YAML.dump(vehicle1, test_file)
    YAML.dump(vehicle2, test_file)
    YAML.dump(vehicle3, test_file)
    test_file.close

    expect(File.read('test_vehicles.yaml')).to eq(File.read('vehicles.yaml'))
  end

  it 'checks if method gets all not reserved vehicles from file' do
    vehicle_list = []
    YAML.load_stream(File.open('vehicles.yaml')) do |vehicle_object|
      vehicle_list << vehicle_object
    end
    expect(described_class.not_reserved.size).to eq(vehicle_list.size)
  end

  it 'gets vehicle by number' do
    vehicle = described_class.list[0]
    vehicle_by_number = described_class.get_by_number(1)
    expect(vehicle.license_plate).to eq(vehicle_by_number.license_plate)
  end

  it 'deletes' do
    vehicle = described_class.new('LLL:911')
    vehicle.create
    described_class.delete(vehicle.license_plate)
    YAML.load_stream(File.open('vehicles.yaml')) do |vehicle_object|
      vehicle = vehicle_object
    end
    expect(vehicle.license_plate).not_to eq('LLL:911')
  end
end
