require './models/discount'
require './models/delivery'

describe Discount do

  let(:standard_delivery) { Delivery.new(:standard, 10) }
  let(:express_delivery) { Delivery.new(:express, 20) }
  let(:example_items1) { [['Sky', standard_delivery], ['Disney', standard_delivery]] }
  let(:example_items2) { [['Sky', express_delivery], ['Disney', express_delivery]] }
  let(:example_items3) { [['Sky', standard_delivery]] }


  describe 'defining a new discount' do

    it 'receives parameters defining details of percent-off discount' do
      discount = Discount.new(:percent_off, 10)
      expect(discount.calculate(20, example_items1)).to eq(2)
    end

    it 'receives parameters defining details of the delivery price reduction discount' do
      discount = Discount.new(:delivery_price_reduction, 15, :express)
      expect(discount.calculate(40, example_items2)).to eq(10)
    end

    describe 'setting conditions for discount' do

      context 'percent_off' do

        it 'can have conditions set for which it applies' do
          discount = Discount.new(:percent_off, 10)
          discount.define_min_spend(30)
          expect(discount.applies?(20, example_items1)).to eq(false)
          expect(discount.applies?(40, example_items1)).to eq(true)
        end
      end

      context 'certain number of items' do

        it 'receives parameters defining details of the discount' do
          discount = Discount.new(:delivery_price_reduction, 15, :express)
          discount.define_min_deliveries(2)
          expect(discount.applies?(30, example_items1)).to eq(false)
          expect(discount.applies?(30, example_items2)).to eq(true)
          expect(discount.applies?(30, example_items3)).to eq(false)
        end
      end
    end

  end


end
