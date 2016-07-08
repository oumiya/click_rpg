require_relative 'Weapon_Data.rb'

# プレイヤークラス
class Player
  # フィーバー持続時間の最大値
  FEVER_MAX_FRAME = 900
  FEVER_MAX_POINT = 500
  
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
  attr_accessor :fever_point       # 現在のフィーバーポイント
  attr_accessor :fever_frame       # フィーバー持続時間（フレーム）
  attr_accessor :opening           # オープニング見た
  attr_accessor :cleared           # クリア済みフラグ
  attr_accessor :progress          # 進行度
  
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
    for i in 0..23 do
      @have_weapon.push([i, 0])
      @have_armor.push([i, 0])
    end
    @fever_point = 0
    @fever_frame = 0
    @opening = false
    @cleared = false
    @progress = 0
    

    # 経験値テーブルの作成
    @exp_table = Array.new(MAX_LEVEL)
    base_value = 10  # 基本増加量
    base_rate = 1.2 # 基本増加率
    @exp_table[0] = 10
    
    for i in 1..@exp_table.length-1 do
      @exp_table[i] = (@exp_table[i-1] * base_rate + base_value).round
    end
  end
  
  # 今現在フィーバー状態か？
  def fever?()
    if @fever_frame > 0 then
      return true
    end
    return false
  end
  
  def ATK()
    res = 0
    if @equip_weapon >= 0 then
      value = $weapondata.get_weapon_data(@equip_weapon)[:value]
      res = @attack + value
    else
      res = @attack
    end
    
    if fever?() then
      res *= 2
    end
    
    return res
  end
  
  def real_ATK()
    res = 0
    if @equip_weapon >= 0 then
      value = $weapondata.get_weapon_data(@equip_weapon)[:value]
      res = @attack + value
    else
      res = @attack
    end
    
    return res
  end
  
  def DEF()
    res = 0
    if @equip_armor >= 0 then
      value = $armordata.get_armor_data(@equip_armor)[:value]
      res = @defence + value
    else
      res = @defence
    end
    
    if fever?() then
      res *= 2
    end
    
    return res
  end
  
  def real_DEF()
    res = 0
    if @equip_armor >= 0 then
      value = $armordata.get_armor_data(@equip_armor)[:value]
      res = @defence + value
    else
      res = @defence
    end
    
    return res
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
    rate = @hp.to_f / @max_hp.to_f
    @max_hp += 25             # 固定で 25 上昇する
    @hp = @max_hp * rate
    @attack +=  (1 + rand(2)) # 1 ～ 2 上昇する
    @defence += (1 + rand(2)) # 1 ～ 2 上昇する
  end
  
  # フィーバー状態を開始
  def fever_start()
    if @fever_point >= FEVER_MAX_POINT then
      @fever_point = 0
      @fever_frame = FEVER_MAX_FRAME
    end
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