require './lib/auction'
require './lib/attendee'
require './lib/item'

RSpec.describe Auction do
  before(:each) do
    @auction = Auction.new
    @item1 = Item.new('Chalkware Piggy Bank')
    @item2 = Item.new('Bamboo Picture Frame')
    @item3 = Item.new('Homemade Chocolate Chip Cookies')
    @item4 = Item.new('2 Days Dogsitting')
    @item5 = Item.new('Forever Stamps')
    @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
    @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
    @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
  end

  describe '#initialize' do
    it 'exists' do
      expect(@auction).to be_a(Auction)
    end

    it 'has items' do
      expect(@auction.items).to eq([])
      
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      expect(@auction.items).to eq([@item1, @item2])
    end
  end

  describe "#item_names" do
    it 'has item names' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
    end
  end

  describe "#add_bid" do
    it 'adds a bid to an item' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      expect(@item1.bids).to eq({})
      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      expect(@item1.bids).to eq({@attendee2 => 20, @attendee1 => 22})
    end
  end

  describe "#current_high_bid" do
    it 'returns the highest bid on an item' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      expect(@item1.current_high_bid).to eq(22)
    end
  end

  describe "#unpopular_item" do
    it 'returns an array of the unpopular items' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee2, 20)
      @item1.add_bid(@attendee1, 22)
      @item4.add_bid(@attendee3, 50)
      expect(@auction.unpopular_item).to eq([@item2, @item3, @item5])

      @item3.add_bid(@attendee2, 15)
      expect(@auction.unpopular_item).to eq([@item2, @item5])
    end
  end

  describe "#bidders" do
    it 'returns an array of bidder names' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item4.add_bid(@attendee3, 50)
      expect(@auction.bidders).to eq(["Megan", "Bob", "Mike"])
    end
  end

  describe "#bidder_info" do
    it 'returns a hash of attendees with a hash of budget and items bet on for values' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee1, 22)
      @item2.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item3.add_bid(@attendee2, 15)
      @item4.add_bid(@attendee2, 15)
      @item4.add_bid(@attendee3, 50)
      expect(@auction.bidder_info).to eq({@attendee1 => {:budget => 50, :items => [@item1, @item2]}, 
      @attendee2 => {:budget => 75, :items => [@item1, @item3, @item4]}, @attendee3 => {:budget => 100, :items => [@item4]}})
    end
  end  

  describe "#close_bidding" do
    it 'freezes bids and accepts no more' do
      @auction.add_item(@item1)
      @auction.add_item(@item2)
      @auction.add_item(@item3)
      @auction.add_item(@item4)
      @auction.add_item(@item5)

      @item1.add_bid(@attendee1, 22)
      @item1.add_bid(@attendee2, 20)
      @item2.close_bidding
      @item2.add_bid(@attendee2, 24)

      expect(@auction.bidder_info).to eq({@attendee1 => {:budget => 50, :items => [@item1]}, 
      @attendee2 => {:budget => 75, :items => [@item1]}})
    end
  end  
end