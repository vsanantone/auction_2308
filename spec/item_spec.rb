require './lib/item'
require './lib/attendee'


RSpec.describe Item do
  before(:each) do
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
  end

  describe '#initialize' do
    it 'exists' do
      expect(@item1).to be_a(Item)
    end

    it 'has a name and no bids' do
      expect(@item1.name).to eq("Chalkware Piggy Bank")
      expect(@item1.bids).to eq({})
    end
  end
  
  describe '#add_bid' do
    it 'adds a bid' do
      @item1.add_bid(@attendee1, 20)
      @item1.add_bid(@attendee2, 22)
      expect(@item1.bids).to eq({@attendee1 => 20, @attendee2 => 22})
    end
  end

  describe "#current_high_bid" do
    it 'returns the highest bid on an item' do
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      expect(@item1.current_high_bid).to eq(22)
    end
  end

  describe "#close_bidding" do
    it 'freezes bids and accepts no more' do 
      expect(@item1.bids).to eq({})
      @item1.add_bid(@attendee1, 22)
      expect(@item1.bids).to eq({@attendee1 => 22})
      @item1.close_bidding
      @item1.add_bid(@attendee2, 20)
      expect(@item1.bids).to eq({@attendee1 => 22})
    end
  end  
end