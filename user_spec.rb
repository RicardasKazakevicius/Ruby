require './spec./spec_helper.rb'
require './user.rb'
describe User do
  it 'is equal to same stirng in capitalize letter' do
    user = described_class.new('ricardas', 'ramANauskas')
    expect(user.name + user.surname).to eq('RicardasRamanauskas')
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
    user.email = 'ricardas@gmail.com'
    user.create
    user2 = described_class.new('Rokas', 'Tadas')
    user2.email = 'ricardas@gmail.com'
		user2.create
		
    YAML.load_stream(File.open('users.yaml')) do |users|
      user1 = users if users.email.eql?('ricardas@gmail.com')
    end
    expect(user.name).to eq('Ricardas')
  end

  it 'deletes' do
    user = described_class.new('Ricardas', 'ramANauskas')
    user.email = 'ricardas@gmail.com'
    user.create
    user.delete
    YAML.load_stream(File.open('users.yaml')) do |user_obj|
      user = user_obj
    end
    expect(user.email).not_to eq('ricardas@gmail.com')
  end
end
