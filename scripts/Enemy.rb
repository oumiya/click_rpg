# 敵クラス 今は単なる構造体みたいになっているが
class Enemy
  attr_accessor :id                # モンスターID
  attr_accessor :image_file_name   # 画像ファイル名
  attr_accessor :name              # モンスター名
  attr_accessor :description       # 説明
  attr_accessor :max_hp            # 最大HP
  attr_accessor :hp                # 現在のHP
  attr_accessor :attack            # 攻撃力
  attr_accessor :defence           # 防御力
  attr_accessor :attack_frequency  # 攻撃頻度（フレーム単位）※ 配列
  attr_accessor :ai                # AIタイプ(0: 攻撃頻度に忠実 1:ランダムに攻撃）
  attr_accessor :attack_index      # 攻撃頻度のどれを選ぶかのインデックス
  attr_accessor :attack_speed      # 攻撃速度
  attr_accessor :image             # 敵画像
  attr_accessor :sx                # 当たり判定左上 X座標
  attr_accessor :sy                # 当たり判定左上 Y座標
  attr_accessor :ex                # 当たり判定右上 X座標
  attr_accessor :ey                # 当たり判定右下 Y座標
  attr_accessor :exp               # 経験値
  attr_accessor :gold              # 所持金
  attr_accessor :die_effects       # 死亡エフェクト画像配列
  attr_accessor :effect_index      # 死亡エフェクトカウンター
  
  def initialize()
    @attack_index = 0
  end
  
  def attack_frame?()
    freq = 0
    
    if @ai == 0 then
      freq = @attack_frequency[@attack_index]
      @attack_index += 1
      if @attack_index >= @attack_frequency.size then
        @attack_index = 0
      end
    else
      if @attack_frequency.size > 1 then
        freq = @attack_frequency[rand(@attack_frequency.size)]
      else
        freq = @attack_frequency[0]
      end
    end
    
    result = false
    
    if $frame_counter % freq == 0 then
      result = true
    end
    
    return result
    
  end
  
  # 当たり判定を計算して sx, sy と ex, ey に値を入れる
  def calc_hitbox()
    min_x = @image.width-1
    min_y = @image.height-1
    max_x = 0
    max_y = 0
    
    for x in 0..@image.width-1 do
      for y in 0..@image.height-1 do
        if @image[x, y] != [0, 0, 0, 0] then
          if x > max_x then
            max_x = x
          end
          if y > max_y then
            max_y = y
          end
          if x < min_x then
            min_x = x
          end
          if y < min_y then
            min_y = y
          end
        end
      end
    end
    
    @sx = min_x
    @sy = min_y
    @ex = max_x
    @ey = max_y
  end
  
  # 死亡時エフェクトの画像を作成
  def create_die_effect()
    @die_effects = Array.new(10)
    alpha = 255
    
    for i in 0..@die_effects.length-1 do
      @die_effects[i] = @image.flush([alpha, 255, 0, 0])
      alpha -= 26
      if alpha < 0 then
        alpha = 0
      end
    end
  end
end