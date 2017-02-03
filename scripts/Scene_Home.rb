require 'dxruby'
require_relative 'Cursor.rb'
require_relative 'Fade_Effect.rb'
require_relative 'Save_Data.rb'
require_relative 'Scene_Base.rb'
require_relative 'Scene_Creation.rb'
require_relative 'Scene_Event.rb'
require_relative 'Scene_Key_Config.rb'
require_relative 'Scene_Select_Battale.rb'
require_relative 'Scene_Ending.rb'
require_relative 'Scene_Tower.rb'
include Save_Data

# ホーム画面
class Scene_Home < Scene_Base
  # 薬草の持てる上限数
  MAX_HEAL_COUNT = 10
  
  def initialize()
    GC.start
  end
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
    # 遷移先シーンを格納
    @next_scene = nil
    
    # 背景画像の読み込み
    @back_image = Image.load("image/system/home.png")
    # ダンジョン選択カーソル
    @cursor = Cursor.new([[114, 39], [314, 39], [514, 42], [713, 44], [515, 232], [712, 233], [523, 413], [726, 413], [523, 477], [726, 477], [915, 212]])
    @cursor.index = $cursor_idx
    # お金が足りないよウィンドウの準備
    @not_enough_money = Image.load("image/system/not_enough_money.png")
    @not_enough_money_show = false
    # ソロモンの塔に行く矢印の表示
    @salmon_arrow = Image.load("image/system/arrow.png")
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
      $bgm[$playing_bgm].play(0, 0)
    else
      # ホーム以外のBGMが流れていたら停止してホームのBGMを鳴らす
      # ホームのBGMが流れていたらそのまま継続して流す
      if $bgm["home"].playing? == false then
        $bgm.each{|bgm_name, bgm_ayame|
          bgm_ayame.stop(1)
        }
        $bgm["home"].play(0, 0)
        $playing_bgm  = "home"
      end
    end
    
    $player.opening = true
    
    # ホーム画面を開いた時に自動セーブ
    save()
    
    $dungeon_id = 0
    
    @message = ""
    
    @prev_mouse_pos = [Input.mouse_x, Input.mouse_y] # 前回マウス座標
    
    if $player.cleared == true && $player.flag[10] == false then
      @message = "クリア特典が解放されました。<br>お金と経験値の取得値が2倍になりました。<br>アイテムドロップ率が100%になった。"
      @wait_frame = 300
      $player.flag[10] = true
    end
    
    # 街づくりモード解放
    if $player.flag[0] == false && $player.gold > 1000 then
      $player.flag[0] = true
      @next_scene = Scene_Event.new("creation.dat")
    end
    # トゥルーエンディング
    if $player.flag[1] == false && $player.gold > 10000000 && $player.cleared == true then
      $player.gold -= 10000000
      $player.flag[1] = true
      @next_scene = Scene_Event.new("ending.dat")
    else
      # トゥルーエンディング後のイベント
      if $player.flag[1] == true && $player.flag[11] == false then
        $player.flag[11] = true
        @next_scene = Scene_Event.new("salmon1.dat")
      end
    end
    
    # 騎士イベント1
    if $player.flag[2] == false && $player.progress >= 5 then
      $player.flag[2] = true
      @next_scene = Scene_Event.new("knight1.dat")
    end
    # 騎士イベント2
    if $player.flag[6] == false && $player.progress >= 10 then
      $player.flag[6] = true
      @next_scene = Scene_Event.new("knight2.dat")
    end
    # 騎士イベント3
    if $player.flag[7] == false && $player.progress >= 15 then
      $player.flag[7] = true
      @next_scene = Scene_Event.new("knight3.dat")
      $player.add_armor(24, "アロウの鎧(光)H2", "光", 0, 2, 150)
    end
    
    # 騎士イベント4
    if $player.flag[8] == false && $player.progress >= 20 then
      $player.flag[8] = true
      @next_scene = Scene_Event.new("knight4.dat")
    end
    
    # 騎士イベント5
    if $player.flag[9] == false && $player.progress >= 25 then
      $player.flag[9] = true
      @next_scene = Scene_Event.new("knight5.dat")
      $player.add_weapon(24, "アロウの剣(光)", "光", 0, 500, -1)
      $player.add_armor(24, "アロウの鎧改(闇)H5", "闇", 0, 5, 500)
    end
  end
  
  # 画面描画処理
  def draw()
    # ホーム画面を描画
    Window.draw(0, 0, @back_image)
    # プレイヤーのステータスを表示
    draw_player_status()
    # 主人公のつぶやきを表示
    draw_word()
    # アバターの描画
    Window.draw(29, 285, $avater[$player.skin_color])
    # 防具の描画
    $armordata.draw
    # 髪型を表示
    $hair.draw
    # アバター武器の描画
    $weapondata.draw
    # ダンジョン選択カーソルを表示
    @cursor.update
    # お金が足りないメッセージの表示
    if @not_enough_money_show then
      Window.draw(327, 226, @not_enough_money, 3000)
      if @wait_frame <= 0 then
        @not_enough_money_show = false
      end
    end
    # エンディングを見直すボタンの表示
    if $player.cleared == true then
      draw_ending_button()
    end
    # トゥルーエンディングを見直すボタンの表示
    if $player.flag[1] == true then
      draw_true_ending_button()
    end
    # ソロモンの塔に行くボタンを表示
    if $player.cleared == true && $player.flag[1] == true then
      Window.draw(915, 212, @salmon_arrow)
    end
    
    # メッセージボックスの表示
    if @message != "" then
      Message_Box.show(@message)
      if @wait_frame < 1 then
        @message = ""
      end
    end
  end
  
  
  # フレーム更新処理
  def update()
    # 指定のフレーム数ウェイト
    if @wait_frame > 0 then
      @wait_frame -= 1
      return
    end
    
    # フェードアウト/フェードインの表示
    @fade_effect.update
    if @fade_effect.effect_end? then
      # ダンジョン選択シーンに移行
      if @scene_index == 1 then
        @next_scene = Scene_Select_Battale.new
      end
      # 装備シーンに移行
      if @scene_index == 2 then
        @next_scene = Scene_Equip.new
      end
      # ショップシーンに移行
      if @scene_index == 3 then
        @next_scene = Scene_Shop.new
      end
      # 街づくり
      if @scene_index == 4 then
        @next_scene = Scene_Creation.new
      end
      # ソロモンの塔へ行く
      if @scene_index == 5 then
        @next_scene = Scene_Tower.new
      end
    else
      return
    end
    
    # キー入力処理
    control_mode_change()
    
    # ボタン処理
    if Input.pad_push?(P_UP) then
      if @cursor.index >=4 && @cursor.index <= 9 then
        @cursor.index -= 2
        $cursor_idx = @cursor.index
      end
    end
    
    if Input.pad_push?(P_RIGHT) then
      @cursor.index += 1
      if $player.cleared == true && $player.flag[1] == true then
        if @cursor.index > 10 then
          @cursor.index = 0
          $cursor_idx = @cursor.index
        end
      else
        if @cursor.index > 9 then
          @cursor.index = 0
          $cursor_idx = @cursor.index
        end
      end
    end
    
    if Input.pad_push?(P_DOWN) then
      if @cursor.index >=2 && @cursor.index <= 7 then
        @cursor.index += 2
        $cursor_idx = @cursor.index
      end
    end
    
    if Input.pad_push?(P_LEFT) then
      @cursor.index -= 1
      if @cursor.index < 0 then
        @cursor.index = 9
        $cursor_idx = @cursor.index
      end
    end
    
    # マウスの左クリック か 決定ボタン押下
    if (Input.mouse_push?(M_LBUTTON) && $control_mode == 0) || (Input.pad_push?($attack_button) && $control_mode == 1) then
      # 遷移先ダンジョンを決定
      if @cursor.index <= 5 then
        dungeon_trantision(@cursor.index + 1)
      end
      
      # 薬草を買うボタンを押下
      if @cursor.index == 6 then
        buy_heal_button()
      end
      # 装備変更ボタン押下
      if @cursor.index == 7 then
        equip_trantision()
      end
      # ショップボタンを押下
      if @cursor.index == 8 then
        shop_trantision()
      end
      # 街づくりボタンを押下
      if @cursor.index == 9 then
        creation()
      end
      
      # ソロモンの塔へ行く
      if @cursor.index == 10 then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
        # 画面を徐々にフェードアウトさせる
        @fade_effect.setup(0)
        @scene_index = 5
      end
      
      # ゲームパッドのコンフィグ設定
      if mouse_widthin_button?("pad_config") then
        @next_scene = Scene_Key_Config.new
      end
      
      # エンディングを見直すボタンを押す
      if mouse_widthin_button?("ending") && $player.cleared == true then
        @next_scene = Scene_Ending.new
      end
      # トゥルーエンディングを見直すボタンを押す
      if mouse_widthin_button?("true_ending") && $player.flag[1] == true then
        @next_scene = Scene_Event.new("ending.dat")
      end
    end
    
    # マウスカーソルホバー
    # 操作モードが マウスモード の場合のみ
    if $control_mode == 0 then
      if mouse_widthin_button?("cave") then
         @cursor.index = 0
         $cursor_idx = @cursor.index
      end
      if mouse_widthin_button?("forest") then
         @cursor.index = 1
         $cursor_idx = @cursor.index
      end
      if mouse_widthin_button?("mansion") then
         @cursor.index = 2
         $cursor_idx = @cursor.index
      end
      if mouse_widthin_button?("volcano") then
         @cursor.index = 3
         $cursor_idx = @cursor.index
      end
      if mouse_widthin_button?("ice_world") then
         @cursor.index = 4
         $cursor_idx = @cursor.index
      end
      if mouse_widthin_button?("castle") then
         @cursor.index = 5
         $cursor_idx = @cursor.index
      end
      if mouse_widthin_button?("buy_heal") then
         @cursor.index = 6
         $cursor_idx = @cursor.index
      end
      if mouse_widthin_button?("equip") then
         @cursor.index = 7
         $cursor_idx = @cursor.index
      end
      if mouse_widthin_button?("shop") then
         @cursor.index = 8
         $cursor_idx = @cursor.index
      end
      if mouse_widthin_button?("quit") then
         @cursor.index = 9
         $cursor_idx = @cursor.index
      end
      if mouse_widthin_button?("salmon") && $player.cleared == true && $player.flag[1] == true then
        @cursor.index = 10
        $cursor_idx = 10
      end
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
  
  # 指定のダンジョンに遷移する
  def dungeon_trantision(dungeon_id)
    clear_dungeon = ($player.progress.to_f / 5.0).floor
    clear_dungeon += 1
    if clear_dungeon >= dungeon_id then
      # 決定音を鳴らす
      $sounds["decision"].play(1, 0)
      # ダンジョンIDを1に設定
      $dungeon_id = dungeon_id
      # フェードアウト後に戦闘シーンへ遷移させる
      @scene_index = 1
      # カーソルを点滅させる
      @cursor.flash = true
      @cursor.visible = true
      @cursor.index = dungeon_id - 1
      $cursor_idx = @cursor.index
      # 画面を徐々にフェードアウトさせる
      @fade_effect.setup(0)
    end
  end
  
  # 薬草を買うボタンを押下
  def buy_heal_button()
    # 決定音を鳴らす
    $sounds["decision"].play(1, 0) 
    
    # ゴールドが足りているか？
    if $player.gold >= 50 then
      if $player.heal_count >= MAX_HEAL_COUNT then
        @message = "薬草はもうそんなに持てないよ！"
        @wait_frame = 60
      else
        $player.gold -= 50
        $player.heal_count += 1
      end
    else
      @wait_frame = 60
      @not_enough_money_show = true
    end
  end
  
  # 装備画面に遷移
  def equip_trantision()
    # 決定音を鳴らす
    $sounds["decision"].play(1, 0)
    # 画面を徐々にフェードアウトさせる
    @fade_effect.setup(0)
    @scene_index = 2
  end
  
  # ショップ画面に遷移
  def shop_trantision()
    # 決定音を鳴らす
    $sounds["decision"].play(1, 0)
    # 画面を徐々にフェードアウトさせる
    @fade_effect.setup(0)
    @scene_index = 3
  end
  
  # クリエーションボタンを押下
  def creation()
    # 決定音を鳴らす
    $sounds["decision"].play(1, 0)
    # 一応やめる前にセーブしておく
    save()
    if $player.flag[0] == true then
      # 画面を徐々にフェードアウトさせる
      @fade_effect.setup(0)
      @scene_index = 4
    else
      @message = "このモードはまだ解放されていません"
      @wait_frame = 95
    end
  end
  
  # コントロールモードのチェンジ
  def control_mode_change()
    d = ((Input.mouse_x - @prev_mouse_pos[0]) ** 2).abs
    d += ((Input.mouse_y - @prev_mouse_pos[1]) ** 2).abs
    d = Math.sqrt(d)
    
    if d > 8 then
      $control_mode = 0
      Input.mouse_enable = true
    end
    
    if Input.pad_push?(P_UP) || Input.pad_push?(P_LEFT) || Input.pad_push?(P_RIGHT) || Input.pad_push?(P_DOWN) then
      $control_mode = 1
      Input.mouse_enable = false
    end
    
    @prev_mouse_pos = [Input.mouse_x, Input.mouse_y]
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
    
    # ソロモンの塔へ行くボタン
    @button["salmon"] = [915, 212, 954, 337]
    
    # 上部メニューボタン
    @button["pad_config"] = [0, 0, 160, 36]
    
    # エンディングを見直すボタン
    @button["ending"] = [180, 0, 330, 36]
    @button["true_ending"] = [342, 0, 555, 36]
    
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
    Window.draw_font(x, y, $player.real_ATK.to_s, @status_font) # 攻撃力
    y += 23
    Window.draw_font(x, y, $player.real_DEF.to_s, @status_font) # 防御力
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
  
  # エンディングを見直すボタンを描画
  def draw_ending_button()
    Window.draw_font(186, 7, "エンディングを見る", @status_font, {:color => [0, 0, 0]})
  end
  
  # エンディングを見直すボタンを描画
  def draw_true_ending_button()
    Window.draw_font(347, 7, "トゥルーエンディングを見る", @status_font, {:color => [0, 0, 0]})
  end

end
