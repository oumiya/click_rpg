require 'dxruby'
require_relative 'Scene_Base.rb'
require_relative 'Scene_Home.rb'
require_relative 'Fade_Effect.rb'
require_relative 'Message_Box.rb'
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
    @button_hitbox["bulk1"] = [28, 355, 276, 403]
    @button_hitbox["bulk2"] = [28, 422, 276, 495]
    
    # フェードアウト/フェードイン用の演出クラスを準備
    @fade_effect = Fade_Effect.new
    @fade_effect.setup(1)
    
    # 画像を読み込み
    @messages = Array.new
    @messages.push(Image.load("image/system/thankyou.png"))
    @messages.push(Image.load("image/system/you_have.png"))
    @messages.push(Image.load("image/system/you_not_have.png"))
    @messages.push(Image.load("image/system/not_enough_money2.png"))
    @messages.push(Image.load("image/system/not_sell_weapon.png"))
    @messages.push(Image.load("image/system/not_sell_armor.png"))
    
    @scene_index = 0
    
    # 今選択されているタブ
    @tab_index = 0
    
    @wait_frame = 0
    
    # 表示するメッセージ
    @message = nil
    
    # 一括売却ボタンのフォント
    @sell_font = Font.new(20, "ＭＳ ゴシック")
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
    
    Message_Box.show("装備品以外を一括で売却", 26, 353, @sell_font)
    Message_Box.show("装備品以外を一個残して<br>一括で売却", 26, 420, @sell_font)
    
    # アイテムリストの表示
    y = 84
    if @tab_index == 0 then
      # 武器リストの表示
      start_i = 0
      end_i = start_i + 8
      
      idx = 1
      for i in start_i..end_i do
        weapon = $weapondata.get_weapon_data(i)
        have_count = $player.have_weapon[i][1]
        Window.draw_font(311, y + (@font.size + 8) * idx, weapon[:name], @font)
        Window.draw_font(624, y + (@font.size + 8) * idx, sprintf("%8d", weapon[:price]), @font)
        Window.draw_font(794, y + (@font.size + 8) * idx, sprintf("%6d", have_count), @font)
        idx += 1
      end
    elsif @tab_index == 1 then
      # 防具リストの表示
      start_i = 0
      end_i = start_i + 8
      if end_i >= $armordata.length then
        end_i = $armordata.length - 1
      end
      
      idx = 1
      for i in start_i..end_i do
        armor = $armordata.get_armor_data(i)
        have_count = $player.have_armor[i][1]
        Window.draw_font(311, y + (@font.size + 8) * idx, armor[:name], @font)
        Window.draw_font(624, y + (@font.size + 8) * idx, sprintf("%8d", armor[:price]), @font)
        Window.draw_font(794, y + (@font.size + 8) * idx, sprintf("%6d", have_count), @font)
        idx += 1
      end
    elsif @tab_index == 2 then
      # 髪型リストの表示
      i = 1
      $hair_list.each{|h|
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
    
    if @message != nil then
      idx = 0
      if @message == "ありがとよ！" then
        idx = 0
      end
      if @message == "あんた、それもう持ってるぜ" then
        idx = 1
      end
      if @message == "お客さんはそいつを持ってないぜ！" then
        idx = 2
      end
      if @message == "お金が足りないぜ" then
        idx = 3
      end
      if @message == "装備中の武器は売れないぜ！" then
        idx = 4
      end
      if @message == "装備中の防具は売れないぜ！" then
        idx = 5
      end
      x = Game_Main::WINDOW_WIDTH / 2 - @messages[idx].width / 2
      y = Game_Main::WINDOW_HEIGHT / 2 - @messages[idx].height / 2
      Window.draw(x, y, @messages[idx])
      if @wait_frame <= 0 then
        @message = nil
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
      if @scene_index == 1 then
        @next_scene = Scene_Home.new
      end
    else
      return
    end
    
    if Input.mouse_push?(M_LBUTTON) then
      
      # 武器ボタンを押下
      if mouse_widthin_button?("weapon") then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
        @tab_index = 0
      end
      # 防具ボタンを押下
      if mouse_widthin_button?("armor") then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
        @tab_index = 1
      end
      # 髪型ボタンを押下
      if mouse_widthin_button?("hair") then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
        @tab_index = 2
      end
      # 店を出るボタンを押下
      if mouse_widthin_button?("quit") then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
        @fade_effect.setup(0)
        @scene_index = 1
      end
      # 一括売却ボタンを押下
      if mouse_widthin_button?("bulk1") then
        $sounds["decision"].play(1, 0)
        # 武器売却処理
        $player.have_weapon.each_with_index{|weapon, idx|
          if weapon[1] > 0 then
            total = 0
            # 装備しているか？
            if $player.equip_weapon == idx && weapon[1] > 1 then
              total == weapon[1] - 1
              weapon[1] = 1
            elsif $player.equip_weapon == idx && weapon[1] == 1 then
              total = 0
            else
              total = weapon[1]
              weapon[1] = 0
            end
            
            if total > 0
              total *= $weapondata.get_weapon_data(idx)[:price] / 2
              $player.gold += total
            end
          end
        }
        
        # 防具売却処理
        $player.have_armor.each_with_index{|armor, idx|
          if armor[1] > 0 then
            total = 0
            # 装備しているか？
            if $player.equip_armor == idx && armor[1] > 1 then
              total == armor[1] - 1
              armor[1] = 1
            elsif $player.equip_armor == idx && armor[1] == 1 then
              total = 0
            else
              total = armor[1]
              armor[1] = 0
            end
            
            if total > 0
              total *= $armordata.get_armor_data(idx)[:price] / 2
              $player.gold += total
            end
          end
        }
      end
      # 1個だけ残して一括売却ボタンを押下
      if mouse_widthin_button?("bulk2") then
        $sounds["decision"].play(1, 0)
        $sounds["decision"].play(1, 0)
        # 武器売却処理
        $player.have_weapon.each_with_index{|weapon, idx|
          if weapon[1] > 0 then
            total = 0
            # 装備しているか？
            if $player.equip_weapon == idx && weapon[1] > 2 then
              total == weapon[1] - 1
              weapon[1] = 1
            elsif $player.equip_weapon == idx && weapon[1] == 1 then
              total = 0
            else
              total = weapon[1] - 1
              weapon[1] = 1
            end
            
            if total > 0
              total *= $weapondata.get_weapon_data(idx)[:price] / 2
              $player.gold += total
            end
          end
        }
        
        # 防具売却処理
        $player.have_armor.each_with_index{|armor, idx|
          if armor[1] > 0 then
            total = 0
            # 装備しているか？
            if $player.equip_armor == idx && armor[1] > 2 then
              total == armor[1] - 1
              armor[1] = 1
            elsif $player.equip_armor == idx && armor[1] == 1 then
              total = 0
            else
              total = armor[1] - 1
              armor[1] = 1
            end
            
            if total > 0
              total *= $armordata.get_armor_data(idx)[:price] / 2
              $player.gold += total
            end
          end
        }
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
           # 決定音を鳴らす
           $sounds["decision"].play(1, 0)
           break
        end
        i = i + 1
      }
      
      if idx > -1 then
        # 武器購入処理
        if @tab_index == 0 then
          weapon = $weapondata.get_weapon_data(idx)
          if weapon != nil then
            if $player.gold >= weapon[:price] then
              $player.have_weapon[idx][1] += 1
              $player.gold -= weapon[:price]
              @message = "ありがとよ！"
              @wait_frame = 60
            else
              @message = "お金が足りないぜ"
              @wait_frame = 60
            end
          end
        end
        # 防具購入処理
        if @tab_index == 1 then
          armor = $armordata.get_armor_data(idx)
          if armor != nil then
            if $player.gold >= armor[:price] then
              $player.have_armor[idx][1] += 1
              $player.gold -= armor[:price]
              @message = "ありがとよ！"
              @wait_frame = 60
            else
              @message = "お金が足りないぜ"
              @wait_frame = 60
            end
          end
        end
        # 髪型購入処理
        if @tab_index == 2 then
          if $player.gold >= $hair_list[idx].price then
            has_hair = false
            $player.have_hair.each{|have_hair|
              if $hair_list[idx].key == have_hair then
                has_hair = true
                break
              end
            }
            
            if has_hair then
              @message = "あんた、それもう持ってるぜ"
              @wait_frame = 60
            else
              $player.have_hair.push($hair_list[idx].key)
              $player.gold -= $hair_list[idx].price
              $player.hair = $hair_list[idx].key
              @message = "ありがとよ！"
              @wait_frame = 60
            end
          
          else
            @message = "お金が足りないぜ"
            @wait_frame = 60
          end
        end
      end
    end
    
    # 売却処理
    if Input.mouse_push?(M_RBUTTON) then
      # アイテム名を右クリック
      i = 0
      idx = -1
      @item_hitbox.each{|hitbox|
        
        if Input.mouse_x >= hitbox[0] &&
           Input.mouse_y >= hitbox[1] &&
           Input.mouse_x <= hitbox[2] &&
           Input.mouse_y <= hitbox[3] then
           idx = i
           # 決定音を鳴らす
           $sounds["decision"].play(1, 0)
           break
        end
        i = i + 1
      }
      
      if idx > -1 then
        # 武器売却処理
        if @tab_index == 0 then
          weapon = $weapondata.get_weapon_data(idx)
          
          if weapon != nil then
            # 該当の武器を1コ以上持っている
            if $player.have_weapon[idx][1] > 0 then
              # 該当の武器を装備している場合 かつ 該当の武器が1個しかない場合は売れない
              if $player.equip_weapon == idx && $player.have_weapon[idx][1] == 1 then
                @message = "装備中の武器は売れないぜ！"
                @wait_frame = 60
              else
                $player.gold += weapon[:price] / 2
                $player.have_weapon[idx][1] -= 1
                @message = "ありがとよ！"
                @wait_frame = 60
              end
            else
              @message = "お客さんはそいつを持ってないぜ！"
              @wait_frame = 60
            end
          end
          
        end
        
        # 防具購入処理
        if @tab_index == 1 then
          armor = $armordata.get_armor_data(idx)
          if armor != nil then
            # 該当の防具を1コ以上持っている
            if $player.have_armor[idx][1] > 0 then
              # 該当の防具を装備している場合は売れない
              if $player.equip_armor == idx && $player.have_armor[idx][1] == 1then
                @message = "装備中の防具は売れないぜ！"
                @wait_frame = 60
              else
                $player.gold += armor[:price] / 2
                @message = "ありがとよ！"
                $player.have_armor[idx][1] -= 1
                @wait_frame = 60
              end
            else
              @message = "お客さんはそいつを持ってないぜ！"
              @wait_frame = 60
            end
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
