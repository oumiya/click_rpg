require 'dxruby'

# ガード評価テキストを表示するためのクラス
class Attack_Effect
  attr_accessor :visible
  attr_accessor :frame_count
  
  def initialize()
    @frames = Image.load_tiles("image/animation/sword001.png", 5, 2)
    @frame_count = 0
    @index = 0
    @visible = false
  end
  
  def show()
    @visible = true
    @frame_count = 0
    @index = 0
  end
  
  def hidden()
    @visible = false
  end
  
  def update()
    if @visible then
      Window.draw(237, 72, @frames[@index], 100)
      @frame_count += 1
      if @frame_count % 2 == 0 then
        @index += 1
        
        if @index > 9 then
          hidden()
        end
      end
    end
  end
end