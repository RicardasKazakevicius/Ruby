require './spec_helper.rb'
require './rent.rb'
require './user.rb'
require './vehicle.rb'
require './time.rb'

RSpec::Matchers.define :have_rent_price do |expected|
  match do |actual|
    vehicle = Vehicle.new('ffa:123')
    vehicle.price_for_hour = 20
    actual.vehicle_price = vehicle.price_for_hour
    actual.price == expected
  end
end

RSpec.describe Rent do
  subject(:rent) { described_class.new }

  it 'calculates rent price' do
    time = Time.new
    time.start_at = '9:00'
    time.end_at = '11:00'
    rent.duration = time
    expect(rent).to have_rent_price(40)
  end

  it 'calculates rent price if duration is more than 24 hours' do
    time = Time.new
    time.start_at = '2017-01-28 11:00'
    time.end_at = '2017-01-30 11:00'
    rent.duration = time
    expect(rent).to have_rent_price(480)
  end

  it 'calculates the duration' do
    rent = described_class.new
    time = Time.new
    time.start_at = '9:00'
    time.end_at = '10:30'
    rent.duration = time
    expect(rent.duration).to eq(1.5)
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
    user = User.new('ricardas', 'ramANauskas')
    expect { rent.start(user, vehicle) }.to change { user.amount_to_pay }
      .from(0).to(20)
  end

  it 'reserves vehicle' do
    rent = described_class.new
    vehicle = Vehicle.new('ffa:123')
    vehicle.price_for_hour = 10
    rent.vehicle_price = vehicle.price_for_hour
    user = User.new('ricardas', 'ramANauskas')
    time = Time.new
    time.start_at = '9:00'
    time.end_at = '11:00'
    rent.duration = time
    rent.start(user, vehicle)
    expect(vehicle.reserved).to eq(true)
  end

  it 'sets discount code' do
    rent = described_class.new
    rent.discount_code_file = '911'
    discount = []
    YAML.load_stream(File.open('discount.yaml')) do |discount_obj|
      discount << discount_obj
    end
    expect(discount).to contain_exactly('911')
  end

  it 'gets price with discount' do
    rent = described_class.new
    vehicle = Vehicle.new('ffa:123')
    vehicle.price_for_hour = 20
    rent.vehicle_price = vehicle.price_for_hour
    time = Time.new
    time.start_at = '9:00'
    time.end_at = '10:00'
    rent.duration = time
    expect(rent.price_with_discount('911')).to eq(17)
  end
end
=begin
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
=end
