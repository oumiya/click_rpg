require 'dxruby'
require_relative 'Scene_Base.rb'
require_relative 'Scene_Home.rb'
require_relative 'Fade_Effect.rb'
require_relative 'Save_Data.rb'
include Save_Data

# ホーム画面
class Scene_Shop < Scene_Base
  # 髪型アイテム
  class Hair_Item
    attr_accessor :name
    attr_accessor :price
    attr_accessor :key
    
    def initialize(name, price, key)
      @name = name
      @price = price
      @key = key
    end
  end
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
    # 遷移先シーンを格納
    @next_scene = nil
    
    @font = Font.new(32, "ＭＳ ゴシック")
    
    # アイテム名の当たり判定を作成
    @item_hitbox = Array.new
    sy = 0
    y = 84
    for i in 1..9 do
      sy = y + (@font.size + 8) * i
      @item_hitbox.push([311, sy, 311 + (@font.size * 9), sy + @font.size])
    end
    
    # ボタンの当たり判定を作成
    @button_hitbox = Hash.new
    @button_hitbox["weapon"] = [296, 20, 395, 68]
    @button_hitbox["armor"] = [398, 20, 510, 68]
    @button_hitbox["hair"] = [513, 20, 623, 68]
    @button_hitbox["quit"] = [762, 20, 908, 68]
    @button_hitbox["next_page"] = [302, 503, 466, 533]
    @button_hitbox["prev_page"] = [748, 503, 914, 533]
    
    # フェードアウト/フェードイン用の演出クラスを準備
    @fade_effect = Fade_Effect.new
    @fade_effect.setup(1)
    
    @scene_index = 0
    
    # 今選択されているタブ
    @tab_index = 0
    
    @wait_frame = 0
    
    # 髪型リストの作成
    @hair_list = Array.new
    @hair_list.push(Hair_Item.new("くせ毛ショート", 150, "unruly"))
    @hair_list.push(Hair_Item.new("ショート", 150, "short"))
    @hair_list.push(Hair_Item.new("クルーカット", 150, "crew_cut"))
    @hair_list.push(Hair_Item.new("ソフトモヒカン", 150, "short_mohawk"))
    @hair_list.push(Hair_Item.new("モヒカン", 150, "mohawk"))
    @hair_list.push(Hair_Item.new("ガイル", 150, "guile"))
    @hair_list.push(Hair_Item.new("セミロング", 150, "semi_long"))
    @hair_list.push(Hair_Item.new("ロング", 150, "long"))
    @hair_list.push(Hair_Item.new("ツインテール", 150, "tails"))
  end
  
  # フレーム更新処理
  def update()
    # 罫線の描画
    Window.draw_box(295, 70, 910, 110, [255, 255, 255])
    Window.draw_box(296, 71, 909, 109, [255, 255, 255])
    Window.draw_box(295, 110, 910, 495, [255, 255, 255])
    Window.draw_box(296, 111, 909, 494, [255, 255, 255])
    Window.draw_box(296, 111, 909, 494, [255, 255, 255])
    Window.draw_box(12, 24, 264, 62, [255, 255, 255])
    Window.draw_box(11, 23, 265, 63, [255, 255, 255])
    Window.draw_box(295, 18, 396, 70, [255, 255, 255])
    Window.draw_box(294, 19, 397, 69, [255, 255, 255])
    Window.draw_box(397, 18, 511, 69, [255, 255, 255])
    Window.draw_box(397, 19, 512, 69, [255, 255, 255])
    Window.draw_box(512, 18, 624, 69, [255, 255, 255])
    Window.draw_box(512, 19, 625, 69, [255, 255, 255])
    Window.draw_box(760, 18, 910, 69, [255, 255, 255])
    Window.draw_box(761, 19, 909, 69, [255, 255, 255])
    
    # 所持金の描画
    Window.draw_font(20, 26, "所持金", @font)
    Window.draw_font(128, 26, sprintf("%8d", $player.gold), @font)
    
    # タブの描画
    if @tab_index == 0 then
      Window.draw_font(311, 26, "武器", @font, {:color=>[255, 128, 0]})
    else
      Window.draw_font(311, 26, "武器", @font)
    end
    
    if @tab_index == 1 then
      Window.draw_font(423, 26, "防具", @font, {:color=>[255, 128, 0]})
    else
      Window.draw_font(423, 26, "防具", @font)
    end
    
    if @tab_index == 2 then
      Window.draw_font(535, 26, "髪型", @font, {:color=>[255, 128, 0]})
    else
      Window.draw_font(535, 26, "髪型", @font)
    end
    
    Window.draw_font(774, 26, "店を出る", @font)
    
    Window.draw_font(311, 74, "アイテム名", @font)
    Window.draw_font(624, 74, "金額", @font)
    Window.draw_font(794, 74, "所持数", @font)
    
    Window.draw_font(19, 94, "アイテム名を", @font)
    Window.draw_font(19, 134, "左クリックで購入", @font)
    Window.draw_font(19, 174, "右クリックで売却", @font)
    Window.draw_font(19, 214, "売却額は購入額の", @font)
    Window.draw_font(19, 254, "半額だぜ！", @font)
    
    Window.draw_font(303, 503, "前のページ", @font)
    Window.draw_font(750, 503, "次のページ", @font)
    
    # アイテムリストの表示
    y = 84
    if @tab_index == 0 then
      # 武器リストの表示
      for i in 1..9 do
        Window.draw_font(311, y + (@font.size + 8) * i, "あああああああああ", @font)
        Window.draw_font(624, y + (@font.size + 8) * i, "99999999", @font)
        Window.draw_font(794, y + (@font.size + 8) * i, "999999", @font)
      end
    elsif @tab_index == 1 then
      # 防具リストの表示
      for i in 1..9 do
        Window.draw_font(311, y + (@font.size + 8) * i, "いいいいいいいいい", @font)
        Window.draw_font(624, y + (@font.size + 8) * i, "99999999", @font)
        Window.draw_font(794, y + (@font.size + 8) * i, "999999", @font)
      end
    elsif @tab_index == 2 then
      # 髪型リストの表示
      i = 1
      @hair_list.each{|h|
        Window.draw_font(311, y + (@font.size + 8) * i, h.name, @font)
        Window.draw_font(624, y + (@font.size + 8) * i, sprintf("%8d", h.price), @font)
        
        has_hair = false
        $player.have_hair.each{|have_hair|
          if h.key == have_hair then
            has_hair = true
            break
          end
        }
        
        if has_hair then
          Window.draw_font(794, y + (@font.size + 8) * i, "     1", @font)
        else
          Window.draw_font(794, y + (@font.size + 8) * i, "     0", @font)
        end
        
        i += 1
      }
    end
    
    # 指定のフレーム数ウェイト
    if @wait_frame > 0 then
      @wait_frame -= 1
      return
    end
    
    # フェードアウト/フェードインの表示
    @fade_effect.update
    if @fade_effect.effect_end? then
      if @scene_index == 1 then
        @next_scene = Scene_Home.new
      end
    else
      return
    end
    
    if Input.mouse_push?(M_LBUTTON) then
      # 武器ボタンを押下
      if mouse_widthin_button?("weapon") then
        @tab_index = 0
      end
      # 防具ボタンを押下
      if mouse_widthin_button?("armor") then
        @tab_index = 1
      end
      # 髪型ボタンを押下
      if mouse_widthin_button?("hair") then
        @tab_index = 2
      end
      # 店を出るボタンを押下
      if mouse_widthin_button?("quit") then
        @fade_effect.setup(0)
        @scene_index = 1
      end
      # 次のページボタンを押下
      if mouse_widthin_button?("next_page") then
        
      end
      # 前のページボタンを押下
      if mouse_widthin_button?("prev_page") then
        
      end
      # アイテム名を左クリック
      i = 0
      idx = -1
      @item_hitbox.each{|hitbox|
        
        if Input.mouse_x >= hitbox[0] &&
           Input.mouse_y >= hitbox[1] &&
           Input.mouse_x <= hitbox[2] &&
           Input.mouse_y <= hitbox[3] then
           idx = i
           break
        end
        i = i + 1
      }
      
      if idx > -1 then
        if $player.gold > @hair_list[i].price then
        
          has_hair = false
          $player.have_hair.each{|have_hair|
            if @hair_list[i].key == have_hair then
              has_hair = true
              break
            end
          }
          
          if has_hair == false then
            $player.have_hair.push(@hair_list[i].key)
            $player.gold -= @hair_list[i].price
            $player.hair = @hair_list[i].key
          end
          
        end
      end
    end
    
    
    
    
    # アイテム名ホバーすると四角が出る
    @item_hitbox.each{|hitbox|
      
      if Input.mouse_x >= hitbox[0] &&
         Input.mouse_y >= hitbox[1] &&
         Input.mouse_x <= hitbox[2] &&
         Input.mouse_y <= hitbox[3] then
         
         Window.draw_box(hitbox[0], hitbox[1], hitbox[2], hitbox[3], [255, 0, 0])
         
      end
    }
    
    
  end
  
  # ループ後処理
  def terminate()
    
  end
  
  # 次のシーンに遷移
  # 遷移しない場合は nil を返す
  def get_next_scene()
    return @next_scene
  end
  
    # マウスカーソルがボタンの座標内に入っているかどうかを返します
  def mouse_widthin_button?(button_name)
    hitbox = @button_hitbox[button_name]
    
    res = false
    
    if Input.mouse_x >= hitbox[0] &&
       Input.mouse_y >= hitbox[1] &&
       Input.mouse_x <= hitbox[2] &&
       Input.mouse_y <= hitbox[3] then
       
       res = true
       
    end
    
    return res
  end

end
