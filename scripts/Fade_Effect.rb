require 'dxruby'

# フェードイン、フェードアウトのエフェクトを表示するクラス
class Fade_Effect
  
  def initialize()
    @frame_count = 0
    # フェードアウト用の黒い四角を準備
    @black_box = Image.new(Game_Main::WINDOW_WIDTH, Game_Main::WINDOW_HEIGHT, C_BLACK)
    @visible = false
  end
  
  # エフェクト設定
  # 0 が フェードアウト、1 がフェードイン
  def setup(effect_id)
    case effect_id
    when 0
      @alpha = 0
      @effect_id = effect_id
    when 1
      @alpha = 255
      @effect_id = effect_id
    end
    
    @frame_count = 0
    @visible = true
  end
  
  def update()
    if @visible then
      draw()
    end
  end
  
  # エフェクトの描画が終了した？
  def effect_end?()
    
    if @visible then
      if @frame_count > 60 then
        @visible = false
        @frame_count = 0
        return true
      end
    else
      @visible = false
      return true
    end
    
    return false
  end
  
  def draw()
    Window.draw_alpha(0, 0, @black_box, @alpha, 5000)
    
    if @effect_id == 0 then
      @alpha += 4
      if @alpha >= 240 then
        @alpha = 255
      end
    else
      @alpha -= 4
      if @alpha < 0 then
        @alpha = 0
      end
    end
    
    @frame_count += 1
  end

end