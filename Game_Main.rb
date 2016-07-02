require 'dxruby'
require_relative 'ayame'
require './scripts/Player.rb'
require './scripts/Enemy_Data.rb'
require './scripts/Scene_Home.rb'
require './scripts/Scene_Battle.rb'
require './scripts/Scene_Shop.rb'
require './scripts/Scene_Equip.rb'
require './scripts/Debug_Window.rb'
require './scripts/Weapon_Data.rb'
require './scripts/Armor_Data.rb'
require './scripts/Hair_Item.rb'
require './scripts/Save_Data.rb'
include Save_Data

# ゲームのメインクラス
class Game_Main
  
  WINDOW_WIDTH = 960
  WINDOW_HEIGHT = 540
  
  def initialize()
    # 画面の解像度を指定
    Window.width = WINDOW_WIDTH
    Window.height = WINDOW_HEIGHT
  end
  
  # メイン処理
  def main()
    # フレームカウンターをリセット
    $frame_counter = 0
    
    # 初期シーンをセット
    #$scene = Scene_Battle.new
    $scene = Scene_Home.new
    #$scene = Scene_Shop.new
    #$scene = Scene_Equip.new
    
    loaded = false
    
    Window.loop do
      
      if loaded == false then
        font = Font.new(32)
        width = font.get_width("Now Loading...")
        height = font.size
        x = WINDOW_WIDTH / 2 - width / 2
        y = WINDOW_HEIGHT / 2 - height / 2
        Window.draw_font(x, y, "Now Loading...", font)
        Window.update
        data_load()
        loaded = true
        $scene.start # シーンの初期化
      end

      $scene.update
      
      break if $scene == nil

      if $scene.get_next_scene != nil then
        $scene.terminate               # シーンの終了処理
        $scene = $scene.get_next_scene # シーンを遷移
        $scene.start                   # シーンの初期化
      end

      $frame_counter += 1
      
      $debug.draw

      Ayame.update

      break if Input.keyPush?(K_ESCAPE) # Escキーで終了
    end
  end
  
  def data_load()
    # デバッグ情報
    $debug = Debug_Window.new
    $debug.visible = false
    
    # フレームカウンター
    $frame_counter = 0
    
    # システム画像を読み込む
    $system_image = Hash.new
    $system_image["attack_icon"] = Image.load("image/system/attack_icon.png")
    $system_image["guard_gauge"] = Image.load("image/system/guard_gauge.png")
    $system_image["heal_button"] = Image.load("image/system/heal_button.png")
    $system_image["hp_gauge"] = Image.load("image/system/hp_gauge.png")
    
    # 効果音を読み込む
    $sounds = Hash.new
    $sounds["p_damage_sound"] = Ayame.new("audio/se/player_damage.mp3") # プレイヤーダメージ音
    $sounds["p_guard_sound"] = Ayame.new("audio/se/player_guard.mp3")   # プレイヤーガード音
    $sounds["heal"] = Ayame.new("audio/se/heal.mp3")                    # 回復音
    $sounds["p_attack"] = Ayame.new("audio/se/player_attack.mp3")       # プレイヤーの攻撃音
    $sounds["encount"] = Ayame.new("audio/se/encount.mp3")              # 敵とのエンカウント音
    $sounds["win"] = Ayame.new("audio/se/win.mp3")                      # 戦闘に勝った！
    $sounds["lose"] = Ayame.new("audio/se/lose.mp3")                    # 戦闘に負けた！
    $sounds["die"] = Ayame.new("audio/se/die.mp3")                      # 敵の死亡音
    $sounds["v_b_start"] = Ayame.new("audio/se/voice_battle_start.mp3") # 戦闘開始音声
    $sounds["v_win"] = Ayame.new("audio/se/voice_win.mp3")              # 戦闘勝利音声
    $sounds["v_lose"] = Ayame.new("audio/se/voice_lose.mp3")            # 戦闘敗北音声
    $sounds["decision"] = Ayame.new("audio/se/decision.mp3")            # 決定音
    
    # BGMを読み込む
    $bgm = Hash.new
    $bgm["battle"] = Ayame.new("audio/bgm/battle.mp3")
    $bgm["boss_battle"] = Ayame.new("audio/bgm/boss_battle.mp3")
    $bgm["home"] = Ayame.new("audio/bgm/home.mp3")
    $playing_bgm = nil
   
    # データベースからデータを読み込む
    # 敵情報を読み込む
    $enemydata = Enemy_Data.new
    
    # 武器データを読み込む
    $weapondata = Weapon_Data.new
    
    # 防具データを読み込む
    $armordata = Armor_Data.new
    
    # 髪情報を読み込む
    $hair = Hair.new
    
    # 髪型リストの作成
    $hair_list = Array.new
    $hair_list.push(Hair_Item.new("くせ毛ショート", 150, "unruly"))
    $hair_list.push(Hair_Item.new("ショート", 150, "short"))
    $hair_list.push(Hair_Item.new("クルーカット", 150, "crew_cut"))
    $hair_list.push(Hair_Item.new("ソフトモヒカン", 150, "short_mohawk"))
    $hair_list.push(Hair_Item.new("モヒカン", 150, "mohawk"))
    $hair_list.push(Hair_Item.new("ガイル", 150, "guile"))
    $hair_list.push(Hair_Item.new("セミロング", 150, "semi_long"))
    $hair_list.push(Hair_Item.new("ロング", 150, "long"))
    $hair_list.push(Hair_Item.new("ツインテール", 150, "tails"))
    
    # アバター情報の作成
    $avater = Array.new(8)
    $avater[0] = Image.load("image/avater/01.png")
    $avater[1] = Image.load("image/avater/02.png")
    $avater[2] = Image.load("image/avater/03.png")
    $avater[3] = Image.load("image/avater/04.png")
    $avater[4] = Image.load("image/avater/05.png")
    $avater[5] = Image.load("image/avater/06.png")
    $avater[6] = Image.load("image/avater/07.png")
    $avater[7] = Image.load("image/avater/08.png")
    
    # プレイヤー情報の初期化
    $player = Player.new
    load()

    # ダンジョンID ダンジョンは全部で 6 ダンジョン
    # 値は 1 ～ 6
    $dungeon_id = 0
  end
end

game = Game_Main.new
game.main