require './spec_helper.rb'
require './rent.rb'
require './user.rb'
require './vehicle.rb'
require './time.rb'

RSpec::Matchers.define :have_price do |expected|
  match do |actual|
    actual.price == expected
  end
end

RSpec.describe Rent do
  subject(:rent) { described_class.new }
  subject(:vehicle) { Vehicle.new('ffa:123') }
  subject(:time) { Time.new }
  subject(:set_time) do
    time.start_at = '9:00'
    time.end_at = '11:00'
    rent.duration = time
  end
  subject(:set_vehicle_price) do
    vehicle.price_for_hour = 10
    rent.vehicle_price = vehicle.price_for_hour
  end

  it 'does not sets vehicle price if price is zero' do
    rent.vehicle_price = 0
    expect(rent.vehicle_price).to eq(nil)
  end

  it 'calculates rent price if duration is less than 24 hours' do
    set_vehicle_price
    set_time
    expect(rent).to have_price(20)
  end

  it 'calculates rent price if duration is 24 hours' do
    set_vehicle_price
    time.start_at = '00:00'
    time.end_at = '24:00'
    rent.duration = time
    expect(rent).to have_price(120)
  end

  it 'calculates rent price if duration is more than 24 hours' do
    set_vehicle_price
    time.start_at = '2017-01-28 11:00'
    time.end_at = '2017-01-30 11:00'
    rent.duration = time
    expect(rent).to have_price(240)
  end

  it 'calculates the duration' do
    set_time
    expect(rent.duration).to eq(2)
  end

  it 'sets how much money user has to pay for a rent' do
    set_vehicle_price
    set_time
    user = User.new('ricardas', 'ramANauskas')
    expect { rent.start(user, vehicle) }.to change { user.amount_to_pay }
      .from(0).to(20)
  end

  it 'reserves vehicle' do
    set_vehicle_price
    user = User.new('ricardas', 'ramANauskas')
    set_time
    rent.start(user, vehicle)
    expect(vehicle.reserved).to eq(true)
  end
end
=begin
  it 'sets discount code' do
    rent.discount_code_file = '911'
    discount = []
    YAML.load_stream(File.open('discount.yaml')) do |discount_obj|
      discount << discount_obj
    end
    expect(discount).to contain_exactly('911')
  end

  it 'gets price with discount' do
    set_vehicle_price
    set_time
    expect(rent.price_with_discount('911')).to eq(17)
  end
=end
