# 髪型アイテム
class Hair_Item
  attr_accessor :name
  attr_accessor :price
  attr_accessor :key
  
  def initialize(name, price, key)
    @name = name
    @price = price
    @key = key
  end
end
