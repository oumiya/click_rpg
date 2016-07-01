# アタックアイコン
class Attack_Icon
  attr_accessor :x       # アタックアイコンの左上X座標
  attr_accessor :y       # アタックアイコンの左上Y座標
  attr_accessor :visible  # 表示状態 true or false
  
  def initialize()
    @x = 670
    @y = 398
    @visible = false
  end
  
  # アタックアイコンを非表示にして初期位置に戻す
  def die()
    @x = 670
    @y = 398
    @visible = false
  end
end