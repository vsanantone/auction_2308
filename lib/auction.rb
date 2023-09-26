class Auction
  attr_reader :items

  def initialize
    @items = []
  end

  def add_item(item)
    @items << item
  end

  def item_names
    @items.map(&:name)
  end

  def unpopular_item
    @items.select { |item| item.bids.empty? }
  end
  
  def potential_revenue
    pr = []
    @items.each do |item|
      pr << item.current_high_bid
    end
    pr.compact.sum
  end
  

end












  # def unpopular_item
  #   ui = []
  #   @items.each do |item| 
  #   if item.bids == {}
  #   ui << item
  #     end
  #   end
  #   ui
  # end

