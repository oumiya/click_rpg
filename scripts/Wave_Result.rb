# 1ウェーブの結果を格納する
class Wave_Result
  # 戦闘回数
  attr_accessor :battle_count
  # 合計経験値
  attr_accessor :exp
  # 合計金額
  attr_accessor :gold
  # ウェーブの結果 true 勝利 false 敗北
  attr_accessor :result
  
  def initialize()
    @battle_count = 0
    @exp = 0
    @gold = 0
    @result = false
  end
end