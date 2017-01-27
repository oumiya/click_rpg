require 'dxruby'
require_relative 'Scene_Base.rb'
require_relative 'Scene_Home.rb'
require_relative 'Message_Box.rb'
require_relative 'Wave_Result.rb'

# ゲーム中の全てのシーンのスーパークラス
class Scene_Box < Scene_Base

  def initialize(result)
    @result = result
    # 背景画像読み込み
    @background = nil
    case $dungeon_id
    when 1
      @background = Image.load("image/background/cave.jpg")
    when 2
      @background = Image.load("image/background/forest.jpg")
    when 3
      @background = Image.load("image/background/mansion.jpg")
    when 4
      @background = Image.load("image/background/volcano.jpg")
    when 5
      @background = Image.load("image/background/ice_world.jpg")
    when 6
      @background = Image.load("image/background/castle.jpg")
    else
      # 一応、入れておく
      @background = Image.load("image/background/cave.jpg")
    end
    
    # 宝箱画像
    @box_image = Image.load("image/enemy/box.png")
    
    @font = Font.new(32)
    @next_scene = nil
  end
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
    $bgm.each{|bgm_name, bgm_ayame|
      bgm_ayame.stop(1)
    }
    
    $sounds["box"].play(1, 0)
    @wait_frame = 180
    
    @message = @result.exp.to_s + "の経験値を獲得！<br>"
    $player.exp += @result.exp
    if $player.level_up? then
      @message += "レベルが上がった！<br>"
    end
    @message += @result.gold.to_s + "ゴールドを獲得！<br>"
    $player.gold += @result.gold
    
    @item_name = ""
    if @result.result == true then
      item_drop() # 必ず1個は当たる
    end
    
    for i in 0..@result.battle_count do
      if rand(8) == 0 then
        item_drop()
      end
    end
    
    @message += @item_name
    
    # 街づくり収入
    if $player.income > 0 then
      income = $player.income * @result.battle_count
      $player.gold += income
      @message += income.to_s + "ゴールドの税収を獲得！<br>"
    end
  end
  
  # フレーム更新処理
  def update()
    Window.draw(0, 0, @background)
    Window.draw(230, 70, @box_image)
    Message_Box.show(@message, -1, -1, @font)
    
    # 指定のフレーム数ウェイト
    if @wait_frame > 0 then
      @wait_frame -= 1
      return
    end
    
    Message_Box.show("街へ戻る", -1, 415, @font)
    
    # キー入力待ち
    if Input.mouse_push?(M_LBUTTON) || Input.pad_push?($attack_button) then
      @next_scene = Scene_Home.new
    end
    
  end
  
  # ループ後処理
  def terminate()
  end
  
  # 次のシーンに遷移
  # 遷移しない場合は nil を返す
  def get_next_scene()
    return @next_scene
  end
  
  def item_drop()
    # 武器か防具の抽選
    drop_item = rand(2) # 0 なら武器 1 なら防具
    
    # ゴミ、ノーマル、レア、スーパレアの抽選
    idx = rand(100)
    if idx < 40
      idx = 0
    elsif idx < 70
      idx = 1
    elsif idx < 90
      idx = 2
    else
      idx = 3
    end
    
    # ボーナスの抽選
    # まずボーナスがつくかどうか（ボーナスは50%の確率で付与）
    lottery = rand(100)
    bonus = 0
    if lottery < 50 then
      # ボーナス値の抽選
      lottery = rand(100) + 1
      if lottery >= 96
        bonus = 10
      elsif lottery >= 91
        bonus = 9
      elsif lottery >= 85
        bonus = 8
      elsif lottery >= 78
        bonus = 7
      elsif lottery >= 70
        bonus = 6
      elsif lottery >= 61
        bonus = 5
      elsif lottery >= 51
        bonus = 4
      elsif lottery >= 40
        bonus = 3
      elsif lottery >= 29
        bonus = 2
      else
        bonus = 1
      end
    end
    
    # 属性の抽選
    # 属性について 0:無は空文字 1:火属性 2:氷属性 3:土属性 4:風属性 5:光属性 6:闇属性
    # まず属性がつくかどうか（属性は65%の確率で付与）
    lottery = rand(100)
    element = ""
    if lottery < 65 then
      if drop_item == 0 then
        element = $weapondata.get_weapon_data(idx)[:element]
      else
        element = $armordata.get_armor_data(idx)[:element]
      end
      
      # 属性が無属性の時は属性を付与する
      if element == "" then
        lottery = rand(6) + 1
        if lottery == 1 then
          element = "火"
        end
        if lottery == 2 then
          element = "氷"
        end
        if lottery == 3 then
          element = "土"
        end
        if lottery == 4 then
          element = "風"
        end
        if lottery == 5 then
          element = "光"
        end
        if lottery == 6 then
          element = "闇"
        end
      end
    end
    
    # 防具の場合のみ自動回復の抽選
    heal = 0
    if drop_item == 1 then
      # 防具の自動回復は10%の確率で付与 毎秒1% ～ 毎秒10% まで
      lottery = rand(100)
      if lottery < 10 then
        lottery = rand(100) + 1
        if lottery >= 96
          heal = 10
        elsif lottery >= 91
          heal = 9
        elsif lottery >= 85
          heal = 8
        elsif lottery >= 78
          heal = 7
        elsif lottery >= 70
          heal = 6
        elsif lottery >= 61
          heal = 5
        elsif lottery >= 51
          heal = 4
        elsif lottery >= 40
          heal = 3
        elsif lottery >= 29
          heal = 2
        else
          heal = 1
        end
      end
    end
    
    idx = ($dungeon_id - 1) * 4 + idx
    
    if drop_item == 0 then
      reward_name = $weapondata.get_weapon_data(idx)[:name]
      if bonus > 0 then
        reward_name += "+" + bonus.to_s
      end
      if element != "" then
        reward_name = reward_name + "(" + element + ")"
      end
      
      # 実攻撃力の計算
      value = $weapondata.get_weapon_data(idx)[:value]
      if bonus > 0 then
        value_bonus = value / 10
        value += value_bonus * bonus
      end
      
      reward_weapon = {"idx"=>idx, "name"=>reward_name, "element"=>element, "bonus"=>bonus, "value"=>value}
      $player.have_weapon.push(reward_weapon)
      @item_name += reward_name + "を手に入れた！<br>"
      
      # 武器を攻撃力順にソート
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
      
      
      
      
    else
      reward_name = $armordata.get_armor_data(idx)[:name]
      if bonus > 0 then
        reward_name += "+" + bonus.to_s
      end
      if element != "" then
        reward_name = reward_name + "(" + element + ")"
      end
      if heal > 0 then
        reward_name = reward_name + "H" + heal.to_s
      end
      
      # 実防御力の計算
      value = $armordata.get_armor_data(idx)[:value]
      if bonus > 0 then
        value_bonus = value / 10
        value += value_bonus * bonus
      end
      
      reward_armor = {"idx"=>idx, "name"=>reward_name, "element"=>element, "bonus"=>bonus, "heal"=>heal, "value"=>value}
      $player.have_armor.push(reward_armor)
      @item_name += reward_name + "を手に入れた！<br>"
      
      # 防具を攻撃力順にソート
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
    
    
  end

end
