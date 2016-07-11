# 1ウェーブの結果を格納する
class Wave_Result
  # 戦闘回数
  attr_accessor :battle_count
  # 合計経験値
  attr_accessor :exp
  # 合計金額
  attr_accessor :gold
  
  def initialize()
    @battle_count = 0
    @exp = 0
    @gold = 0
  end
end