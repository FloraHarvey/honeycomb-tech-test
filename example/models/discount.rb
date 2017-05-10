class Discount

  def initialize(type, discount, delivery_type = :none)
    self.type = type
    self.discount = discount
    self.delivery_type = delivery_type
  end

  def define_min_spend(min_spend)
    self.min_spend = min_spend
  end

  def define_min_deliveries(min_deliveries)
    self.min_deliveries = min_deliveries
  end

  def applies?(total_cost, items)
    no_discount_conditions? ||
    min_spend_met?(total_cost) ||
    min_deliveries_met?(items)
  end

  def calculate(total_cost, items)
    if applies?(total_cost, items)
      check_discount_type(total_cost, items)
    else
      0
    end
  end

  private

  attr_accessor :type, :discount, :delivery_type, :min_spend, :min_deliveries

  def no_discount_conditions?
    !min_spend && !min_deliveries
  end

  def min_spend_met?(total_cost)
    !!min_spend && total_cost > min_spend
  end

  def min_deliveries_met?(items)
    !!min_deliveries && applicable_deliveries(items).count >= min_deliveries
  end

  def check_discount_type(total_cost, items)
    if type === :percent_off
      calculate_percent_off_discount(total_cost)
    elsif type === :delivery_price_reduction
      calculate_delivery_reduction_discount(items)
    end
  end

  def applicable_deliveries(items)
    items.select { |item|
      item[1].name === delivery_type
    }
  end

  def calculate_delivery_reduction_discount(items)
    deliveries = applicable_deliveries(items)
    price_difference = deliveries.first[1].price - discount
    deliveries.count * price_difference
  end

  def calculate_percent_off_discount(total_cost)
    total_cost / discount.to_f
  end

end
