require_relative 'Weapon_Data.rb'

# プレイヤークラス
class Player
  # フィーバー持続時間の最大値
  FEVER_MAX_FRAME = 600
  FEVER_MAX_POINT = 600
  
  attr_accessor :name              # プレイヤー名
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
  attr_accessor :weapon_bonus      # 装備している武器のボーナス
  attr_accessor :weapon_element    # 装備している武器の属性
  attr_accessor :equip_armor       # 装備している防具
  attr_accessor :armor_bonus       # 装備している防具のボーナス
  attr_accessor :armor_element     # 装備している防具の属性
  attr_accessor :armor_heal        # 装備している防具の自動回復 毎秒n%回復
  attr_accessor :have_weapon       # 所持している武器
  attr_accessor :have_armor        # 所持している防具
  attr_accessor :fever_point       # 現在のフィーバーポイント
  attr_accessor :fever_frame       # フィーバー持続時間（フレーム）
  attr_accessor :fever_count       # フィーバー回数
  attr_accessor :opening           # オープニング見た
  attr_accessor :cleared           # クリア済みフラグ
  attr_accessor :progress          # 進行度
  attr_accessor :town              # クリエーションモードの街情報
  attr_accessor :income            # 1ターンごとに街から得られる収入
  attr_accessor :flag              # ストーリー進行フラグ
  attr_accessor :sell_weapon       # 売却した武器
  attr_accessor :sell_armor        # 売却した防具
  
  MAX_LEVEL = 98 # プレイヤーの最大レベル
  
  def initialize()
    # 初期化
    @name = "ルウ"
    @level = 1
    @max_hp = 1000
    @hp = @max_hp
    @attack = 200
    @defence = 150
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
    @fever_point = 0
    @fever_frame = 0
    @fever_count = 0
    @opening = false
    @cleared = false
    @progress = 0
    @town = Array.new(20)
    for i in 0..19 do
      @town[i] = Array.new(13)
      for j in 0..12 do
        @town[i][j] = 0
      end
    end
    @income = 0
    @flag = Array.new(100)
    for i in 0..99 do
      @flag[i] = false
    end
    @sell_weapon = Array.new
    for i in 0..8 do
      sell_weapon.push(get_weapon_idx(i))
    end
    @sell_armor = Array.new
    for i in 0..8 do
      sell_armor.push(get_armor_idx(i))
    end

    # 経験値テーブルの作成
    @exp_table = Array.new(MAX_LEVEL)
    base_value = 10  # 基本増加量
    base_rate = 1.2 # 基本増加率
    @exp_table[0] = 10
    
    for i in 1..@exp_table.length-1 do
      if i > 42 then
        @exp_table[i] = @exp_table[i-1] + 105728
      else
        @exp_table[i] = (@exp_table[i-1] * base_rate + base_value).round
      end
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
      value = @have_weapon[@equip_weapon]["value"]
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
      value = @have_weapon[@equip_weapon]["value"]
      res = @attack + value
    else
      res = @attack
    end
    
    return res
  end
  
  def DEF()
    res = 0
    if @equip_armor >= 0 then
      value = @have_armor[@equip_armor]["value"]
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
      value = @have_armor[@equip_armor]["value"]
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
    @max_hp += 250             # 固定で 25 上昇する
    @hp = @max_hp * rate
    @attack +=  (10 + rand(20)) # 1 ～ 2 上昇する
    @defence += (10 + rand(20)) # 1 ～ 2 上昇する
  end
  
  # フィーバー状態を開始
  def fever_start()
    if @fever_point >= FEVER_MAX_POINT then
      # フィーバー回数をカウント
      @fever_count += 1
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
  
  # 指定の武器を所持品に追加
  def add_weapon_idx(idx)
    weapon_name = $weapondata.get_weapon_data(idx)[:name]
    value = $weapondata.get_weapon_data(idx)[:value]
    element = $weapondata.get_weapon_data(idx)[:element]
    adding_weapon = {"idx"=>idx, "name"=>weapon_name, "element"=>element, "bonus"=>0, "value"=>value}
    $player.have_weapon.push(adding_weapon)
    sort_weapon()
  end
  
  def get_weapon_idx(idx)
    weapon_name = $weapondata.get_weapon_data(idx)[:name]
    value = $weapondata.get_weapon_data(idx)[:value]
    element = $weapondata.get_weapon_data(idx)[:element]
    adding_weapon = {"idx"=>idx, "name"=>weapon_name, "element"=>element, "bonus"=>0, "value"=>value, "skill"=>nil}
    
    return adding_weapon
  end

  # 指定の武器を所持品に追加
  def add_weapon(idx, weapon_name, element, bonus, value, skill)
    adding_weapon = {"idx"=>idx, "name"=>weapon_name, "element"=>element, "bonus"=>bonus, "value"=>value, "skill"=>skill}
    $player.have_weapon.push(adding_weapon)
    sort_weapon()
  end
  
  # 所持している武器のソート
  def sort_weapon()
    if $player.have_weapon.length > 1 then
      pos_max = $player.have_weapon.length - 1
      
      (0...(pos_max)).each{|n|
        (0...(pos_max - n)).each{|ix|
          iy = ix + 1
          if $player.have_weapon[ix]["value"] > $player.have_weapon[iy]["value"] then
            if $player.equip_weapon == ix then
              $player.equip_weapon = iy
            elsif $player.equip_weapon == iy then
              $player.equip_weapon = ix
            end
            $player.have_weapon[ix], $player.have_weapon[iy] = $player.have_weapon[iy], $player.have_weapon[ix]
          end
        }
      }
    end
  end
  
  # 売却した武器のソート
  def sort_sell_weapon()
    if $player.sell_weapon.length > 1 then
      pos_max = $player.sell_weapon.length - 1
      
      (0...(pos_max)).each{|n|
        (0...(pos_max - n)).each{|ix|
          iy = ix + 1
          if $player.sell_weapon[ix]["value"] > $player.sell_weapon[iy]["value"] then
            $player.sell_weapon[ix], $player.sell_weapon[iy] = $player.sell_weapon[iy], $player.sell_weapon[ix]
          end
        }
      }
    end
  end
  
  # 指定の防具を所持品に追加
  def add_armor_idx(idx)
    armor_name = $armordata.get_armor_data(idx)[:name]
    value = $armordata.get_armor_data(idx)[:value]
    element = $armordata.get_armor_data(idx)[:element]
    heal = $armordata.get_armor_data(idx)[:heal]
    
    adding_armor = {"idx"=>idx, "name"=>armor_name, "element"=>element, "bonus"=>0, "heal"=>heal, "value"=>value}
    $player.have_armor.push(adding_armor)
    sort_armor()
  end
  
  def get_armor_idx(idx)
    armor_name = $armordata.get_armor_data(idx)[:name]
    value = $armordata.get_armor_data(idx)[:value]
    element = $armordata.get_armor_data(idx)[:element]
    heal = $armordata.get_armor_data(idx)[:heal]
    
    adding_armor = {"idx"=>idx, "name"=>armor_name, "element"=>element, "bonus"=>0, "heal"=>heal, "value"=>value}
    return adding_armor
  end

  # 指定の防具を所持品に追加
  def add_armor(idx, armor_name, element, bonus, heal, value)
    added_armor = {"idx"=>idx, "name"=>armor_name, "element"=>element, "bonus"=>bonus, "heal"=>heal, "value"=>value}
    $player.have_armor.push(added_armor)
    sort_armor()
  end
  
  # 所持している防具のソート
  def sort_armor()
    if $player.have_armor.length > 1 then
      pos_max = $player.have_armor.length - 1
      
      (0...(pos_max)).each{|n|
        (0...(pos_max - n)).each{|ix|
          iy = ix + 1
          if $player.have_armor[ix]["value"] > $player.have_armor[iy]["value"] then
            if $player.equip_armor == ix then
              $player.equip_armor = iy
            elsif $player.equip_armor == iy then
              $player.equip_armor = ix
            end
            $player.have_armor[ix], $player.have_armor[iy] = $player.have_armor[iy], $player.have_armor[ix]
          end
        }
      }
    end
  end
  
  # 売却した防具のソート
  def sort_sell_armor()
    if $player.sell_armor.length > 1 then
      pos_max = $player.sell_armor.length - 1
      
      (0...(pos_max)).each{|n|
        (0...(pos_max - n)).each{|ix|
          iy = ix + 1
          if $player.sell_armor[ix]["value"] > $player.sell_armor[iy]["value"] then
            $player.sell_armor[ix], $player.sell_armor[iy] = $player.sell_armor[iy], $player.sell_armor[ix]
          end
        }
      }
    end
  end
end