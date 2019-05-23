class Cart
  attr_reader :contents
  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def empty?; return @contents.empty? end

  def add(id, quantity)
    @contents[id] = quantity
  end

  def quantity
    @contents.values.map(&:to_i).sum
  end

  def items
    return Hash[@contents.map {|item_id, item_quantity| [Item.find(item_id), item_quantity]}]
  end
end
