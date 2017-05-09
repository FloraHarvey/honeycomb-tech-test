class Discount

  def initialize(type, discount)
    @type = type
    @discount = discount
  end

  def calculate(total_cost)
    total_cost / @discount
  end

  def define_condition(property, min_amount)
    @property = property
    @min_amount = min_amount
  end

  def applies?(total_cost)
    @property === :total && total_cost > @min_amount
  end

end
