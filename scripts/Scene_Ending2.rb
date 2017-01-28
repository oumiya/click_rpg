require 'dxruby'
require_relative 'Cursor.rb'
require_relative 'Fade_Effect.rb'
require_relative 'Message_Box.rb'
require_relative 'Save_Data.rb'
require_relative 'Scene_Base.rb'
require_relative 'Scene_Home.rb'
include Save_Data

# エンディング画面
class Scene_Ending2 < Scene_Base
  
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
    # フェードアウト/フェードイン用の演出クラスを準備
    @fade_effect = Fade_Effect.new
    @fade_effect.setup(1)
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
    @staff_roll.push(Staff.new("　　　　ハンペソ（@kandendenka ）"))
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
    # 描画処理
    draw()
    
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
    
    @frame += 1
    
    if @frame == 1 then
      @stall_roll_visible = true
      $bgm["ending"].play(0, 1)
    end
    
    if @end == true && @transition == false then
      p "unko"
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
    # スタッフロールを描画
    staff_roll_draw()
    if @end == true then
      width = @staff_font.get_width("2017 しかわ")
      x = Game_Main::WINDOW_WIDTH / 2 - width / 2
      y = Game_Main::WINDOW_HEIGHT / 2 - @staff_font.size / 2
      Window.draw_font(x, y, "2017 しかわ", @staff_font, {:z=>5002})
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
