require 'date'
require './spec_helper.rb'
require './insurance.rb'
require './vehicle.rb'
require './rent.rb'
require './user.rb'

RSpec::Matchers.define :insurance_cost do |expected|
  match do |actual|
    actual.cost == expected
  end
end

CONSTANT_24_YEARS = 365.25 * 24

RSpec.describe Insurance do
  subject(:insurance) { described_class.new }
  subject(:user) { User.new('ricardas', 'ramANauskas') }
  subject(:rent) { Rent.new }
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

  it 'calculates insurance cost if users age is more than 24' do
    set_vehicle_price
    set_time
    user.birth_date = (Date.today - CONSTANT_24_YEARS - 1).to_s
    insurance.calculate(rent, user)
    expect(insurance).to insurance_cost(5)
  end

  it 'calculates insurance cost if users age is 24' do
    set_vehicle_price
    set_time
    user.birth_date = (Date.today - CONSTANT_24_YEARS - 1).to_s
    insurance.calculate(rent, user)
    expect(insurance).to insurance_cost(5)
  end

  it 'calculates insurance cost if users age is less than 24' do
    set_vehicle_price
    set_time
    user.birth_date = (Date.today - CONSTANT_24_YEARS + 1).to_s
    insurance.calculate(rent, user)
    expect(insurance).to insurance_cost(5.5)
  end
end
