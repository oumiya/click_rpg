# 選択用カーソルクラス
class Cursor
  attr_accessor :index
  attr_accessor :flash
  attr_accessor :visible
  
  def initialize(pos)
    @pos = pos
    @image = Image.load("image/system/cursor.png")
    @visible = true
    @flash = false
    @index = 0
  end
  
  def update()
    if @visible then
      draw()
    end
  end
  
  def draw()
    if @flash then
      if $frame_counter % 6 > 2 then
        Window.draw(@pos[@index][0], @pos[@index][1], @image, 2000)
      end
    else
      Window.draw(@pos[@index][0], @pos[@index][1], @image, 2000)
    end
  end
end