require 'dxruby'

# テキストを画面に表示するためのモジュール
module Message_Box
  
  @@font = Font.new(32)
  
  MARGIN = 16

  # 指定した文章をメッセージボックスに表示します
  def show(text, x=-1, y=-1, font = @@font)
    lines = text.split("<br>")
    line_height = font.size / 4
    
    height = 0
    width = 0
    
    if lines.size > 1 then
      width_max = 0
      lines.each{|line|
        width = font.get_width(line)
        if width > width_max then
          width_max = width
        end
      }
      width = width_max
      height = (font.size + line_height) * lines.size
      height -= line_height
    else
      width = font.get_width(text)
      height = font.size
    end
    
    width += MARGIN * 2
    height += MARGIN * 2
    
    if x == -1 then
      x = Game_Main::WINDOW_WIDTH / 2 - width / 2
    end
    if y == -1 then
      y = Game_Main::WINDOW_HEIGHT / 2 - height / 2
    end
    
    # まず黒地を描く
    Window.draw_box_fill(x, y, x + width, y + height, [0, 0, 0], 1100)
    # 白線を描画
    Window.draw_box(x + 2, y + 2, x + width - 2, y + height - 2, [255, 255, 255], 1101)
    Window.draw_box(x + 3, y + 3, x + width - 3, y + height - 3, [255, 255, 255], 1102)
    
    # テキストを描画
    x = x + MARGIN
    y = y + MARGIN
    
    lines.each{|line|
      Window.draw_font(x, y, line, font, {:z=>1103})
      y += font.size + line_height
    }
  end
  
  module_function :show
end