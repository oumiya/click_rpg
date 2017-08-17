# 紙吹雪エフェクト
class Paper_Snow
  # 描画する紙吹雪の数
  PAPER_NUM = 200

  # 紙吹雪
  class Paper
    attr_accessor :image_idx
    attr_accessor :anim_idx
    attr_accessor :d
    attr_accessor :x
    attr_accessor :y
    attr_accessor :g
    
    def initialize(image_idx, anim_idx)
      @image_idx = image_idx
      @anim_idx = anim_idx
      @d = 0
      @x = 0
      @y = 0
      @g = 0
    end
  end
  
  def initialize()
    @images = Array.new
    @images[0] = Image.load_tiles("image/effect/paper_snow_00.png", 13, 1)
    @images[1] = Image.load_tiles("image/effect/paper_snow_01.png", 13, 1)
    @images[2] = Image.load_tiles("image/effect/paper_snow_02.png", 13, 1)
    @images[3] = Image.load_tiles("image/effect/paper_snow_03.png", 13, 1)
    
    @papers = Array.new(PAPER_NUM)
    
    for i in 0..@papers.size - 1 do
      paper = Paper.new(rand(4), rand(13))
      paper.x = rand(Game_Main::WINDOW_WIDTH)
      paper.y = 0 - rand(200)
      if rand(100) % 2 == 0 then
        paper.d = rand(5)
      else
        paper.d = 0 - rand(5)
      end
      paper.g = rand(3) + 2
      @papers[i] = paper
    end
  end 
  
  def draw()
    @papers.each{|paper|
      # 紙吹雪を描画
      Window.draw(paper.x, paper.y, @images[paper.image_idx][paper.anim_idx])
    }
  end
  
  def update()
    @papers.each{|paper|
      paper.x += paper.d
      paper.y += paper.g
      
      if $frame_counter % 2 == 0 then
        paper.anim_idx += 1
        if paper.anim_idx >= 13 then
          paper.anim_idx = 0
        end
      end
      
      if rand(60) == 10 then
        paper.d *= -1
      end
      
      if paper.x < -16 || paper.x > Game_Main::WINDOW_WIDTH + 16 then
        paper.x = rand(Game_Main::WINDOW_WIDTH)
        paper.y = 0 - rand(200)
      end
      
      if paper.y > Game_Main::WINDOW_HEIGHT + 16 then
        paper.y = 0 - rand(200)
      end
    }
  end
  
  def dispose()
    @images.each{|i|
      i.each{|n|
        n.dispose
      }
    }
  end
end