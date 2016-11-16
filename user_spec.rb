require './spec./spec_helper.rb'
require './user.rb'

RSpec.describe User do
  subject(:user) { described_class.new('ricardas', 'Ra') }

  it 'is equal to same stirng in capitalize letter' do
    expect(user).to have_attributes('name' => 'Ricardas', 'surname' => 'Ra')
  end

  it 'is equal to the date' do
    user.birth_date = '1998-09-30'
    expect(user.birth_date).to eq(Date.parse('1998-09-30'))
  end

  it 'is not equal to the date if age is less than 18' do
    user.birth_date = '2000-09-30'
    expect(user.birth_date).not_to eq(Date.parse('2000-09-30'))
  end

  it 'does not set email if it does not contains @' do
    user.email = 'Ricardas.gmail.com'
    expect(user.email).to be_nil
  end

  it 'sets password' do
    user.password = '1234abcd'
    expect(user.password).to eq('1234abcd')
  end

  it 'checks if user is stored in the file' do
    user.email = 'ricardas9000@gmail.com'
    user.create
    user1 = user
    YAML.load_stream(File.open('users.yaml')) do |users|
      user1 = users if users.email.eql?('ricardas9000@gmail.com')
    end
    expect(user1.email).to eq('ricardas9000@gmail.com')
    described_class.delete(user.email)
  end

  it 'checks if user with same email cannot be stored in the file' do
    user.email = 'ricardas1234@gmail.com'
    user.create
    user2 = described_class.new('Rokas', 'Tadas')
    user2.email = 'ricardas1234@gmail.com'
    user2.create
    user1 = user
    YAML.load_stream(File.open('users.yaml')) do |users|
      user1 = users if users.email.eql?('ricardas1234@gmail.com')
    end
    expect(user.name).to eq('Ricardas')
    described_class.delete(user.email)
  end

  it 'deletes' do
    user.email = 'ricardas112@gmail.com'
    user.create
    described_class.delete(user.email)
    users = described_class.new('Tadas', 'Tadasas')
    YAML.load_stream(File.open('users.yaml')) do |user_obj|
      users = user_obj
    end
    expect(users.email).not_to eq('ricardas112@gmail.com')
  end

  it 'gets by email' do
    user.email = 'ricardas2000@gmail.com'
    user.create
    user1 = described_class.get_by_email('ricardas2000@gmail.com')
    expect(user1.email).to eq(user.email)
    described_class.delete(user.email)
  end
end
