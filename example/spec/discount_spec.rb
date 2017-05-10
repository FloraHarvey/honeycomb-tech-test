require './models/discount'
require './models/delivery'

describe Discount do

  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }
  let(:example_items1) { [['Sky', standard_delivery], ['Disney', standard_delivery]] }
  let(:example_items2) { [['Sky', express_delivery], ['Disney', express_delivery]] }
  let(:example_items3) { [['Sky', standard_delivery]] }
  let(:example_items4) { [['Sky', standard_delivery], ['Disney', express_delivery], ['Discovery', standard_delivery]] }


  describe 'defining a new discount' do

    it 'receives parameters defining details of percent-off discount' do
      discount = Discount.new(:percent_off, 10)
      expect(discount.applies?(20, example_items1)).to eq(true)
    end

    it 'receives parameters defining details of the delivery price reduction discount' do
      discount = Discount.new(:delivery_price_reduction, 15, :express)
      expect(discount.applies?(40, example_items4)).to eq(true)
    end
  end

  describe 'setting conditions for discount' do

    context 'percent_off' do

      it 'checks if discount applies based on conditions set' do
        discount = Discount.new(:percent_off, 10)
        discount.define_min_spend(30)
        expect(discount.applies?(20, example_items1)).to eq(false)
        expect(discount.applies?(40, example_items1)).to eq(true)
      end
    end

    context 'delivery price reduction' do

      it 'checks if discount applies based on conditions set' do
        discount = Discount.new(:delivery_price_reduction, 15, :express)
        discount.define_min_deliveries(2)
        expect(discount.applies?(30, example_items1)).to eq(false)
        expect(discount.applies?(30, example_items2)).to eq(true)
        expect(discount.applies?(30, example_items3)).to eq(false)
      end
    end
  end

  describe 'calculating discount' do
    context 'discount applies' do
      it 'calculates a delivery discount for 2 express deliveries' do
        discount = Discount.new(:delivery_price_reduction, 15, :express)
        discount.define_min_deliveries(2)
        expect(discount.calculate(40, example_items2)).to eq(10)
      end

      it 'calculates a delivery discount for given minimum spend' do
        discount = Discount.new(:delivery_price_reduction, 15, :express)
        discount.define_min_spend(20)
        expect(discount.calculate(40, example_items4)).to eq(5)
      end

      it 'calculates a percent off discount for a given number of deliveries' do
        discount = Discount.new(:percent_off, 10, :express)
        discount.define_min_deliveries(2)
        expect(discount.calculate(40, example_items2)).to eq(4)
      end

      it 'calculates a percent off discount for a given minimum spend' do
        discount = Discount.new(:percent_off, 10)
        discount.define_min_spend(30)
        expect(discount.calculate(40, example_items4)).to eq(4)
      end
    end

    context 'discount does not apply' do

      it 'calculates delivery discount as 0 if specified conditions have not been met' do
        discount = Discount.new(:delivery_price_reduction, 15, :express)
        discount.define_min_deliveries(2)
        expect(discount.calculate(40, example_items4)).to eq(0)
      end

      it 'calculates percent off discount as 0 if specified conditions have not been met' do
        discount = Discount.new(:percent_off, 10)
        discount.define_min_spend(30)
        expect(discount.calculate(10, example_items3)).to eq(0)
      end
    end

  end


end
