require './spec_helper.rb'
require './vehicle.rb'
describe Vehicle do
  it 'sets license plate' do
    vehicle = described_class.new('AFS:124')
    expect(vehicle.license_plate).to eq('AFS:124')
  end

  it 'make is in capitalize letters' do
    vehicle = described_class.new('ABD:123')
    vehicle.make = 'hoNda'
    expect(vehicle.make).to eq('HONDA')
  end

  it 'model is in capitalize letters' do
    vehicle = described_class.new('ABD:123')
    vehicle.model = 'civic'
    expect(vehicle.model).to eq('CIVIC')
  end

  it 'sets vehicle year' do
    vehicle = described_class.new('ABD:322')
    vehicle.year = '2005-09-22'
    expect(vehicle.year).to eq(Date.parse('2005-09-22'))
  end

  it 'does not sets vehicle year if date is letter than now' do
    vehicle = described_class.new('ABD:322')
    vehicle.year = '2018-01-02'
    expect(vehicle.year).to be_nil
  end

  it 'sets rent price' do
    vehicle = described_class.new('AAA:999')
    vehicle.price_for_hour = 50
    expect(vehicle.price_for_hour).to eq(50)
  end

  it 'does not sets rent price if argument is not number' do
    vehicle = described_class.new('AAA:999')
    vehicle.price_for_hour = '50'
    expect(vehicle.price_for_hour).not_to eq('50')
  end

  it 'reserves vehicle' do
    vehicle = described_class.new('AAA:000')
    vehicle.reserve
    expect(vehicle.reserved).to eq(true)
  end

  it 'end reserve for vehicle' do
    vehicle = described_class.new('AAA:000')
    vehicle.reserve
    vehicle.free
    expect(vehicle.reserved).to eq(false)
  end

  it 'checks if same vehicle cannot be stored in the file' do
    vehicle = described_class.new('LEK:111')
    vehicle.make = 'Lexus'
    vehicle.create
    vehicle_temp = described_class.new('LEK:111')
    vehicle_temp.make = 'Toyota'
    vehicle.create

    YAML.load_stream(File.open('vehicles.yaml')) do |vehicle_object|
      vehicle = vehicle_object if vehicle_object.license_plate.eql?('LEK:111')
    end
    expect(vehicle.make).to eq('LEXUS')
    vehicle.delete
    vehicle_temp.delete
  end

  it 'checks if vehicle is stored in the file' do
    test_file = File.open('test_vehicles.yaml', 'w')

    vehicle1 = described_class.new('AKL:340')
    vehicle1.make = 'Honda'
    vehicle1.model = 'Accord'
    vehicle1.year = '2010-02-11'
    vehicle1.price_for_hour = 10
    YAML.dump(vehicle1, test_file)

    test_file.close

    test_vehicles = []
    YAML.load_stream(File.open('test_vehicles.yaml')) do |vehicle|
      test_vehicles = vehicle
    end

    vehicles = described_class.list[0]

    expect(vehicles.license_plate).to eq(test_vehicles.license_plate)
  end

  it 'checks if method gets all vehicles from file' do
    vehicle_list = []
    YAML.load_stream(File.open('vehicles.yaml')) do |vehicle_object|
      vehicle_list << vehicle_object
    end
    expect(described_class.list.size).to eq(vehicle_list.size)
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
    vehicle.delete
    YAML.load_stream(File.open('vehicles.yaml')) do |vehicle_object|
      vehicle = vehicle_object
    end
    expect(vehicle.license_plate).not_to eq('LLL:911')
  end
end
