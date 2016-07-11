require 'dxruby'

# キラキラエフェクト
class Sparkly
  # 描画するキラキラの数
  SPARK_NUM = 200

  # キラキラ
  class Spark
    attr_accessor :image
    attr_accessor :scale_rate
    attr_accessor :x
    attr_accessor :y
    
    def initialize(image)
      @image = image
    end
    
    def dispose
      @image.dispose
    end
  end
  
  def initialize()
    @images = Array.new
    @images[0] = Image.load("image/effect/light-001.png")
    @images[1] = Image.load("image/effect/light-002.png")
    @images[2] = Image.load("image/effect/light-003.png")
    @images[3] = Image.load("image/effect/light-004.png")
    @images[4] = Image.load("image/effect/light-005.png")
    @images[5] = Image.load("image/effect/light-006.png")
    @images[6] = Image.load("image/effect/light-007.png")
    @images[7] = Image.load("image/effect/light-008.png")
    
    @sparkles = Array.new(SPARK_NUM)
    
    for i in 0..@sparkles.size - 1 do
      spark = Spark.new(@images[i % 8])
      spark.x = rand(Game_Main::WINDOW_WIDTH)
      spark.y = rand(Game_Main::WINDOW_HEIGHT)
      spark.scale_rate = rand()

      if spark.scale_rate < 0.3 then
        spark.scale_rate = 0.3
      end
      @sparkles[i] = spark
    end
  end 
  
  def draw()
    @sparkles.each{|spark|
      # キラキラを描画
      Window.draw_scale(spark.x, spark.y, spark.image, spark.scale_rate, spark.scale_rate)
      spark.y -= 8
      if spark.y < 0 - (spark.image.height * spark.scale_rate).round then
        spark.y = Game_Main::WINDOW_HEIGHT
      end
    }
  end
  
  def dispose()
    @images.each{|i|
      i.dispose
    }
  end
end