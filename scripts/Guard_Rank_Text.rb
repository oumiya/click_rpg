# ガード評価テキストを表示するためのクラス
class Guard_Rank_Text
  attr_accessor :frame
  attr_accessor :rank
  attr_accessor :visible
  SHOW_FRAME = 30
  
  def initialize()
    @perfect = Image.load("image/system/perfect.png")
    @good = Image.load("image/system/good.png")
    @poor = Image.load("image/system/poor.png")
    @visible = false
  end
  
  def set_rank(r)
    @rank = r
    @frame = 0
    @visible = true
  end
  
  def update()
    if @visible then
      case @rank
      when "perfect"
        Window.draw(288, 367, @perfect)
      when "good"
        Window.draw(288, 367, @good)
      when "poor"
        Window.draw(288, 367, @poor)
      end
      @frame += 1
      if @frame > 30 then
        @visible = false
      end
    end
  end
end