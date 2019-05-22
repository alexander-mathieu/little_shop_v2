class Cart
  attr_reader :contents
  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def items
    return @contents.map do |k,v|
      Item.find(k)
    end
  end
end