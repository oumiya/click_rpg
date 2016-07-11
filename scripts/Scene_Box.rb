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
    item_drop() # 必ず1個は当たる
    for i in 0..@result.battle_count do
      if rand(8) == 0 then
        item_drop()
      end
    end
    
    @message += @item_name
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
    
    idx = ($dungeon_id - 1) * 4 + idx
    
    if drop_item == 0 then
      $player.have_weapon[idx][1] += 1
      @item_name += $weapondata.get_weapon_data(idx)[:name] + "を手に入れた！<br>"
    else
      $player.have_armor[idx][1] += 1
      @item_name += $armordata.get_armor_data(idx)[:name] + "を手に入れた！<br>"
    end
  end

end
