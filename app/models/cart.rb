class Cart
  attr_reader :contents
  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def empty?; return @contents.empty? end

  def add(id, quantity)
    if quantity == 0
      @contents.delete(id)
    else
      @contents[id] = quantity
    end
  end

  def quantity
    @contents.values.map(&:to_i).sum
  end

  def quantity_of(id)
    return @contents[id] || 0
  end

  def items
    return Hash[@contents.map {|id,qnt| [Item.find(id), qnt]}]
  end
end
