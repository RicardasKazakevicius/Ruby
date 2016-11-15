require 'yaml'
require './user.rb'
require './vehicle.rb'
require './rent.rb'
require './insurance.rb'
# This class defines user interface
# to eql, to be_nil, to have_attributes,
# to change, to contain_exactly
=begin
loged_in = false
puts 'Enter 1 to log in'
puts 'Enter 2 to sign in'
puts 'Enter 0 to end program'
case gets.to_i
when 1

  puts 'Log in'
  puts 'Enter your name'
  name = gets.chomp

  puts 'Enter your surname'
  surname = gets.chomp

  user = User.new(name, surname)

  puts 'Enter your date of birth'
  user.birth_date = gets.chomp

  puts 'Enter your email'
  user.email = gets.chomp

  puts 'Enter your password'
  user.password = gets.chomp
  user.create

when 2
  puts 'Sign in'
  puts 'Enter your email'
  email = gets.chomp.to_s
  user = User.get_by_email(email)
  if user.email.eql?(email)
    puts 'Enter your password'
    password = gets.chomp.to_s
    if user.password.eql?(password)
      loged_in = true
      puts
      puts 'Successfuly loged in'
    else
      puts 'Wrong password'
    end
  else
    puts "No user with #{email} email found"
  end
when 0
  puts 'Program end'
  exit
end

if loged_in.eql?(true)
  start = false
  vehicle_selected = false
  time_selected = false
  until start
    puts
    puts 'Enter 1 to select vehicle you want to rent'
    puts 'Enter 2 to select rent time'
    puts 'Enter 3 to start rent' if time_selected && vehicle_selected
    puts 'Enter 0 to end program'

    case gets.to_i

    when 1
      number = 0
      puts
      Vehicle.not_reserved.each do |vehicle|
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
      vehicle_selected = true

    when 2
      rent = Rent.new
      puts 'Enter time when you want to start your rent'
      time = Time.new
      time.start_at = gets
      puts 'Enter time when you want to end your rent'
      time.end_at = gets

      rent.duration = time
      time_selected = true

      puts 'Your selected rent duration is:'
      print rent.duration
      puts ' hours'

    when 3
      start = true
      rent.vehicle_price = vehicle.price_for_hour

      vehicle = Vehicle.get_by_number(gets.to_i)
      puts 'Your selected vehicle is: '
      puts vehicle.make
      puts vehicle.model

      print 'Price to pay: '
      puts rent.price

    when 0
      puts 'Program end'
      exit
    end
  end
end

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

vehicle1 = Vehicle.new('AAS:332')
vehicle1.make = 'Subaru'
vehicle1.model = 'Forester'
vehicle1.year = '2008-01-11'
vehicle1.price_for_hour = 8
vehicle1.create

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
