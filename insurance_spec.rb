require './spec_helper.rb'
require './insurance.rb'
require './vehicle.rb'
require './rent.rb'
require './user.rb'

RSpec::Matchers.define :have_insurance_cost do |expected|
  match do |actual|
    rent = Rent.new
    vehicle = Vehicle.new('ffa:123')
    vehicle.price_for_hour = 10
    rent.vehicle_price = vehicle.price_for_hour
    time = Time.new
    time.start_at = '9:00'
    time.end_at = '11:00'
    rent.duration = time
    actual.calculate(rent, user)
    actual.cost == expected
  end
end

RSpec.describe Insurance do
  subject(:insurance) { described_class.new }
  subject(:user) { User.new('ricardas', 'ramANauskas') }

  it 'calculates insurance cost if users age is more than 24' do
    user.birth_date = '1980-09-30'
    expect(insurance).to have_insurance_cost(5)
  end

  it 'calculates insurance cost if users age is less than 24' do
    user.birth_date = '1996-09-30'
    expect(insurance).to have_insurance_cost(5.5)
  end
end
