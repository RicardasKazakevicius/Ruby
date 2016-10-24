require './spec./spec_helper.rb'
require './rent.rb'
require './user.rb'
require './vehicle.rb'
require './time.rb'
describe Rent do
  it 'calculates the duration' do
    rent = described_class.new
    time = Time.new
    time.start_at = '9:00'
    time.end_at = '10:30'
    rent.duration = time
    expect(rent.duration).to eq(1.5)
  end

  it 'calculates rent price' do
    rent = described_class.new
    vehicle = Vehicle.new('ffa:123')
    vehicle.price_for_hour = 20
    rent.vehicle_price = vehicle.price_for_hour
    time = Time.new
    time.start_at = '9:00'
    time.end_at = '11:00'
    rent.duration = time
    expect(rent.price).to eq(40)
  end

  it 'calculates rent price if duration is more than 24 hours' do
    rent = described_class.new
    vehicle = Vehicle.new('ffa:123')
    vehicle.price_for_hour = 10
    rent.vehicle_price = vehicle.price_for_hour
    time = Time.new
    time.start_at = '2017-01-28 11:00'
    time.end_at = '2017-01-30 11:00'
    rent.duration = time
    expect(rent.price).to eq(240)
  end

  it 'sets how much money user has to pay for a rent' do
    rent = described_class.new
    vehicle = Vehicle.new('ffa:123')
    vehicle.price_for_hour = 10
    rent.vehicle_price = vehicle.price_for_hour
    time = Time.new
    time.start_at = '9:00'
    time.end_at = '11:00'
    rent.duration = time
    user = User.new
    rent.start(user, vehicle)
    expect(user.amount_to_pay).to eq(20)
  end
=begin
  it 'ends rent' do
    rent = described_class.new
    vehicle = Vehicle.new('ffa:123')
    vehicle.price_for_hour = 10
    rent.vehicle_price = vehicle.price_for_hour
    time = Time.new
    time.start_at = '9:00'
    time.end_at = '11:00'
    rent.duration = time
    user = User.new
    rent.start(user, vehicle)
    rent.end(vehicle)
    expect(vehicle.reserved).to eq(false)
  end
=end
  it 'reserves vehicle' do
    rent = described_class.new
    vehicle = Vehicle.new('ffa:123')
    vehicle.price_for_hour = 10
    rent.vehicle_price = vehicle.price_for_hour
    user = User.new
    time = Time.new
    time.start_at = '9:00'
    time.end_at = '11:00'
    rent.duration = time
    rent.start(user, vehicle)
    expect(vehicle.reserved).to eq(true)
  end

  it 'sets discount code' do
    rent = described_class.new
    rent.discount_code = 'DISCOUNT'
    expect(rent.discount_code).to eq('DISCOUNT')
  end

  it 'gets price with discount' do
    rent = described_class.new
    vehicle = Vehicle.new('ffa:123')
    vehicle.price_for_hour = 20
    rent.vehicle_price = vehicle.price_for_hour
    rent.discount_code = 'DISCOUNT'
    time = Time.new
    time.start_at = '9:00'
    time.end_at = '10:00'
    rent.duration = time
    expect(rent.price_with_discount).to eq(17)
  end
end
