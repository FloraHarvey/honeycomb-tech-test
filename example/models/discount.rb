class Discount

  def initialize(type, discount, item = :none)
    @type = type
    @discount = discount
    @item = item
  end

  def calculate(total_cost, items)
    if @type === :percent_off
      total_cost / @discount
    elsif @type === :delivery_price_reduction
      calculate_delivery_reduction_discount(items)
    end
  end

  def define_min_spend(min_spend)
    @min_spend = min_spend
  end

  def define_min_deliveries(min_deliveries)
    @min_deliveries = min_deliveries
  end

  def applies?(total_cost, items)
    !@min_spend && !@min_deliveries ||
    !!@min_spend && total_cost >= @min_spend ||
    !!@min_deliveries && applicable_deliveries(items).count >= @min_deliveries
  end

  def applicable_deliveries(items)
    items.select { |item|
      item[1].name === @item
    }
  end

  def calculate_delivery_reduction_discount(items)
    deliveries = applicable_deliveries(items)
    price_difference = deliveries.first[1].price - @discount
    deliveries.count * price_difference
  end

end
