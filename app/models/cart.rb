class Cart
  attr_reader :contents
  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def items
    return Hash[@contents.map {|k,v| [Item.find(k), v]}]
  end
end