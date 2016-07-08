require 'dxruby'
require_relative 'Cursor.rb'
require_relative 'Fade_Effect.rb'
require_relative 'Save_Data.rb'
require_relative 'Scene_Base.rb'
require_relative 'Scene_Battle.rb'
require_relative 'Scene_Home.rb'
include Save_Data

class Scene_Select_Battale < Scene_Base
  
  def initialize()
    super
    # フェードアウト/フェードイン用の演出クラスを準備
    @fade_effect = Fade_Effect.new
    @fade_effect.setup(1)
    
    # 各ボタン選択用カーソル
    @cursor = Cursor.new([[144, 237], [144, 293], [144, 354], [144, 411], [144, 466], [3, 496]])
    # 各ボタン座標の初期化
    button_setup()
    
    # 背景画像の読込
    @background = Image.load("image/background/map.png")
    
    # ダンジョンアイコン画像の読込
    @dungeon_icon = nil
    
    case $dungeon_id
    when 1
      @dungeon_icon = Image.load("image/background/cave_icon.jpg")
    when 2
      @dungeon_icon = Image.load("image/background/forest_icon.jpg")
    when 3
      @dungeon_icon = Image.load("image/background/mansion_icon.jpg")
    when 4
      @dungeon_icon = Image.load("image/background/volcano_icon.jpg")
    when 5
      @dungeon_icon = Image.load("image/background/ice_world_icon.jpg")
    when 6
      @dungeon_icon = Image.load("image/background/castle_icon.jpg")
    end
    
    # ダンジョン名の表示準備
    @dungeon_font = Font.new(32)
    @dungeon_name = nil
    case $dungeon_id
    when 1
      @dungeon_name = "試練の洞窟"
    when 2
      @dungeon_name = "迷いの森"
    when 3
      @dungeon_name = "死霊の館"
    when 4
      @dungeon_name = "火吹き山"
    when 5
      @dungeon_name = "氷の世界"
    when 6
      @dungeon_name = "魔王城"
    end
    
    width = @dungeon_font.get_width(@dungeon_name)
    @dungeon_x = 445 / 2 - width / 2
    @dungeon_y = 57 / 2 - @dungeon_font.size / 2
    @dungeon_x += 354
    @dungeon_y += 99
    
    # ステップ名描画用フォント
    @step_font = Font.new(24)
    
    # 説明文の描画用フォント
    @memo_font = Font.new(32)
    @memo = Array.new
    case $dungeon_id
    when 1
      @memo.push("街の近くにある洞窟で")
      @memo.push("弱い魔物が住み着いて")
      @memo.push("いる。")
      @memo.push("弱いとはいえ街から近い")
      @memo.push("ので厄介な場所だ。")
      @memo.push("魔物たちを倒してきてく")
      @memo.push("れ。頼んだぞ！")
    when 2
      @memo.push("隣国と通じる森の道が")
      @memo.push("魔物で溢れている。")
      @memo.push("そのせいで今では")
      @memo.push("迷いの森なんて呼ばれ")
      @memo.push("てるんだ。")
      @memo.push("このままじゃ隣国と")
      @memo.push("行き来できねぇ。")
    when 3
      @memo.push("町外れにある廃墟から")
      @memo.push("夜な夜な魔物が這い出て")
      @memo.push("くるらしいんだ。")
      @memo.push("どうやら死霊の棲家に")
      @memo.push("なってるようだな。")
      @memo.push("迷惑だから倒してきて")
      @memo.push("くれ。")
    when 4
      @memo.push("火吹き山には希少な")
      @memo.push("鉱物が眠っているらしい")
      @memo.push("んだが、強い魔物ばかり")
      @memo.push("揃っている。")
      @memo.push("このままじゃ鉱物が")
      @memo.push("とれねぇ。")
      @memo.push("なんとかしてくれ")
    when 5
      @memo.push("氷の世界と呼ばれる領域")
      @memo.push("は魔王の国との国境だ。")
      @memo.push("しばしば魔王軍の兵士が")
      @memo.push("越境しているとの情報を")
      @memo.push("得た。")
      @memo.push("何とか水際で防がなくて")
      @memo.push("はならない。")
    when 6
      @memo.push("いよいよ魔王との決戦だ")
      @memo.push("な。お前ならきっと")
      @memo.push("やってくれると信じてる")
      @memo.push("ぜ！！")
      @memo.push("さぁ、行って来い！")
    end
  end
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
    @prev_mouse_pos = [Input.mouse_x, Input.mouse_y] # 前回マウス座標
    @wait_frame = 0
    @scene_index = 0
    $step_id = 0
  end
  
  # フレーム更新処理
  def update()
    # 画面の描画
    draw()
    
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
      # ホームシーンに移行
      if @scene_index == 2 then
        @next_scene = Scene_Home.new
      end
    else
      return
    end
    
    # キー入力処理
    control_mode_change()
    
    # ボタン処理
    if Input.pad_push?(P_UP) then
      if @cursor.index > 0 then
        @cursor.index -= 1
      end
    end
    
    if Input.pad_push?(P_RIGHT) then
      if @cursor.index == 5 then
        @cursor.index = 0
      end
    end
    
    if Input.pad_push?(P_DOWN) then
      if @cursor.index < 5 then
        @cursor.index += 1
      end
    end
    
    if Input.pad_push?(P_LEFT) then
      if @cursor.index != 5 then
        @cursor.index = 5
      end
    end
    
    # マウスのホバー処理
    # マウスカーソルホバー
    # 操作モードが マウスモード の場合のみ
    if $control_mode == 0 then
      if mouse_widthin_button?("step1") then
         @cursor.index = 0
      end
      if mouse_widthin_button?("step2") then
         @cursor.index = 1
      end
      if mouse_widthin_button?("step3") then
         @cursor.index = 2
      end
      if mouse_widthin_button?("step4") then
         @cursor.index = 3
      end
      if mouse_widthin_button?("step5") then
         @cursor.index = 4
      end
      if mouse_widthin_button?("back") then
         @cursor.index = 5
      end
    end
    
    # マウスの左クリック か 決定ボタン押下
    if (Input.mouse_push?(M_LBUTTON) && $control_mode == 0) || (Input.pad_push?(P_BUTTON0) && $control_mode == 1) then
      if @cursor.index < 5 then
        dungeon_trantision(@cursor.index + 1)
      else
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
        # フェードアウト後に戦闘シーンへ遷移させる
        @scene_index = 2
        # カーソルを点滅させる
        @cursor.flash = true
        # 画面を徐々にフェードアウトさせる
        @fade_effect.setup(0)
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

  # 各ボタンの座標配列を初期化します
  # 0: 左上X座標 1: 左上Y座標 2: 右下X座標 3: 右下Y座標
  def button_setup()
    @button = Hash.new
    
    #各ボタンの範囲46
    @button["step1"] = [169, 226, 431, 272]
    @button["step2"] = [169, 282, 431, 328]
    @button["step3"] = [169, 340, 431, 386]
    @button["step4"] = [169, 397, 431, 443]
    @button["step5"] = [169, 453, 431, 499]
    @button["back"]  = [17,  487, 137, 529]
    
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
  
  # コントロールモードのチェンジ
  def control_mode_change()
    d = ((Input.mouse_x - @prev_mouse_pos[0]) ** 2).abs
    d += ((Input.mouse_y - @prev_mouse_pos[1]) ** 2).abs
    d = Math.sqrt(d)
    
    if d > 32 then
      $control_mode = 0
      Input.mouse_enable = true
    end
    
    if Input.pad_push?(P_UP) || Input.pad_push?(P_LEFT) || Input.pad_push?(P_RIGHT) || Input.pad_push?(P_DOWN) then
      $control_mode = 1
      Input.mouse_enable = false
    end
    
    @prev_mouse_pos = [Input.mouse_x, Input.mouse_y]
  end

  # 指定のダンジョンに遷移する
  def dungeon_trantision(step_id)
    # 進行度の計算
    progress = ($dungeon_id - 1) * 5
    progress += (step_id)
    progress -= 1
    
    if progress <= $player.progress then
      # 決定音を鳴らす
      $sounds["decision"].play(1, 0)
      # ステップID設定
      $step_id = step_id
      # フェードアウト後に戦闘シーンへ遷移させる
      @scene_index = 1
      # カーソルを点滅させる
      @cursor.flash = true
      # BGM を停止する
      $bgm["home"].stop(2.5)
      # 画面を徐々にフェードアウトさせる
      @fade_effect.setup(0)
    end
  end

  
  # 画面の描画
  def draw()
    # 背景画像の描画
    Window.draw(0, 0, @background)
    
    #ダンジョンアイコンを描画
    Window.draw(170, 61, @dungeon_icon)
    
    # ダンジョン名の描画
    Window.draw_font(@dungeon_x, @dungeon_y, @dungeon_name, @dungeon_font)
    
    # 各ステップの描画
    Window.draw_font(180, 239, "Step 1. 入り口", @step_font)
    Window.draw_font(180, 295, "Step 2. 序盤戦", @step_font)
    Window.draw_font(180, 355, "Step 3. 中盤戦", @step_font)
    Window.draw_font(180, 412, "Step 4. 終盤戦", @step_font)
    Window.draw_font(180, 468, "Step 5. ボス戦", @step_font)
    
    # クリア済みかどうか
    if get_progress(1) <= $player.progress then
      Window.draw_font(355, 249, "CLEAR", @step_font)
    end
    if get_progress(2) <= $player.progress then
      Window.draw_font(355, 306, "CLEAR", @step_font)
    end
    if get_progress(3) <= $player.progress then
      Window.draw_font(355, 364, "CLEAR", @step_font)
    end
    if get_progress(4) <= $player.progress then
      Window.draw_font(355, 421, "CLEAR", @step_font)
    end
    if get_progress(5) <= $player.progress then
      Window.draw_font(355, 477, "CLEAR", @step_font)
    elsif $player.cleared == true
      Window.draw_font(355, 477, "CLEAR", @step_font)
    end
    
    # 説明文の描画
    x = 469
    y = 242
    
    @memo.each{|line|
      Window.draw_font(x, y, line, @memo_font)
      y = y + @memo_font.size
    }
    
    # カーソルの描画
    @cursor.update
  end
  
  # 進行度の計算
  def get_progress(step_id)
    progress = ($dungeon_id - 1) * 5
    progress += (step_id)
    return progress
  end

end
