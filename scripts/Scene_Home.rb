require 'dxruby'
require_relative 'Scene_Base.rb'
require_relative 'Scene_Battle.rb'

# ホーム画面
class Scene_Home < Scene_Base
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
    # フェードアウト用の黒い四角
    @black_box = Image.new(Game_Main::WINDOW_WIDTH, Game_Main::WINDOW_HEIGHT, C_BLACK)
    @back_image = Image.load("image/system/home.png")
    @cursor = Image.load("image/system/cursor.png")
    
    @status_font = Font.new(18)
    
    @button_push = false
    @cursor_index = 0
    @cursor_visible = false
    
    @next_scene = nil
    
    # プレイヤーを全回復させておく
    $player.hp = $player.max_hp
    
    $bgm["home"].play(0, 0)
  end
  
  # フレーム更新処理
  def update()
    # ホーム画面を描画
    Window.draw(0, 0, @back_image)
    
    # 主人公ステータスの表示
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
    y += 20
    Window.draw_font_ex(x, y, "知るか！", @status_font) # 次のレベルまで
    
    # 主人公のつぶやき
    Window.draw_font(208, 253, "うひひ　頑張るぞ！", @status_font, {:color => [0, 0, 0]})
    Window.draw_font(208, 253+18, "うひひ　頑張るぞ！", @status_font, {:color => [0, 0, 0]})
    Window.draw_font(208, 253+36, "うひひ　頑張るぞ！", @status_font, {:color => [0, 0, 0]})

    # 洞窟を選択
    if Input.mouse_push?(M_LBUTTON) then
      if Input.mouse_x >= 147 &&
         Input.mouse_y >= 43 &&
         Input.mouse_x <= 310 &&
         Input.mouse_y <= 206 then
         
         $sounds["decision"].play(1, 0) # 決定音を鳴らす
         
         # ダンジョンIDを1に設定
         $dungeon_id = 1
         
         @cursor_index = 1
         @button_push = true
         
         @wait_count = 95
         @fade_out_count = 60
         @cursor_visible = true
         @alpha = 0
         @cursor_x = 143
         @cursor_y = 39
      end
    end
    
    # ボタン押下後イベント
    if @button_push then
      case @cursor_index
      when 1
        if @wait_count > 0 then
          # 決定音が鳴り終わるまでカーソルを点滅させる
          @wait_count -= 1
          if @wait_count % 3 == 0 then
            if @cursor_visible then
              @cursor_visible = false
            else
              @cursor_visible = true
            end
          end
          
          if @cursor_visible then
            Window.draw(@cursor_x, @cursor_y, @cursor)
          end
          
        else
          # 画面を徐々にフェードアウトさせる
          if @fade_out_count > 0 then
            Window.draw_alpha(0, 0, @black_box, @alpha, z=1000)
            @fade_out_count -= 1
            @alpha += 4
          else
            Window.draw_alpha(0, 0, @black_box, 255, z=1000)
            @next_scene = Scene_Battle.new
          end
        end
      end
    else
      # マウスカーソルホバー
      if Input.mouse_x >= 147 &&
         Input.mouse_y >= 43 &&
         Input.mouse_x <= 310 &&
         Input.mouse_y <= 206 then
         # 洞窟にマウスカーソルがホバーされている
         Window.draw(143, 39, @cursor)
      end
    end
    
    
  end
  
  # ループ後処理
  def terminate()
    $bgm["home"].stop(0)
  end
  
  # 次のシーンに遷移
  # 遷移しない場合は nil を返す
  def get_next_scene()
    return @next_scene
  end

end
