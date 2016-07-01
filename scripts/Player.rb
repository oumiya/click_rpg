# プレイヤークラス
class Player
  attr_accessor :max_hp            # 最大HP
  attr_accessor :hp                # 現在のHP
  attr_accessor :attack            # 攻撃力
  attr_accessor :defence           # 防御力
  attr_accessor :heal_count        # 薬草の数
  attr_accessor :level             # レベル
  attr_accessor :exp               # 経験値
  attr_accessor :gold              # 所持金
  
  def initialize()
    # 経験値テーブル
    
  end
  
  # レベルアップ処理
  # レベルアップした場合は true を返す していない場合は false を返す
  def level_up()
    
  end
end