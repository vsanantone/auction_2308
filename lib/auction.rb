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

  def bidders
    bi = []
    @items.each do |item|
      item.bids.keys.each do |key|
      bi  << key.name
      end
    end  
    bi
  end

  def bidder_info
    bi = Hash.new { |hash_name, key| hash_name[key] = {budget: 0, items: []} }
    @items.each do |item|
      item.bids.each do |bidder, bid|
        # require 'pry'; binding.pry
        bi[bidder][:budget] = bidder.budget
        bi[bidder][:items] << item
      end
    end
    bi
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

