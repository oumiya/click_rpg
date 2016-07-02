require_relative 'Weapon_Data.rb'

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
  attr_accessor :hair              # 髪型
  attr_accessor :hair_color        # 髪の色
  attr_accessor :skin_color        # 肌の色
  attr_accessor :have_hair         # 所持している髪型
  attr_accessor :equip_weapon      # 装備している武器
  attr_accessor :equip_armor       # 装備している防具
  attr_accessor :have_weapon       # 所持している武器
  attr_accessor :have_armor        # 所持している防具
  
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
    @hair = "none"
    @hair_color = "black"
    @skin_color = 2
    @have_hair = Array.new
    @have_hair.push(@hair)
    @equip_weapon = -1
    @equip_armor = -1
    @have_weapon = Array.new
    @have_armor = Array.new
    for i in 0..49 do
      @have_weapon.push([i, 0])
      @have_armor.push([i, 0])
    end

    # 経験値テーブルの作成
    @exp_table = Array.new(MAX_LEVEL)
    base_value = 10  # 基本増加量
    base_rate = 1.15 # 基本増加率
    @exp_table[0] = 10
    
    for i in 1..@exp_table.length-1 do
      @exp_table[i] = (@exp_table[i-1] * base_rate + base_value).round
    end
  end
  
  def ATK()
    if @equip_weapon >= 0 then
      value = $weapondata.get_weapon_data(@equip_weapon)[:value]
      return @attack + value
    else
      return @attack
    end
  end
  
  def DEF()
    if @equip_armor >= 0 then
      value = $armordata.get_armor_data(@equip_armor)[:value]
      return @defence + value
    else
      return @defence
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