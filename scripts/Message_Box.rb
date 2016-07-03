require 'dxruby'

# テキストを画面に表示するためのモジュール
module Message_Box

  MARGIN = 16

  # 指定した文章をメッセージボックスに表示します
  def show(text, x=-1, y=-1, font = Font.new(32))
    width = font.get_width(text)
    width += MARGIN * 2
    height = font.size
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
    Window.draw_font(x + MARGIN, y + MARGIN, text, font, {:z=>1103})
  end
  
  module_function :show
end