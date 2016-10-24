require 'yaml'
require './user.rb'
require './vehicle.rb'
require './rent.rb'
# This class defines user interface
puts
puts 'Select vehicle you want to rent:'

number = 0
Vehicle.list.each do |vehicle|
  puts number += 1
  puts vehicle.make
  puts vehicle.model
  print 'price for hour: '
  puts vehicle.price_for_hour
end

vehicle = Vehicle.get_by_number(gets.to_i)
puts 'Your selected vehicle is: '
puts vehicle.make
puts vehicle.model

=begin
number = 0
pos = gets.to_i
Vehicle.list.each do |vehicle_list|
  number += 1
  vehicle = vehicle_list if pos == number
end
puts vehicle.make

rent = Rent.new
rent.vehicle_price = vehicle.price_for_hour

puts 'Enter time when you want to start your rent'
time = Time.new
time.start_at = gets
puts 'Enter time when you want to end your rent'
time.end_at = gets

rent.duration = time

puts 'Your selected vehicle selected is'
puts vehicle.make
puts vehicle.model
print 'Price to pay: '
puts rent.price

vehicle9 = Vehicle.new('LEK:911')
vehicle9.make = 'Lexus'
vehicle9.model = 'IS300'
vehicle9.year = '2002-10-10'
vehicle9.price_for_hour = 7
vehicle9.create

vehicle2 = Vehicle.new('AKL:340')
vehicle2.make = 'Honda'
vehicle2.model = 'Accord'
vehicle2.year = '2010-02-11'
vehicle2.price_for_hour = 10
vehicle2.create

vehicle4 = Vehicle.new('KKA:312')
vehicle4.make = 'Fiat'
vehicle4.model = '500'
vehicle4.year = '2011-10-21'
vehicle4.price_for_hour = 5
vehicle4.create

vehicle2.delete
print_vehicles
puts 'Enter 1 to log in'
puts 'Enter 2 to sign in'
puts 'Enter 0 to end program'

signed_in = false
case gets.to_i
when 1

user = User.new

puts 'Log in'
puts 'Enter your name'
user.name = gets

puts 'Enter your surname'
user.surname = gets

puts 'Enter your date of birth'
user.birth_date = gets

puts 'Enter your emial'
user.email = gets

puts 'Enter your password'
user.password = gets

when 2
puts 'Sign in'
puts 'Enter your email and password'
email = gets
password = gets
if user.email == email && user.password == password
puts 'OK'
else
puts 'Not OK..'
end

when 0
puts 'Program end'
exit
end

if signed_in
puts 'Enter 1 to select vehicle'
puts 'Enter 0 to end program'

puts 'Select vehicle'
@i = 0
vehicles.list.each do |vehicle|
puts @i
puts vehicle.make
puts vehicle.model
puts vehicle.year
@i += 1
puts
end

puts 'Enter 1 to create vehicle'
case gets.to_i
when 1
puts 'Enter license number'
vehicle = Vehicle.new(gets)
puts 'Enter make'
vehicle.make = gets
puts 'Enter model'
vehicle.model = gets
puts 'Enter date of manufacture'
vehicle.year = gets.to_s
puts 'Enter rent price for hour'
vehicle.price_for_hour = gets
end


vehicle9 = Vehicle.new('LEK:911')
vehicle9.make = 'Lexus'
vehicle9.model = 'IS300'
vehicle9.year = '2002-10-10'
vehicle9.price_for_hour = 7
vehicle9.create

vehicle1 = Vehicle.new('AAS:332')
vehicle1.make = 'Subaru'
vehicle1.model = 'Forester'
vehicle1.year = '2008-01-11'
vehicle1.price_for_hour = 8
vehicle1.create

vehicle2 = Vehicle.new('AKL:340')
vehicle2.make = 'Honda'
vehicle2.model = 'Accord'
vehicle2.year = '2010-02-11'
vehicle2.price_for_hour = 10
vehicle2.create

vehicle7 = Vehicle.new('LTR:129')
vehicle7.make = 'Toyota'
vehicle7.model = 'Corolla'
vehicle7.year = '2016-08-24'
vehicle7.price_for_hour = 10
vehicle7.create

vehicle4 = Vehicle.new('KKA:312')
vehicle4.make = 'Fiat'
vehicle4.model = '500'
vehicle4.year = '2011-10-21'
vehicle4.price_for_hour = 5
vehicle4.create
=end
