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
  attr_accessor :attack_frequency  # 攻撃頻度（フレーム単位）
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