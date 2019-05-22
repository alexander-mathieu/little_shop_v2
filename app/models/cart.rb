class Cart
  attr_reader :contents
  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def empty?; return @contents.empty? end

  def add(id, quantity)
    @contents[id] = quantity
  end

  def items
    return Hash[@contents.map {|id,qnt| [Item.find(id), qnt]}]
  end
end