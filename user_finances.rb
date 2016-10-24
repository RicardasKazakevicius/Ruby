# This class defines how much money user has to pay for rent
class UserFinances
  attr_reader :amount_to_pay

  def initialize
    @amount_to_pay = 0
  end

  def amount_to_pay=(amount_to_pay)
    @amount_to_pay += amount_to_pay
  end
end
