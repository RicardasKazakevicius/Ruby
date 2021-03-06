require './user_information.rb'
require './user_finances.rb'
# This class defines information about user
class User
  attr_reader :name, :surname

  def initialize(name, surname)
    @name = name.capitalize
    @surname = surname.capitalize
    @user_information = UserInformation.new
    @user_finances = UserFinances.new
  end

  def email=(email)
    @user_information.email = email
  end

  def password=(password)
    @user_information.password = password
  end

  def birth_date=(birth_date)
    @user_information.birth_date = birth_date
  end

  def create
    different_user = true
    YAML.load_stream(File.open('users.yaml')) do |user|
      different_user = false if user.email.eql?(email)
    end

    return unless different_user
    write_to_file
  end

  def write_to_file
    file = File.open('users.yaml', 'a+')
    YAML.dump(self, file)
    file.close
  end

  def self.list
    users = []
    YAML.load_stream(File.open('users.yaml')) do |user|
      users << user
    end
    users
  end

  def self.get_by_email(email)
    user = User.new('', '')
    YAML.load_stream(File.open('users.yaml')) do |user_obj|
      user = user_obj if user_obj.email.eql?(email)
    end
    user
  end

  def self.delete(email)
    users = User.list
    file = File.open('users.yaml', 'w')
    file.close
    users.each do |user|
      user.write_to_file unless user.email.eql?(email)
    end
  end

  def amount_to_pay=(amount_to_pay)
    @user_finances.amount_to_pay = amount_to_pay
  end

  def email
    @user_information.email
  end

  def password
    @user_information.password
  end

  def birth_date
    @user_information.birth_date
  end

  def amount_to_pay
    @user_finances.amount_to_pay
  end
end
