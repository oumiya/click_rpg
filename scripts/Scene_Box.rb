require 'dxruby'
require_relative 'Scene_Base.rb'
require_relative 'Scene_Home.rb'
require_relative 'Message_Box.rb'

# ゲーム中の全てのシーンのスーパークラス
class Scene_Box < Scene_Base

  def initialize()
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
    
    # 武器か防具の抽選
    drop_item = rand(2) # 0 なら武器 1 なら防具
    @item_name = ""
    
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
      @item_name = $weapondata.get_weapon_data(idx)[:name]
    else
      $player.have_armor[idx][1] += 1
      @item_name = $armordata.get_armor_data(idx)[:name]
    end

    $sounds["box"].play(1, 0)
    @wait_frame = 180
  end
  
  # フレーム更新処理
  def update()
    Window.draw(0, 0, @background)
    Window.draw(230, 70, @box_image)
    Message_Box.show(@item_name + "を手に入れた！", -1, 415, @font, 128)
    
    # 指定のフレーム数ウェイト
    if @wait_frame > 0 then
      @wait_frame -= 1
      return
    end
    
    Message_Box.show("街へ戻る", -1, -1, @font, 128)
    
    # キー入力待ち
    if Input.mouse_push?(M_LBUTTON) || Input.pad_push?(P_BUTTON0) then
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

end
