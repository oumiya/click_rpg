# プレイヤークラス
class Player
  attr_accessor :level             # レベル
  attr_accessor :max_hp            # 最大HP
  attr_accessor :hp                # 現在のHP
  attr_accessor :attack            # 攻撃力
  attr_accessor :defence           # 防御力
  attr_accessor :heal_count        # 薬草の数
  attr_accessor :exp               # 経験値
  attr_accessor :gold              # 所持金
  
  MAX_LEVEL = 100 # プレイヤーの最大レベル
  
  def initialize()
    # 初期化
    @level = 1
    @max_hp = 100
    @hp = @max_hp
    @attack = 20
    @defence = 15
    @heal_count = 5
    @exp = 0
    @gold = 0
  
    # 経験値テーブルの作成
    @exp_table = Array.new(MAX_LEVEL)
    base_value = 10  # 基本増加量
    base_rate = 1.15 # 基本増加率
    @exp_table[0] = 10
    
    for i in 1..@exp_table.length-1 do
      @exp_table[i] = (@exp_table[i-1] * base_rate + base_value).round
    end
  end
  
  # レベルアップ処理
  # レベルアップした場合は true を返す していない場合は false を返す
  def level_up?()
  
    result = false
    
    for i in @level-1..@exp_table.length-1 do
      if exp >= @exp_table[i] then
        @level = i + 2
        result = true
        status_up()
      end
    end
    
    return result
    
  end
  
  # レベルアップ時のステータスアップ
  def status_up()
    @max_hp += 25             # 固定で 25 上昇する
    @attack +=  (1 + rand(2)) # 1 ～ 2 上昇する
    @defence += (1 + rand(2)) # 1 ～ 2 上昇する
  end
  
  # 次のレベルアップまでに必要な経験値
  def get_next_level_exp()
    if @level >= MAX_LEVEL then
      return 0
    else
      diff = @exp_table[@level-1] - @exp
      return diff
    end
  end
end