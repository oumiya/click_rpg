require 'dxruby'
require_relative 'Cursor.rb'
require_relative 'Fade_Effect.rb'
require_relative 'Message_Box.rb'
require_relative 'Save_Data.rb'
require_relative 'Scene_Base.rb'
require_relative 'Scene_Home.rb'
include Save_Data

# 装備変更画面
class Scene_Equip < Scene_Base
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
      @item_hitbox.push([449, sy, 449 + (@font.size * 9), sy + @font.size])
    end
    
    # ボタンの当たり判定を作成
    @button_hitbox = Hash.new
    @button_hitbox["weapon"] = [434, 20, 533, 68]
    @button_hitbox["armor"] = [536, 20, 648, 68]
    @button_hitbox["hair"] = [651, 20, 761, 68]
    @button_hitbox["quit"] = [762, 20, 908, 68]
    @button_hitbox["next_page"] = [748, 503, 914, 533]
    @button_hitbox["prev_page"] = [440, 503, 604, 533]
    
    # 髪色選択ボタンの当たり判定を作成
    @hair_hitbox = Array.new
    x = 120
    y = 102
    i = 0
    $hair.colors.each{|key, value|
      i = i + 1
      @hair_hitbox.push([x, y, x+32, y+32])
      x += 33
      if i == 6 then
        x = 120
        y += 32
      end
    }
    
    # 肌色選択の当たり判定を作成
    @skin_colors = [[255, 243, 228], [253, 227, 226], [252, 218, 181], [223, 177, 144],
                   [201, 138,  69], [189, 123, 101], [138,  90,  52], [ 92,  38,  36]]
    @skin_hitbox = Array.new
    x = 120
    y = 174
    i = 0
    @skin_colors.each{|value|
      i += 1
      @skin_hitbox.push([x, y, x+32, y+32])
      x += 33
    }
    
    # フェードアウト/フェードイン用の演出クラスを準備
    @fade_effect = Fade_Effect.new
    @fade_effect.setup(1)
    
    @scene_index = 0
    
    # 今選択されているタブ
    @tab_index = 0
    
    # 今選択されている武器ページ
    @weapon_page = 0
    
    # 今選択されている防具ページ
    @armor_page = 0
    
    # カーソル 0 武器ボタン 1 防具 ボタン 2 髪型ボタン 3 街に戻るボタン 4 ～ 12 武器か防具選択ボタン 13 前のページ 14 次のページ
    @cursor = Cursor.new([[414,25], [528, 25], [640, 25], [742, 25], [415, 128], [415, 168], [415, 208], [415, 248], [415, 288], [415, 328], [415, 368], [415, 408], [415, 448], [408, 508], [718, 508]])
    
    @wait_frame = 0
    
    # 表示するメッセージ
    @message = nil
    
    # 現在持っている武器リストを作る
    @weapons = Array.new
    for i in 0..$player.have_weapon.size-1 do
      if $player.have_weapon[i][1] > 0 then
        @weapons.push(i)
      end
    end
    
    # 現在持っている防具リストを作る
    @armors = Array.new
    for i in 0..$player.have_armor.size-1 do
      if $player.have_armor[i][1] > 0 then
        @armors.push(i)
      end
    end
    
    # ページの最大数
    @max_weapon_page = (@weapons.size.to_f / 9.0).ceil
    @max_armor_page = (@armors.size.to_f / 9.0).ceil
    
    @prev_mouse_pos = [Input.mouse_x, Input.mouse_y] # 前回マウス座標
  end
  
  # フレーム更新処理
  def update()
    # アバターの描画
    Window.draw(29, 285, $avater[$player.skin_color])
    
    # 防具の描画
    $armordata.draw
    
    # 髪型を描画
    $hair.draw
    
    # 髪色選択ボックスを描画
    Window.draw_font(12, 102, "髪の色", @font)
    x = 120
    y = 102
    i = 0
    $hair.colors.each{|key, value|
      i += 1
      Window.draw_box_fill(x, y, x+32, y+32, value)
      x += 33
      if i == 6 then
        x = 120
        y += 32
      end
    }
    
    # 肌色選択ボックスを描画
    Window.draw_font(12, 174, "肌の色", @font)
    x = 120
    y = 174
    i = 0
    @skin_colors.each{|value|
      i += 1
      Window.draw_box_fill(x, y, x+32, y+32, value)
      x += 33
    }
    
    # 肌色選択ボックスを描画
    
    # 攻撃力の描画
    Window.draw_font(12, 26, "攻撃力", @font)
    Window.draw_font(120, 26, $player.real_ATK.to_s, @font)
    Window.draw_font(12, 64, "防御力", @font)
    Window.draw_font(120, 64, $player.real_DEF.to_s, @font)

    # 罫線の描画
    Window.draw_box(433, 70, 910, 110, [255, 255, 255])
    Window.draw_box(434, 71, 909, 109, [255, 255, 255])
    Window.draw_box(433, 110, 910, 495, [255, 255, 255])
    Window.draw_box(434, 111, 909, 494, [255, 255, 255])
    Window.draw_box(433, 18, 534, 70, [255, 255, 255])
    Window.draw_box(432, 19, 535, 69, [255, 255, 255])
    Window.draw_box(535, 18, 649, 69, [255, 255, 255])
    Window.draw_box(535, 19, 650, 69, [255, 255, 255])
    Window.draw_box(650, 18, 762, 69, [255, 255, 255])
    Window.draw_box(650, 19, 763, 69, [255, 255, 255])
    Window.draw_box(760, 18, 910, 69, [255, 255, 255])
    Window.draw_box(761, 19, 909, 69, [255, 255, 255])
    
    # タブの描画
    if @tab_index == 0 then
      Window.draw_font(449, 26, "武器", @font, {:color=>[255, 128, 0]})
    else
      Window.draw_font(449, 26, "武器", @font)
    end
    
    if @tab_index == 1 then
      Window.draw_font(561, 26, "防具", @font, {:color=>[255, 128, 0]})
    else
      Window.draw_font(561, 26, "防具", @font)
    end
    
    if @tab_index == 2 then
      Window.draw_font(673, 26, "髪型", @font, {:color=>[255, 128, 0]})
    else
      Window.draw_font(673, 26, "髪型", @font)
    end
    
    Window.draw_font(774, 26, "街に戻る", @font)
    
    Window.draw_font(449, 74, "アイテム名", @font)
    Window.draw_font(794, 74, "所持数", @font)
    
    Window.draw_font(441, 503, "前のページ", @font)
    Window.draw_font(750, 503, "次のページ", @font)
    
    # アイテムリストの表示
    y = 84
    if @tab_index == 0 then
      # 武器リストの表示
      start_i = @weapon_page * 9
      end_i = start_i + 8
      if end_i >= @weapons.length then
        end_i = @weapons.length - 1
      end
      
      idx = 1
      for i in start_i..end_i do
        weapon = $weapondata.get_weapon_data(@weapons[i])
        have_count = $player.have_weapon[@weapons[i]][1]
        if @weapons[i] == $player.equip_weapon then
          Window.draw_font(449, y + (@font.size + 8) * idx, weapon[:name] + " E", @font)
        else
          Window.draw_font(449, y + (@font.size + 8) * idx, weapon[:name], @font)
        end
        Window.draw_font(794, y + (@font.size + 8) * idx, sprintf("%6d", have_count), @font)
        idx += 1
      end
    elsif @tab_index == 1 then
      # 防具リストの表示
      start_i = @armor_page * 9
      end_i = start_i + 8
      if end_i >= @armors.length then
        end_i = @armors.length - 1
      end
      
      idx = 1
      for i in start_i..end_i do
        armor = $armordata.get_armor_data(@armors[i])
        have_count = $player.have_armor[@armors[i]][1]
        if @armors[i] == $player.equip_armor then
          Window.draw_font(449, y + (@font.size + 8) * idx, armor[:name] + " E", @font)
        else
          Window.draw_font(449, y + (@font.size + 8) * idx, armor[:name], @font)
        end
        Window.draw_font(794, y + (@font.size + 8) * idx, sprintf("%6d", have_count), @font)
        idx += 1
      end
    elsif @tab_index == 2 then
      # 髪型リストの表示
      i = 1
      $hair_list.each{|h|
        if $player.hair == h.key then
          Window.draw_font(449, y + (@font.size + 8) * i, h.name + " E", @font)
        else
          Window.draw_font(449, y + (@font.size + 8) * i, h.name, @font)
        end
        
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
    
    # カーソルの表示
    @cursor.update
    
    # 髪の色と肌の色を変更するための注意文
    fnt = Font.new(24)
    Window.draw_font(14, 219, "髪の色と肌の色はマウスで", fnt)
    Window.draw_font(14, 219 + fnt.size + 4, "色をクリックすると変更できます", fnt)
    if @message != nil then
      Message_Box.show(@message)
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
    
    # コントロールモードの変更
    control_mode_change()
    
    # カーソルキーの操作
    if Input.pad_push?(P_UP) then
      if @cursor.index == 4 then
        @cursor.index = 0
      elsif @cursor.index > 4 && @cursor.index <= 12 then
        @cursor.index -= 1
      elsif @cursor.index > 12 then
        @cursor.index = 12
      end
    end
    if Input.pad_push?(P_LEFT) then
      if @cursor.index == 0 then
        @cursor.index = 3
      elsif @cursor.index >= 1 && @cursor.index <= 3 then
        @cursor.index -= 1
      elsif @cursor.index == 13 then
        @cursor.index = 14
      elsif @cursor.index == 14 then
        @cursor.index = 13
      end
    end
    if Input.pad_push?(P_RIGHT) then
      if @cursor.index == 3 then
        @cursor.index = 0
      elsif @cursor.index >= 0 && @cursor.index <= 2 then
        @cursor.index += 1
      elsif @cursor.index == 13 then
        @cursor.index = 14
      elsif @cursor.index == 14 then
        @cursor.index = 13
      end
    end
    if Input.pad_push?(P_DOWN) then
      if @cursor.index >= 0 && @cursor.index <= 3 then
        @cursor.index = 4
      elsif @cursor.index >= 4 && @cursor.index < 13 then
        @cursor.index += 1
      end
    end
    
    if (Input.mouse_push?(M_LBUTTON) && $control_mode == 0) || (Input.pad_push?(P_BUTTON0) && $control_mode == 1) then
      # 武器ボタンを押下
      if @cursor.index == 0 then
        @tab_index = 0
      end
      # 防具ボタンを押下
      if @cursor.index == 1 then
        @tab_index = 1
      end
      # 髪型ボタンを押下
      if @cursor.index == 2 then
        @tab_index = 2
      end
      # 店を出るボタンを押下
      if @cursor.index == 3 then
        @fade_effect.setup(0)
        @scene_index = 1
      end
      # 次のページボタンを押下
      if @cursor.index == 14 then
        if @tab_index == 0 then
          if @max_weapon_page > 1 then
            @weapon_page += 1
            if @weapon_page >= @max_weapon_page then
              @weapon_page = @max_weapon_page - 1
            end
          end
        end
        if @tab_index == 1 then
          if @max_armor_page > 1 then
            @armor_page += 1
            if @armor_page >= @max_armor_page then
              @armor_page = @max_armor_page - 1
            end
          end
        end
      end
      
      # 前のページボタンを押下
      if @cursor.index == 13 then
        if @tab_index == 0 then
          @weapon_page -= 1
          if @weapon_page < 0 then
            @weapon_page = 0
          end
        end
        if @tab_index == 1 then
          @armor_page -= 1
          if @armor_page < 0 then
            @armor_page = 0
          end
        end
      end
      
      # アイテム名を左クリック
      if @cursor.index >= 4 && @cursor.index <= 12 then
        idx = @cursor.index - 4
        # 武器装備処理
        if @tab_index == 0 then
          idx = idx + @weapon_page * 9
          if idx < @weapons.size then
            $player.equip_weapon = @weapons[idx]
          end
        end
        # 防具装備処理
        if @tab_index == 1 then
          idx = idx + @armor_page * 9
          if idx < @armors.size then
            $player.equip_armor = @armors[idx]
          end
        end
        # 髪型装備処理
        if @tab_index == 2 then
          has = false
          $player.have_hair.each{|h|
            if h == $hair_list[idx].key then
              has = true
              break
            end
          }
          if has then
            $player.hair = $hair_list[idx].key
          end
        end
      end
      # 髪の色選択ボタンをクリック
      idx = -1
      @hair_hitbox.each_with_index{|hitbox, i|
        if Input.mouse_x >= hitbox[0] &&
           Input.mouse_y >= hitbox[1] &&
           Input.mouse_x <= hitbox[2] &&
           Input.mouse_y <= hitbox[3] then
           idx = i
           break
        end
      }
      
      if idx > -1 then
        # 髪色変更処理
        if idx == 0 then
          $player.hair_color = "white"
        end
        if idx == 1 then
          $player.hair_color = "black"
        end
        if idx == 2 then
          $player.hair_color = "natural"
        end
        if idx == 3 then
          $player.hair_color = "brown"
        end
        if idx == 4 then
          $player.hair_color = "beige"
        end
        if idx == 5 then
          $player.hair_color = "blue"
        end
        if idx == 6 then
          $player.hair_color = "green"
        end
        if idx == 7 then
          $player.hair_color = "gold"
        end
        if idx == 8 then
          $player.hair_color = "copper"
        end
        if idx == 9 then
          $player.hair_color = "red"
        end
        if idx == 10 then
          $player.hair_color = "violet"
        end
        if idx == 11 then
          $player.hair_color = "pink"
        end
      end
      
      # 髪の色選択ボタンをクリック
      idx = -1
      @skin_hitbox.each_with_index{|hitbox, i|
        if Input.mouse_x >= hitbox[0] &&
           Input.mouse_y >= hitbox[1] &&
           Input.mouse_x <= hitbox[2] &&
           Input.mouse_y <= hitbox[3] then
           idx = i
           break
        end
      }
      
      if idx > -1 then
        $player.skin_color = idx
      end
    end
    
    # マウスホバー処理
    if $control_mode == 0 then
      # 武器ボタン
      if mouse_widthin_button?("weapon") then
        @cursor.index = 0
      end
      # 防具ボタン
      if mouse_widthin_button?("armor") then
        @cursor.index = 1
      end
      # 髪型ボタン
      if mouse_widthin_button?("hair") then
        @cursor.index = 2
      end
      # 店を出る
      if mouse_widthin_button?("quit") then
        @cursor.index = 3
      end    
      # 前のページボタンを押下
      if mouse_widthin_button?("prev_page") then
        @cursor.index = 13
      end
      # 次のページボタンを押下
      if mouse_widthin_button?("next_page") then
        @cursor.index = 14
      end
      
      # アイテム名ホバーすると四角が出る
      @item_hitbox.each_with_index{|hitbox, i|
        
        if Input.mouse_x >= hitbox[0] &&
           Input.mouse_y >= hitbox[1] &&
           Input.mouse_x <= hitbox[2] &&
           Input.mouse_y <= hitbox[3] then
           
           @cursor.index = i + 4
        end
      }
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
