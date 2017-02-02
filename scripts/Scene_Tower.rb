require 'dxruby'
require_relative 'Cursor.rb'
require_relative 'Fade_Effect.rb'
require_relative 'Save_Data.rb'
require_relative 'Scene_Base.rb'
require_relative 'Scene_Event.rb'
require_relative 'Scene_Battle.rb'
require_relative 'Scene_Home.rb'
include Save_Data

# ソロモンの塔画面
class Scene_Tower < Scene_Base

  def initialize()
    GC.start
  end
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
    # 遷移先シーンを格納
    @next_scene = nil
    
    # 背景画像の読み込み
    @back_image = Image.load("image/system/tower_home.png")
    # ダンジョン選択カーソル
    @cursor = Cursor.new([[343, 17], [536, 17], [730, 17], [343, 191], [536, 191], [730, 191], [536, 365], [730, 365], [0, 213]])
    @cursor.index = $tower_idx
    # クリア画像の読込
    @clear_flag = Image.load("image/system/clear_ribbon.png")

    # プレイヤーステータス描画用のフォントを用意
    @status_font = Font.new(18)
    # ボタン座標の設定
    button_setup()
    # フェードアウト/フェードイン用の演出クラスを準備
    @fade_effect = Fade_Effect.new
    @fade_effect.setup(1)
    
    # シーン切り替え先 0 シーン切り替えなし 1 戦闘シーン 2 ホーム画面に戻る
    @scene_index = 0
    # ウェイトフレームを初期化
    @wait_frame = 0
    
    # プレイヤーを全回復させておく
    $player.hp = $player.max_hp
    
    # ホーム画面のBGMを演奏
    if $playing_bgm == nil then
      $playing_bgm = "tower"
      $bgm[$playing_bgm].play(0, 0)
    else
      if $bgm["tower"].playing? == false then
        $bgm.each{|bgm_name, bgm_ayame|
          bgm_ayame.stop(1)
        }
        $bgm["tower"].play(0, 0)
        $playing_bgm  = "tower"
      end
    end
    
    $player.opening = true
    
    # ホーム画面を開いた時に自動セーブ
    save()
    
    $dungeon_id = 0
    
    @prev_mouse_pos = [Input.mouse_x, Input.mouse_y] # 前回マウス座標
  end
  
  # 画面描画処理
  def draw()
    # ホーム画面を描画
    Window.draw(0, 0, @back_image)
    # プレイヤーのステータスを表示
    # draw_player_status()
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
    # クリア済みの表示
    if $player.progress >= 31 then
      Window.draw(395, 81, @clear_flag)
    end
    if $player.progress >= 32 then
      Window.draw(591, 81, @clear_flag)
    end
    if $player.progress >= 33 then
      Window.draw(776, 81, @clear_flag)
    end
    if $player.progress >= 34 then
      Window.draw(395, 242, @clear_flag)
    end
    if $player.progress >= 35 then
      Window.draw(591, 242, @clear_flag)
    end
    if $player.progress >= 36 then
      Window.draw(776, 242, @clear_flag)
    end
    if $player.progress >= 37 then
      Window.draw(591, 416, @clear_flag)
    end
    if $player.progress >= 38 then
      Window.draw(776, 416, @clear_flag)
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
        @next_scene = Scene_Battle.new
      end
      if @scene_index == 2 then
        @next_scene = Scene_Home.new
      end
      if @scene_index == 3 then
        @next_scene = Scene_Event.new("salmon2.dat")
      end
    else
      return
    end
    
    # キー入力処理
    control_mode_change()
    
    # ボタン処理
    if Input.pad_push?(P_UP) then
      if @cursor.index >=3 && @cursor.index <= 5 then
        @cursor.index -= 3
        $tower_idx = @cursor.index
      end
      if @cursor.index >=6 && @cursor.index <= 7 then
        @cursor.index -= 2
        $tower_idx = @cursor.index
      end
    end
    
    if Input.pad_push?(P_RIGHT) then
      @cursor.index += 1
      if @cursor.index > 7 then
        @cursor.index = 0
        $tower_idx = @cursor.index
      end
    end
    
    if Input.pad_push?(P_DOWN) then
      if @cursor.index >= 0 && @cursor.index <= 2 then
        @cursor.index += 3
        $tower_idx = @cursor.index
      end
      if @cursor.index >= 4 && @cursor.index <= 5 then
        @cursor.index += 2
        $tower_idx = @cursor.index
      end
    end
    
    if Input.pad_push?(P_LEFT) then
      @cursor.index -= 1
      if @cursor.index < 0 then
        @cursor.index = 8
        $tower_idx = @cursor.index
      end
    end
    
    # マウスの左クリック か 決定ボタン押下
    if (Input.mouse_push?(M_LBUTTON) && $control_mode == 0) || (Input.pad_push?($attack_button) && $control_mode == 1) then
      # 誰と戦うかを決定
      if @cursor.index <= 7 then
        if @cursor.index == 0 && $player.progress >= 30 then
          battle_trantision(@cursor.index + 1)
        end
        if @cursor.index == 1 && $player.progress >= 31 then
          battle_trantision(@cursor.index + 1)
        end
        if @cursor.index == 2 && $player.progress >= 32 then
          battle_trantision(@cursor.index + 1)
        end
        if @cursor.index == 3 && $player.progress >= 33 then
          battle_trantision(@cursor.index + 1)
        end
        if @cursor.index == 4 && $player.progress >= 34 then
          battle_trantision(@cursor.index + 1)
        end
        if @cursor.index == 5 && $player.progress >= 35 then
          battle_trantision(@cursor.index + 1)
        end
        if @cursor.index == 6 && $player.progress >= 36 then
          battle_trantision(@cursor.index + 1)
        end
        if @cursor.index == 7 && $player.progress >= 37 then
          battle_trantision(@cursor.index + 1)
        end
      end
      
      if @cursor.index == 8 then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
        @scene_index = 2
        # カーソルを点滅させる
        @cursor.flash = true
        @cursor.visible = true
        $tower_idx = @cursor.index
        # 画面を徐々にフェードアウトさせる
        @fade_effect.setup(0)
      end
    end
    
    # マウスカーソルホバー
    # 操作モードが マウスモード の場合のみ
    if $control_mode == 0 then
      if mouse_widthin_button?("pride") then
         @cursor.index = 0
         $tower_idx = @cursor.index
      end
      if mouse_widthin_button?("wrath") then
         @cursor.index = 1
         $tower_idx = @cursor.index
      end
      if mouse_widthin_button?("envy") then
         @cursor.index = 2
         $tower_idx = @cursor.index
      end
      if mouse_widthin_button?("sloth") then
         @cursor.index = 3
         $tower_idx = @cursor.index
      end
      if mouse_widthin_button?("avarice") then
         @cursor.index = 4
         $tower_idx = @cursor.index
      end
      if mouse_widthin_button?("gluttony") then
         @cursor.index = 5
         $tower_idx = @cursor.index
      end
      if mouse_widthin_button?("lust") then
         @cursor.index = 6
         $tower_idx = @cursor.index
      end
      if mouse_widthin_button?("vanity") then
         @cursor.index = 7
         $tower_idx = @cursor.index
      end
      if mouse_widthin_button?("back") then
         @cursor.index = 8
         $tower_idx = @cursor.index
      end
    end
    
  end
  
  # ループ後処理
  def terminate()
    $bgm["tower"].stop(1)
  end
  
  # 次のシーンに遷移
  # 遷移しない場合は nil を返す
  def get_next_scene()
    return @next_scene
  end
  
  # 指定の戦闘に遷移する
  def battle_trantision(dungeon_id)
    # 決定音を鳴らす
    $sounds["decision"].play(1, 0)
    # フェードアウト後に戦闘シーンへ遷移させる
    @scene_index = 1
    
    $dungeon_id = 7
    # 誰と戦うか極める
    if @cursor.index == 0 then
      $wave_id = 1
    end
    if @cursor.index == 1 then
      $wave_id = 2
    end
    if @cursor.index == 2 then
      $wave_id = 3
    end
    if @cursor.index == 3 then
      $wave_id = 4
    end
    if @cursor.index == 4 then
      $wave_id = 5
    end
    if @cursor.index == 5 then
      $wave_id = 6
    end
    if @cursor.index == 6 then
      $wave_id = 7
    end
    if @cursor.index == 7 then
      $wave_id = 8
      @scene_index = 3
    end
    
    # カーソルを点滅させる
    @cursor.flash = true
    @cursor.visible = true
    $tower_idx = @cursor.index
    # 画面を徐々にフェードアウトさせる
    @fade_effect.setup(0)
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
    @button["pride"] =    [363, 16, 526, 180]         # 傲慢（ルシファー）
    @button["wrath"] =    [558, 16, 721, 180]         # 憤怒（サタン）
    @button["envy"] =     [751, 16, 914, 180]          # 嫉妬（レヴィアタン）
    @button["sloth"] =    [363, 188, 526, 350]         # 怠惰（ベルフェゴール）
    @button["avarice"] =  [558, 188, 721, 350]      # 強欲（マモン）
    @button["gluttony"] = [751, 188, 914, 350]     # 暴食（ベルゼブブ）
    @button["lust"] =     [558, 363, 721, 526]         # 色欲（アスモデウス）
    @button["vanity"] =   [751, 363, 914, 526]       # 虚飾（アロウ）
    
    # ホーム画面に戻るボタン
    @button["back"] = [10, 212, 49, 337]   # 薬草を買うボタン    
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
end
