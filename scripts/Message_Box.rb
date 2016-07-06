require 'dxruby'

# テキストを画面に表示するためのモジュール
module Message_Box

  MARGIN = 16

  # 指定した文章をメッセージボックスに表示します
  def show(text, x=-1, y=-1, font = Font.new(32), alpha=255)
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
    image = Image.new(width, height)
    image.box_fill(0, 0, width - 1, height-1, [0, 0, 0])
    # 白線を描画
    image.box(2, 2, width - 3, height - 3, [255, 255, 255])
    image.box(3, 3, width - 4, height - 4, [255, 255, 255])
    
    Window.draw_alpha(x, y, image, alpha, 1100)
    
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