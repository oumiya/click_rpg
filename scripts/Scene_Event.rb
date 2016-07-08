require 'dxruby'
require_relative 'Scene_Battle.rb'
require_relative 'Scene_Ending.rb'
require_relative 'Scene_Event.rb'
require_relative 'Scene_Equip.rb'
require_relative 'Scene_Home.rb'
require_relative 'Scene_Shop.rb'

# イベントを制御するシーンクラス
class Scene_Event < Scene_Base
  
  # インスタンスを生成する時にファイル名を指定すること
  # イベントファイルは event フォルダに格納すること
  def initialize(event_filename)
    @event_data = nil
    @idx = 0
    File.open("event/" + event_filename) do |file|
      @event_data = file.read.split("\n")
    end
    @wait_frame = 0
  end
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
    # 背景画像のハッシュ
    @background_data = Hash.new
    # 背景画像表示用のimage
    @background = nil
    # キャラクター画像のハッシュ
    @character_data = Hash.new
    # 左表示のキャラクター
    @left_character = nil
    # 中央表示のキャラクター
    @center_character = nil
    # 右表示のキャラクター
    @right_character = nil
    # 一枚絵画像のハッシュ
    @picture_data = Hash.new
    # 一枚絵表示用image
    @picture = nil
    # BGMのハッシュ
    @music_data = Hash.new
    # BGM用Ayameインスタンス
    @music = nil
    # SEのハッシュ
    @sound = Hash.new
    # SEのAyameインスタンス
    @se = nil
    # フェードアウト/フェードイン用の演出クラスを準備
    @fade_effect = Fade_Effect.new
    # 描画を開始する
    @draw_start = false
    # 遷移先のシーンID 0 ～ 4
    @next_scene_id = 0
    # 遷移先のダンジョンID 1～6
    @dungeon_id = 0
    # 遷移先のシーンインスタンスを格納
    @next_scene = nil
    # キー入力待ち
    @key_wait = false
    # テキスト表示用のバッファ
    @message = nil
    # 台詞の名前枠
    @name = nil
    # テキスト表示用のフォント
    @font = Font.new(24)
    @message_window = Image.load("image/system/message_window.png")
    @message_window_state = 0 # 0 が非表示 1 が表示中 2 が表示済み 3 が消去中 で 3 から 1に戻る
    @message_window_alpha = 0
    @message_status = 0 # 1 が表示中
    @message_idx = 0
    @message_line = 0
    # ピクチャー表示用の透明度
    @picture_alpha = 0
    # ピクチャー表示モード
    # 0 何もしない 1 徐々に透明度を低くする 255 に達したら 0 に戻る
    # 2 徐々に透明度を高くする 0 に達したら 0 に戻る
    @picture_mode = 0
  end
  
  # フレーム更新処理
  def update()
    draw()
    
    # ピクチャーの表示待ち
    if @picture_mode == 1 then
      if @picture != nil then
        @picture_alpha += 4
        if @picture_alpha >= 255 then
          @picture_alpha = 255
          @picture_mode = 0
        end
        return
      else
        @picture_mode = 0
      end
    end
    
    # ピクチャーの消去待ち
    if @picture_mode == 2 then
      if @picture != nil then
        @picture_alpha -= 4
        if @picture_alpha <= 0 then
          @picture_alpha = 0
          @picture = nil
          @picture_mode = 0
        end
        return
      else
        @picture_mode = 0
      end
    end
    
    # フェードアウト/フェードインの表示
    @fade_effect.update
    if @fade_effect.effect_end? == false then
      return
    end
    
    # ウェイト処理
    return if wait?
    
    # メッセージウィンドウの表示/消去中
    if @message_window_state == 1 || @message_window_state == 3 then
      return
    end
    
    # メッセージの表示中
    if @message_status == 1 then
      return
    end
    
    # キー入力待ち
    if @key_wait == true then
      if Input.mouse_push?(M_LBUTTON) || Input.pad_push?(P_BUTTON0) then
        @message = nil
        @name = nil
        @key_wait = false
      end
      return
    end
    
    # コマンド処理
    command_call()
  end
  
  # ループ後処理
  def terminate()
    if @music != nil then
      @music.stop(1)
    end
  end
  
  # 次のシーンに遷移
  # 遷移しない場合は nil を返す
  def get_next_scene()
    return @next_scene
  end
  
  def draw()
    # 描画開始命令が出たら描画を開始する
    if @draw_start == true then
      # 背景画像の描画
      if @background != nil then
        Window.draw(0, 0, @background)
      end
      # キャラクターの描画
      if @left_character != nil then
        x = Game_Main::WINDOW_WIDTH / 3 - @left_character.width / 2
        y = Game_Main::WINDOW_HEIGHT - @left_character.height
        Window.draw(x, y, @left_character)
      end
      if @center_character != nil then
        x = Game_Main::WINDOW_WIDTH / 2 - @center_character.width / 2
        y = Game_Main::WINDOW_HEIGHT - @center_character.height
        Window.draw(x, y, @center_character)
      end
      if @right_character != nil then
        x = (Game_Main::WINDOW_WIDTH / 3) * 2 - @right_character.width / 2
        y = Game_Main::WINDOW_HEIGHT - @right_character.height
        Window.draw(x, y, @right_character)
      end
      # 一枚絵の表示
      if @picture != nil then
        Window.draw_alpha(0, 0, @picture, @picture_alpha)
      end
      # メッセージの描画
      if @message_window_state == 1 || @message_window_state == 3 then
        Window.draw_alpha(76, 372, @message_window, @message_window_alpha)
        if @message_window_state == 1 then
          @message_window_alpha += 9
          if @message_window_alpha > 255
            @message_window_alpha = 255
            @message_window_state = 2
          end
        end
        if @message_window_state == 3 then
          @message_window_alpha -= 9
          if @message_window_alpha < 0 then
            @message_window_alpha = 0
            @message_window_state = 0
          end
        end
        return
      end
      if @message_window_state == 2 then
        Window.draw(76, 372, @message_window)
      end
      if @name != nil && @message != nil then
        Window.draw_font(84, 380, @name, @font)
        
        y = 416
        n = @message_line
        if @message_line >= @message.size then
          n -= 1
          @message_status = 0
        end
        
        for i in 0..n do
          line = @message[i]
          j = line.size
          if i == @message_line then
            @message_idx += 1
            j = @message_idx
            if @message_idx >= line.size then
              @message_idx = 0
              @message_line += 1
            end
          end
          Window.draw_font(86, y, line[0, j], @font)
          y = y + @font.size
        end

      end
    end
  end
  
  def command_call()
    # イベント命令が終わっていたらホーム画面に遷移する
    if @idx >= @event_data.size then
      case @next_scene_id
      when 0
        @next_scene = Scene_Home.new
      when 1
        $dungeon_id = @dungeon_id
        @next_scene = Scene_Battle.new
      when 2
        @next_scene = Scene_Equip.new
      when 3
        @next_scene = Scene_Shop.new
      when 4
        $scene = nil
      else
        @next_scene = Scene_Home.new
      end
    end
    
    command = nil
    argument1 = nil
    argument2 = nil
    commands = @event_data[@idx]
    return if commands == nil
    command_data = commands.split(":")
    
    if command_data.size == 2 then
      command = command_data[0].strip
      
      arguments = command_data[1].split(",")
      
      if arguments.size > 1 then
        argument1 = arguments[0].strip
        argument2 = arguments[1].strip
      else
        argument1 = command_data[1].strip
      end
    else
      command = command_data[0].strip
    end
    
    case command
    when "bg_load"
      bg_load(argument1, argument2)
    when "chr_load"
      chr_load(argument1, argument2)
    when "pic_load"
      pic_load(argument1, argument2)
    when "bgm_load"
      bgm_load(argument1, argument2)
    when "se_load"
      se_load(argument1, argument2)
    when "mes"
      @message_window_state = 1
      mes(argument1, argument2)
    when "bg"
      bg(argument1)
    when "chr"
      charcter(argument1, argument2)
    when "pic"
      @message_window_state = 3
      picture(argument1)
    when "bg_clear"
      bg_clear
    when "chr_clear"
      chr_clear(argument1)
    when "pic_clear"
      @message_window_state = 3
      pic_clear
    when "bgm"
      bgm(argument1)
    when "bgm_stop"
      bgm_stop()
    when "se"
      se(argument1)
    when "se_stop"
      se_stop()
    when "fade_in"
      @message_window_state = 3
      fade_in()
    when "fade_out"
      @message_window_state = 3
      @fade_effect.setup(0)
    when "wait"
      set_wait_frame(argument1.to_i)
    when "scene"
      set_next_scene(argument1.to_i, argument2.to_i)
    end
    
    @idx += 1
  end
  
  # 背景画像を読み込む
  def bg_load(tag, filename)
    @background_data[tag] = Image.load("image/event/" + filename)
  end
  
  # キャラクター画像を読み込む
  def chr_load(tag, filename)
    @character_data[tag] = Image.load("image/event/" + filename)
  end
  
  # 一枚絵を読み込む
  def pic_load(tag, filename)
    @picture_data[tag] = Image.load("image/event/" + filename)
  end
  
  # BGMを読み込む
  def bgm_load(tag, filename)
    @music_data[tag] = Ayame.new("audio/bgm/" + filename)
  end
  
  # SEを読み込む
  def se_load(tag, filename)
    @sound[tag] = Ayame.new("audio/se/" + filename)
  end
  
  # 文章を表示
  def mes(name, message)
    @name = name
    @message = message.split("<br>")
    @key_wait = true
    @message_status = 1 # 1 が表示中
    @message_idx = 0
    @message_line = 0
  end
  
  # 背景画像を表示
  def bg(tag)
    @background = @background_data[tag]
  end
  
  # キャラクターを表示
  def charcter(tag, position)
    if position == "center"
      @center_character = @character_data[tag]
    elsif position == "right"
      @right_character = @character_data[tag]
    else
      @left_character = @character_data[tag]
    end
  end
  
  # 一枚絵を表示
  def picture(tag)
    @picture = @picture_data[tag]
    @picture_alpha = 0
    @picture_mode = 1
  end
  
  # 背景画像を消去
  def bg_clear()
    @background = nil
  end
  
  # キャラクター画像を消去
  def chr_clear(position)
    case position
    when "left"
      @left_character = nil
    when "center"
      @center_character = nil
    when "right"
      @right_character = nil
    end
  end
  
  # ピクチャーを消去
  def pic_clear()
    @picture_alpha = 255
    @picture_mode = 2
  end
  
  # BGM を再生
  def bgm(tag)
    if @music != nil then
      @music.stop(1)
    end
    
    @music = @music_data[tag]
    @music.play(0, 1)
  end
  
  # BGM を停止
  def bgm_stop()
    if @music != nil then
      @music.stop(1)
    end
  end
  
  # 効果音を再生
  def se(tag)
    @se = @sound[tag]
    @se.play(1, 0)
  end
  
  # 効果音を停止
  def se_stop()
    if @se != nil then
      @se.stop(0)
    end
  end
  
  # フェードイン/描画開始
  def fade_in()
    @draw_start = true
    @fade_effect.setup(1)
  end
  
  # ウェイトフレームに値を代入
  def set_wait_frame(frame)
    @wait_frame = frame
  end
  
  # 遷移先シーンを決める
  def set_next_scene(scene_id, dungeon_id)
    @next_scene_id = scene_id
    @dungeon_id = dungeon_id
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
