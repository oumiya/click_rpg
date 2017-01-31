require 'dxruby'
require_relative 'Cursor.rb'
require_relative 'Fade_Effect.rb'
require_relative 'Message_Box.rb'
require_relative 'Save_Data.rb'
require_relative 'Scene_Base.rb'
require_relative 'Scene_Home.rb'
include Save_Data

# エンディング画面
class Scene_Ending < Scene_Base
  
  class Staff
    attr_accessor :x
    attr_accessor :y
    attr_accessor :text
    
    def initialize(text)
      @x = 170
      @y = 550
      @text = text
    end
  end
  def initialize()
    super
    @wait_frame = 0
    @next_scene = nil
    # 背景画像
    @background = Image.load("image/event/castle.jpg")
    # プレイヤー
    @player_image = Image.load("image/event/ending01.png")
    @px = 163
    # 魔王
    @evilking_image = Image.load("image/event/ending00.png")
    @ex = 351
    # フェードアウト/フェードイン用の演出クラスを準備
    @fade_effect = Fade_Effect.new
    @fade_effect.setup(1)
    # キーウェイト入力待ち
    @key_wait = false
    # メッセージ表示用フォント
    @font = Font.new(24)
    # 画面を表示してからのフレーム数
    @frame = 0
    # スタッフロール
    @staff_roll = Array.new
    # 画面に表示するテキスト配列
    @staff_font = Font.new(32)
    @staff_roll.push(Staff.new("Director"))
    @staff_roll.push(Staff.new("　　　　しかわ（@OumiyaS676）"))
    @staff_roll.push(Staff.new("Game Scripter"))
    @staff_roll.push(Staff.new("　　　　しかわ（@OumiyaS676）"))
    @staff_roll.push(Staff.new("Game Desginer"))
    @staff_roll.push(Staff.new("　　　　しかわ（@OumiyaS676）"))
    @staff_roll.push(Staff.new("Graphic Desginer"))
    @staff_roll.push(Staff.new("　　　　しかわ（@OumiyaS676）"))
    @staff_roll.push(Staff.new("Test Player"))
    @staff_roll.push(Staff.new("　　　　ハンペソ（@kandendenka）"))
    @staff_roll.push(Staff.new("　　　　wtlu（@wt_ca）"))
    @staff_roll.push(Staff.new("BGM"))
    @staff_roll.push(Staff.new("　　　　魔王魂"))
    @staff_roll.push(Staff.new("　　　　http://maoudamashii.jokersounds.com/"))
    @staff_roll.push(Staff.new("Graphic"))
    @staff_roll.push(Staff.new("　　　　Alex Schwab"))
    @staff_roll.push(Staff.new("　　　　J McSporran"))
    @staff_roll.push(Staff.new("　　　　Stephane Gaudry"))
    @staff_roll.push(Staff.new("　　　　写真素材 足成"))
    @staff_roll.push(Staff.new("　　　　http://www.ashinari.com/"))
    @staff_roll.push(Staff.new("　　　　COCOON"))
    @staff_roll.push(Staff.new("　　　　http://cocoon.daa.jp/material/"))
    @staff_roll.push(Staff.new("　　　　無料素材倶楽部"))
    @staff_roll.push(Staff.new("　　　　http://sozai.7gates.net/"))
    @staff_roll.push(Staff.new("　　　　ぴぽや"))
    @staff_roll.push(Staff.new("　　　　http://piposozai.blog76.fc2.com/"))
    @staff_roll.each_with_index{|staff, idx|
      staff.y += (@staff_font.size * 2) * idx
    }
    @end = false
    @transition = false
    # 表示用メッセージ
    @message = nil
  end
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
    super
    $bgm.each{|bgm_name, bgm_ayame|
      bgm_ayame.stop(1)
    }
    $player.cleared = true
    save()
    @next_scene = nil
  end
  
  # フレーム更新処理
  def update()
    # フェードアウト/フェードインの表示
    @fade_effect.update
    if @fade_effect.effect_end? then
      if @frame > 522 then
        Window.draw_box_fill(0, 0, Game_Main::WINDOW_WIDTH-1, Game_Main::WINDOW_HEIGHT-1, [0,0,0], 1000)
      end
    else
      return
    end
    
    # ウェイト処理
    return if wait?
    
    # キー入力待ち
    if @key_wait == true then
      if Input.mouse_push?(M_LBUTTON) || Input.pad_push?($attack_button) then
        @key_wait = false
      end
      return
    end
    
    @frame += 1
    
    if @frame == 1 then
      $bgm["evil_king"].play(1, 1)
      $playing_bgm = "evil_king"
    end
    
    if @frame > 60 && @frame <= 276 then
      move_image()
    end
    
    if @frame == 218 then
      @message = "まおー<br>「まさかこの私が負けるとはな……<br>　貴様、よほど名のある勇者なのであろう"
      @key_wait = true
      @wait_frame = 15
      return
    end
    
    if @frame == 250 then
      @message = "まおー<br>「この私をどうする？<br>　くくくっ当然殺すのであろうな"
      @key_wait = true
      @wait_frame = 15
      return
    end
    
    if @frame == 282 then
      @message = "あなた<br>「いや、どうもしないさ<br>　ただ暴れるのをやめてくれればいい"
      @key_wait = true
      @wait_frame = 15
      return
    end
    
    if @frame == 312 then
      @message = "まおー<br>「ふっ……<br>　私は魔王だぞ。魔王のまおーだ<br>　好きに生きるのが魔王の運命（さだめ）だ"
      @key_wait = true
      @wait_frame = 15
      return
    end
    
    if @frame == 342 then
      @message = "あなた<br>「そうか<br>　ならいいさ<br>　また止めに来てやるよ"
      @key_wait = true
      @wait_frame = 15
      return
    end
    
    if @frame == 372 then
      @message = "まおー<br>「ふっ……<br>　甘いヤツめ！<br>　だが、ありがとう"
      @key_wait = true
      @wait_frame = 15
      return
    end
    
    if @frame == 402 then
      @message = "あなた<br>「だが俺はこう思うんだ……。<br>　もし、このゲームの有料版が出たとしたら<br>　ここで選択肢出るんだろうなって……"
      @key_wait = true
      @wait_frame = 15
      return
    end
    
    if @frame == 432 then
      @message = "まおー<br>「そ、それは一体……どういうことだ！？"
      @key_wait = true
      @wait_frame = 15
      return
    end
    
    if @frame == 462 then
      @message = "あなた<br>「おまえを☓☓☓したり☓☓☓するってことさ"
      @key_wait = true
      @wait_frame = 15
      return
    end
    
    if @frame == 492 then
      @message = "まおー<br>「よかった……お前が紳士で……<br>　ぐふっ！"
      @key_wait = true
      @wait_frame = 15
      $bgm["evil_king"].stop(1)
      return
    end
    
    if @frame == 500 then
      @message = nil
    end
    
    if @frame == 522 then
      @fade_effect.setup(0)
      $bgm["ending"].play(0, 1)
    end
    
    if @frame == 587 then
      @stall_roll_visible = true
    end
    
    if @end == true && @transition == false then
      $bgm["ending"].stop(1)
      @wait_frame = 600
      @transition = true
    end
    
    if @transition == true && @wait_frame < 1 then
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
  
  # 描画処理
  def draw()
    # 背景を描画
    Window.draw(0, 0, @background)
    # 魔王を描画
    Window.draw(@ex, 0, @evilking_image)
    # プレイヤーを描画
    Window.draw(@px, 0, @player_image)
    if @message != nil then
      Message_Box.show(@message, -1, 380, @font)
    end
    # スタッフロールを描画
    staff_roll_draw()
    if @end == true then
      width = @staff_font.get_width("Thank you for Playing!")
      x = Game_Main::WINDOW_WIDTH / 2 - width / 2
      y = Game_Main::WINDOW_HEIGHT / 2 - @staff_font.size / 2
      Window.draw_font(x, y, "Thank you for Playing!", @staff_font, {:z=>5002})
    end
  end
  
  # プレイヤーと魔王を指定の位置まで移動させる
  def move_image()
    if @ex < 507 then
      @ex += 1
    end
    if @px > 48 then
      @px -= 1
    end
  end
  
  # スタッフロールを表示する
  def staff_roll_draw()
    if @stall_roll_visible == true && @end == false then
      count = 0
      @staff_roll.each{|staff|
        staff.y -= 1
        
        if staff.y > -40 && staff.y <= 540 then
          Window.draw_font(staff.x, staff.y, staff.text, @staff_font, {:z=>5002})
        end
        
        if staff.y < -40 then
          count += 1
        end
      }
      
      if count >= @staff_roll.size then
        @end = true
      end
    end
  end
  
  # ウェイト処理
  def wait?()
    if @wait_frame > 0 then
      @wait_frame -= 1
      return true
    end
    return false
  end
end
