# 施設クラス
class Facility
  attr_accessor :population
  attr_accessor :food
  attr_accessor :add_population
  attr_accessor :add_food
  attr_accessor :add_income
  attr_accessor :price
  
  def initialize(id)
    case id
    when 1
      # 農家
      @population = 0
      @food = 0
      @add_population = 5
      @add_food = 5
      @add_income = 30
      @price = 300
    when 2
      # 住宅
      @population = 0
      @food = 1
      @add_population = 10
      @add_food = 0
      @add_income = 170
      @price = 500
    when 3
      # 商店
      @population = 50
      @food = 1
      @add_population = 5
      @add_food = 0
      @add_income = 300
      @price = 1000
    when 4
      # 食料品店
      @population = 50
      @food = 0
      @add_population = 10
      @add_food = 50
      @add_income = 300
      @price = 2000
    when 5
      # 高級住宅
      @population = 100
      @food = 10
      @add_population = 10
      @add_food = 0
      @add_income = 1500
      @price = 3500
    else
      # 草原
      @population = 0
      @food = 0
      @add_population = 0
      @add_food = 0
      @add_income = 0
      @price = 0
    end
  end
end