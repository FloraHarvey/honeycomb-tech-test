class Order
  COLUMNS = {
    broadcaster: 20,
    delivery: 8,
    price: 8
  }.freeze

  def initialize(material, discounts_array = [])
    self.material = material
    self.items = []
    self.discounts = discounts_array
  end

  def add(broadcaster, delivery)
    items << [broadcaster, delivery]
  end

  def total_cost_with_discount
    order_total = total_cost_before_discount
    i = 0
    while i < discounts.count do
      discount = discounts[i].calculate(order_total, items)
      order_total -= discount
      i += 1
    end
    order_total
  end

  def output
    [].tap do |result|
      result << "Order for #{material.identifier}:"
      result << COLUMNS.map { |name, width| name.to_s.ljust(width) }.join(' | ')
      result << output_separator
      result << output_items
      result << output_separator
      result << "Promotion applied!" if total_cost_with_discount != total_cost_before_discount
      result << "Total: $#{'%.2f' % total_cost_with_discount}"
    end.join("\n")
  end

  private

  attr_accessor :material, :items, :discounts

  def total_cost_before_discount
    items.inject(0) { |memo, (_, delivery)| memo += delivery.price }
  end

  def output_separator
    @output_separator ||= COLUMNS.map { |_, width| '-' * width }.join(' | ')
  end

  def output_items
    [].tap do |result|
      items.each_with_index do |(broadcaster, delivery), index|
        result << [
          broadcaster.name.ljust(COLUMNS[:broadcaster]),
          delivery.name.to_s.ljust(COLUMNS[:delivery]),
          ("$#{'%.2f' % delivery.price}").ljust(COLUMNS[:price])
        ].join(' | ')
      end
    end
  end

end
