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
    expect(vehicle.year).not_to eq(Date.parse('2018-01-02'))
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
end
