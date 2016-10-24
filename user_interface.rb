require './user.rb'
# This class defines user interface
=begin
user = User.new
puts 'Enter your name'
user.name = gets
puts 'Enter your surname'
user.surname = gets
puts 'Enter your date of birth'
user.birth_date = gets
puts 'Enter you email address'
user.email = gets
puts 'Enter your password'
user.password = gets

puts

puts user.name
puts user.surname
puts user.birth_date
puts user.email
puts user.password

user = User.new
begin
puts 'Enter your emial'
user.email = gets
end while not user.email
puts user.email
=end