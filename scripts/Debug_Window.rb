require 'dxruby'

# デバッグ情報を表示するウィンドウ
class Debug_Window
  attr_accessor :visible
  
  def initialize()
    @font = Font.new(18)
    @lines = Array.new(10, "test")
    @index = 0
    @visible = false
  end
  
  def puts(text)
    if @index >= @lines.length then
      for i in 0..@lines.length-2 do
        @lines[i] = @lines[i+1]
      end
      @index = @lines.length - 1
    end
    
    @lines[@index] = text
    @index += 1
  end
  
  def draw()
    if @visible == true then
      x = 5
      y = 5
      @lines.each{|line|
        Window.draw_font(x, y, line, @font)
        y += 20
      }
    end
  end
end