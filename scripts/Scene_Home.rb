require 'dxruby'
require_relative 'Scene_Base.rb'
require_relative 'Scene_Battle.rb'
require_relative 'Fade_Effect.rb'
require_relative 'Hair.rb'
require_relative 'Save_Data.rb'
include Save_Data

# ホーム画面
class Scene_Home < Scene_Base

  # ダンジョン選択用カーソルクラス
  class Dungeon_Cursor
    attr_accessor :index
    attr_accessor :flash
    attr_accessor :visible
    
    def initialize()
      @pos = [[143, 39], [343, 39], [538, 42], [737, 44], [539, 232], [736, 233]]
      @image = Image.load("image/system/cursor.png")
      @visible = false
      @flash = false
    end
    
    def update()
      if @visible then
        draw()
      end
    end
    
    def draw()
      if @flash then
        if $frame_counter % 6 > 2 then
          Window.draw(@pos[@index][0], @pos[@index][1], @image)
        end
      else
        Window.draw(@pos[@index][0], @pos[@index][1], @image)
      end
    end
  end
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
    # 遷移先シーンを格納
    @next_scene = nil
    
    # 背景画像の読み込み
    @back_image = Image.load("image/system/home.png")
    # ダンジョン選択カーソル
    @cursor = Dungeon_Cursor.new
    # お金が足りないよウィンドウの準備
    @not_enough_money = Image.load("image/system/not_enough_money.png")
    @not_enough_money_show = false
    # プレイヤーステータス描画用のフォントを用意
    @status_font = Font.new(18)
    # ボタン座標の設定
    button_setup()
    # フェードアウト/フェードイン用の演出クラスを準備
    @fade_effect = Fade_Effect.new
    @fade_effect.setup(1)
    
    # シーン切り替え先 0 シーン切り替えなし 1 戦闘シーン 2 装備シーン 3 ショップシーン
    @scene_index = 0
    # ウェイトフレームを初期化
    @wait_frame = 0
    
    # プレイヤーを全回復させておく
    $player.hp = $player.max_hp
    
    # ホーム画面のBGMを演奏
    if $playing_bgm == nil then
      $playing_bgm = "home"
      $bgm["home"].play(0, 0)
    else
      # ホーム以外のBGMが流れていたら停止してホームのBGMを鳴らす
      # ホームのBGMが流れていたらそのまま継続して流す
      if $playing_bgm != "home" then
        $bgm.each{|bgm_name, bgm_ayame|
          bgm_ayame.stop(0, 0)
        }
        $bgm["home"].play(0, 0)
      end
    end

    
    @hair = Hair.new
    
    # ホーム画面を開いた時に自動セーブ
    save()
  end
  
  # フレーム更新処理
  def update()
    # ホーム画面を描画
    Window.draw(0, 0, @back_image)
    # プレイヤーのステータスを表示
    draw_player_status()
    # 主人公のつぶやきを表示
    draw_word()
    # 髪型を表示
    @hair.draw
    # ダンジョン選択カーソルを表示
    @cursor.update
    # お金が足りないメッセージの表示
    if @not_enough_money_show then
      Window.draw(327, 226, @not_enough_money, 3000)
      if @wait_frame <= 0 then
        @not_enough_money_show = false
      end
    end
    
    # 指定のフレーム数ウェイト
    if @wait_frame > 0 then
      @wait_frame -= 1
      return
    end
    
    # フェードアウト/フェードインの表示
    @fade_effect.update
    if @fade_effect.effect_end? then
      # 戦闘シーンに移行
      if @scene_index == 1 then
        @next_scene = Scene_Battle.new
      end
      #ショップシーンに移行
      if @scene_index == 3 then
        @next_scene = Scene_Shop.new
      end
    else
      return
    end
    
    # キー入力処理
    
    # ボタン処理
    if Input.mouse_push?(M_LBUTTON) then
      # 洞窟を決定
      if mouse_widthin_button?("cave") then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
        # ダンジョンIDを1に設定
        $dungeon_id = 1
        # フェードアウト後に戦闘シーンへ遷移させる
        @scene_index = 1
        # カーソルを点滅させる
        @cursor.flash = true
        @cursor.visible = true
        @cursor.index = 0
        # BGM を停止する
        $bgm["home"].stop(2.5)
        # 画面を徐々にフェードアウトさせる
        @fade_effect.setup(0)
        # カーソルを 95 フレーム点滅させるためにウェイト
        @wait_frame = 95
      end
      # 薬草を買うボタンを押下
      if mouse_widthin_button?("buy_heal") then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0) 
        
        # ゴールドが足りているか？
        if $player.gold >= 50 then
          $player.gold -= 50
          $player.heal_count += 1
        else
          @wait_frame = 60
          @not_enough_money_show = true
        end
      end
      # ショップボタンを押下
      if mouse_widthin_button?("shop") then
        # 画面を徐々にフェードアウトさせる
        @fade_effect.setup(0)
        @scene_index = 3
      end
    end
    
    # マウスカーソルホバー
    @cursor.visible = false
    if mouse_widthin_button?("cave") then
       @cursor.index = 0
       @cursor.visible = true
    end
    if mouse_widthin_button?("forest") then
       @cursor.index = 1
       @cursor.visible = true
    end
    if mouse_widthin_button?("mansion") then
       @cursor.index = 2
       @cursor.visible = true
    end
    if mouse_widthin_button?("volcano") then
       @cursor.index = 3
       @cursor.visible = true
    end
    if mouse_widthin_button?("ice_world") then
       @cursor.index = 4
       @cursor.visible = true
    end
    if mouse_widthin_button?("castle") then
       @cursor.index = 5
       @cursor.visible = true
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
  
  # 各ボタンの座標配列を初期化します
  # 0: 左上X座標 1: 左上Y座標 2: 右下X座標 3: 右下Y座標
  def button_setup()
    @button = Hash.new
    
    # ダンジョンボタン
    @button["cave"] = [147, 43, 310, 206]        # 洞窟
    @button["forest"] = [347, 43, 510, 206]      # 迷いの森
    @button["mansion"] = [542, 46, 705, 209]     # 死霊の館
    @button["volcano"] = [741, 47, 904, 210]     # 火山
    @button["ice_world"] = [543, 236, 706, 399]  # 氷の世界
    @button["castle"] = [740, 237, 903, 400]     # 魔王城
    
    # メニューボタン
    @button["buy_heal"] = [538, 407, 714, 467]   # 薬草を買うボタン
    @button["equip"] = [739, 407, 915, 467]      # 装備変更ボタン
    @button["shop"] = [538, 471, 714, 531]       # ショップボタン
    @button["quit"] = [739, 471, 915, 531]       # ゲームをやめるボタン
    
  end
  
  # マウスカーソルがボタンの座標内に入っているかどうかを返します
  def mouse_widthin_button?(button_name)
    hitbox = @button[button_name]
    
    res = false
    
    if Input.mouse_x >= hitbox[0] &&
       Input.mouse_y >= hitbox[1] &&
       Input.mouse_x <= hitbox[2] &&
       Input.mouse_y <= hitbox[3] then
       
       res = true
       
    end
    
    return res
  end
  
  # 主人公ステータスの表示
  def draw_player_status()
    x = 360
    y = 344

    Window.draw_font(x, y, $player.level.to_s, @status_font) # レベル
    y += 23
    Window.draw_font(x, y, $player.max_hp.to_s, @status_font) # HP
    y += 23
    Window.draw_font(x, y, $player.attack.to_s, @status_font) # 攻撃力
    y += 23
    Window.draw_font(x, y, $player.defence.to_s, @status_font) # 防御力
    y += 21
    Window.draw_font(x, y, $player.gold.to_s, @status_font) # ゴールド
    y += 23
    Window.draw_font(x, y, $player.heal_count.to_s, @status_font) # 薬草の数
    y += 21
    Window.draw_font(x, y, $player.exp.to_s, @status_font) # 経験値
    y += 22
    Window.draw_font_ex(x, y, $player.get_next_level_exp().to_s, @status_font) # 次のレベルまで
  end
  
  # プレイヤーの一言を描画
  def draw_word()
    Window.draw_font(208, 253, "うひひ　頑張るぞ！", @status_font, {:color => [0, 0, 0]})
    Window.draw_font(208, 253+18, "うひひ　頑張るぞ！", @status_font, {:color => [0, 0, 0]})
    Window.draw_font(208, 253+36, "うひひ　頑張るぞ！", @status_font, {:color => [0, 0, 0]})
  end

end
