require './spec./spec_helper.rb'
require './user.rb'
# require 'rspec/expectations'
=begin
RSpec::Matchers.define :have_date do |expected|
  match do |actual|
    actual.birth_date == expected.birth_date
  end
end

RSpec.describe User do
  subject(:user) { described_class.new('Tomas', 'Ss') }

  context 'when same factory' do
    it 'is a duplicate' do
      user.birth_date = '1998-09-30'
      user1 = described_class.new('Tomas', 'Ss')
      user1.birth_date = '1998-09-30'
      expect(user).to have_date(user1)
    end
  end

  context 'when different factory' do
    it 'is not a duplicate' do
      expect(user).to_not have_date(described_class.new('Tomas', 'As'))
    end
  end
=end
describe User do
  it 'is equal to same stirng in capitalize letter' do
    user = described_class.new('ricardas', 'ra')
    expect(user).to have_attributes('name' => 'Ricardas', 'surname' => 'Ra')
  end

  it 'is equal to the date' do
    user = described_class.new('ricardas', 'ramANauskas')
    user.birth_date = '1998-09-30'
    expect(user.birth_date).to eq(Date.parse('1998-09-30'))
  end

  it 'is not equal to the date if age is less than 18' do
    user = described_class.new('ricardas', 'ramANauskas')
    user.birth_date = '2000-09-30'
    expect(user.birth_date).not_to eq(Date.parse('2000-09-30'))
  end

  it 'sets email' do
    user = described_class.new('ricardas', 'ramANauskas')
    user.email = 'ricardas@gmail.com'
    expect(user.email).to eq('ricardas@gmail.com')
  end

  it 'does not set email if it does not contains @' do
    user = described_class.new('ricardas', 'ramANauskas')
    user.email = 'Ricardas.gmail.com'
    expect(user.email).not_to eq('Ricardas.gmail.com')
  end

  it 'sets password' do
    user = described_class.new('ricardas', 'ramANauskas')
    user.password = '1234abcd'
    expect(user.password).to eq('1234abcd')
  end

  it 'does not set password if its to short' do
    user = described_class.new('ricardas', 'ramANauskas')
    user.password = '1234ab'
    expect(user.password).not_to eq('1234ab')
  end

  it 'checks if user is stored in the file' do
    user = described_class.new('ricardas', 'ramANauskas')
    user.email = 'ricardas9000@gmail.com'
    user.create
    YAML.load_stream(File.open('users.yaml')) do |users|
      user = users if users.email.eql?('ricardas9000@gmail.com')
    end
    expect(user.email).to eq('ricardas9000@gmail.com')
    user.delete
  end

  it 'checks if user with same email cannot be stored in the file' do
    user = described_class.new('Ricardas', 'ramANauskas')
    user.email = 'ricardas1234@gmail.com'
    user.create
    user2 = described_class.new('Rokas', 'Tadas')
    user2.email = 'ricardas1234@gmail.com'
    user2.create

    YAML.load_stream(File.open('users.yaml')) do |users|
      user = users if users.email.eql?('ricardas1234@gmail.com')
    end
    expect(user.name).to eq('Ricardas')
    user.delete
  end

  it 'deletes' do
    user = described_class.new('Ricardas', 'ramANauskas')
    user.email = 'ricardas112@gmail.com'
    user.create
    user.delete
    YAML.load_stream(File.open('users.yaml')) do |user_obj|
      user = user_obj
    end
    expect(user.email).not_to eq('ricardas112@gmail.com')
  end

  it 'gets by email' do
    user = described_class.new('Ricardas2000', 'ramANauskas')
    user.email = 'ricardas2000@gmail.com'
    user.create
    user1 = described_class.get_by_email('ricardas2000@gmail.com')
    expect(user1.email).to eq(user.email)
    user.delete
  end
end
