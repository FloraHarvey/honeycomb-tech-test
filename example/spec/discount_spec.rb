require './models/discount'

describe Discount do

  describe 'defining a new discount' do

    context 'percent_off' do

      it 'receives parameters defining details of the discount' do
        discount = Discount.new(:percent_off, 10)
        expect(discount.calculate(20)).to eq(2)
      end

      it 'can have conditions set for which it applies' do
        discount = Discount.new(:percent_off, 10)
        discount.define_condition(:total, 30)
        expect(discount.applies?(35)).to eq(true)
        expect(discount.applies?(20)).to eq(false)
      end
    end


  end


end
