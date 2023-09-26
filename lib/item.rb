class Item
  attr_reader :name, :bids

  def initialize(name)
    @name = name
    @bids = {}
    
  end

  def add_bid(bidder, bid)
    bids[bidder] = bid
  end

  def current_high_bid
    @bids.values.max
  end

  def close_bidding
    @bids.each do |bidder, bid|
      bidder.freeze
      bid.freeze
    end
  end
end
