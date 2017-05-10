require './models/broadcaster'
require './models/delivery'
require './models/material'
require './models/order'
require './models/discount'


describe Order do
  let(:order) { Order.new material }
  let(:material) { Material.new 'HON/TEST001/010' }
  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }

  context 'empty' do
    it 'costs nothing' do
      expect(order.total_cost_with_discount).to eq(0)
    end
  end

  context 'with items' do
    broadcaster_1 = Broadcaster.new(1, 'Viacom')
    broadcaster_2 = Broadcaster.new(2, 'Disney')
    broadcaster_3 = Broadcaster.new(3, 'Discovery')

    context 'no discount' do
      it 'returns the total cost of all items' do
        order.add broadcaster_1, standard_delivery
        order.add broadcaster_2, express_delivery

        expect(order.total_cost_with_discount).to eq(30)
      end
    end

    context 'with percent off discount' do
      it 'applies a discount if specified' do
        spend30 = Discount.new(:percent_off, 10)
        spend30.define_min_spend(30)

        order = Order.new(material, [spend30])
        order.add broadcaster_1, standard_delivery
        order.add broadcaster_2, express_delivery
        order.add broadcaster_3, standard_delivery

        expect(order.total_cost_with_discount).to eq(36)
      end
    end

    context 'with delivery discount' do
      it 'applies a discount if specified' do
        express15 = Discount.new(:delivery_price_reduction, 15, :express)
        express15.define_min_deliveries(2)

        order = Order.new(material, [express15])
        order.add broadcaster_1, standard_delivery
        order.add broadcaster_2, express_delivery
        order.add broadcaster_3, express_delivery

        expect(order.total_cost_with_discount).to eq(40)
      end
    end

  end
end
