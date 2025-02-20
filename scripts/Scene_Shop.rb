require_relative 'Scene_Base.rb'
require_relative 'Scene_Home.rb'
require_relative 'Fade_Effect.rb'
require_relative 'Message_Box.rb'
require_relative 'Save_Data.rb'
include Save_Data

# ショップ画面
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
    @button_hitbox["next_page"] = [748, 503, 914, 533]
    @button_hitbox["prev_page"] = [440, 503, 604, 533]
    
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
    
    # カーソル
    cursor_pos = Array.new
    cursor_pos.push([279, 32])  # 0  武器ボタン
    cursor_pos.push([390, 32])  # 1  防具ボタン
    cursor_pos.push([503, 32])  # 2  髪型ボタン
    cursor_pos.push([743, 32])  # 3  店を出るボタン
    cursor_pos.push([277, 128]) # 4  道具セレクト1
    cursor_pos.push([277, 168]) # 5  道具セレクト2
    cursor_pos.push([277, 208]) # 6  道具セレクト3
    cursor_pos.push([277, 248]) # 7  道具セレクト4
    cursor_pos.push([277, 288]) # 8  道具セレクト5
    cursor_pos.push([277, 328]) # 9  道具セレクト6
    cursor_pos.push([277, 368]) # 10 道具セレクト7
    cursor_pos.push([277, 408]) # 11 道具セレクト8
    cursor_pos.push([277, 448]) # 12 道具セレクト9
    cursor_pos.push([10, 366])  # 13 装備品以外を一括で売却
    cursor_pos.push([408, 508]) # 14 前のページ
    cursor_pos.push([718, 508]) # 15 次のページ
    @cursor = Cursor.new(cursor_pos)
    
    @wait_frame = 0
    
    # 表示するメッセージ
    @message = nil
    
    # 一括売却ボタンのフォント
    @sell_font = Font.new(20, "ＭＳ ゴシック")
    
    # ページの最大数
    @weapon_page = 0
    @armor_page = 0
    @max_weapon_page = ($player.sell_weapon.size.to_f / 9.0).ceil
    @max_armor_page = ($player.sell_armor.size.to_f / 9.0).ceil
    
    @prev_mouse_pos = [Input.mouse_x, Input.mouse_y] # 前回マウス座標
    
    # スキルアイコン画像の読込
    @skill_icons = Array.new
    @skill_icons.push(Image.load("image/skill/00_thumb_heal.png"))
    @skill_icons.push(Image.load("image/skill/01_thumb_guard_range_up.png"))
    @skill_icons.push(Image.load("image/skill/02_thumb_super_attack.png"))
    @skill_icons.push(Image.load("image/skill/03_thumb_up_attack.png"))
    @skill_icons.push(Image.load("image/skill/04_thumb_up_guard.png"))
    @skill_icons.push(Image.load("image/skill/05_thumb_down_attack.png"))
    @skill_icons.push(Image.load("image/skill/06_thumb_down_guard.png"))
    @skill_icons.push(Image.load("image/skill/07_thumb_shout.png"))
    @skill_icons.push(Image.load("image/skill/08_thumb_reverse.png"))
  end
  
  # 画面の描画
  def draw()
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
    
    if @tab_index == 2 then
      Window.draw_font(794, 74, "所持数", @font)
    end
    
    Window.draw_font(19, 94, "アイテム名を", @font)
    Window.draw_font(19, 134, "左クリックで購入", @font)

    Window.draw_font(19, 214, "売却額は購入額の", @font)
    Window.draw_font(19, 254, "半額だぜ！", @font)
    
    Message_Box.show("装備品以外を一括で売却", 26, 353, @sell_font)
    
    # アイテムリストの表示
    y = 84
    if @tab_index == 0 then
      # 武器リストの表示
      start_i = @weapon_page * 9
      end_i = start_i + 8
      if end_i >= $player.sell_weapon.length then
        end_i = $player.sell_weapon.length - 1
      end
      
      idx = 1
      for i in start_i..end_i do
        weapon = $weapondata.get_weapon_data($player.sell_weapon[i]["idx"])
        # 武器名の表示長さを取得
        text_width = @font.get_width($player.sell_weapon[i]["name"])
        # 武器名の表示
        Window.draw_font(311, y + (@font.size + 8) * idx, $player.sell_weapon[i]["name"], @font)
        # スキルアイコンの表示
        if $player.sell_weapon[i]["skill"] > -1 then
          Window.draw(311 + text_width + 2, y + (@font.size + 8) * idx, @skill_icons[$player.sell_weapon[i]["skill"]])
        end
        # 価格の表示
        Window.draw_font(624, y + (@font.size + 8) * idx, sprintf("%8d", weapon[:price] * ($player.sell_weapon[i]["bonus"] + 1)), @font)
        idx += 1
      end
    elsif @tab_index == 1 then
      # 防具リストの表示
      start_i = @armor_page * 9
      end_i = start_i + 8
      if end_i >= $player.sell_armor.length then
        end_i = $player.sell_armor.length - 1
      end
      
      idx = 1
      for i in start_i..end_i do
        armor = $armordata.get_armor_data($player.sell_armor[i]["idx"])
        Window.draw_font(311, y + (@font.size + 8) * idx, $player.sell_armor[i]["name"], @font)
        Window.draw_font(624, y + (@font.size + 8) * idx, sprintf("%8d", armor[:price] * ($player.sell_armor[i]["bonus"] + 1)), @font)
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
    
    if @tab_index == 0 && @weapon_page > 0 then
      Window.draw_font(441, 503, "前のページ", @font)
    end
    
    if @tab_index == 1 && @armor_page > 0 then
      Window.draw_font(441, 503, "前のページ", @font)
    end
    
    if @tab_index == 0 && @weapon_page + 1 < @max_weapon_page then
      Window.draw_font(750, 503, "次のページ", @font)
    end
    
    if @tab_index == 1 && @armor_page + 1 < @max_armor_page then
      Window.draw_font(750, 503, "次のページ", @font)
    end
    
    # カーソルの表示
    @cursor.update
    
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
      if @scene_index == 1 then
        @next_scene = Scene_Home.new
      end
    else
      return
    end
    
    # コントロールモードの変更
    control_mode_change()
    
    # 次のページに遷移した時、さらにその次のページが無かったらカーソルをリストの最初に移動させる
    if @cursor.index == 15 then
      if @tab_index == 0 && @weapon_page + 1 == @max_weapon_page then
        @cursor.index = 4
      end
      if @tab_index == 1 && @armor_page + 1 == @max_armor_page then
        @cursor.index = 4
      end
    end
    
    # 前のページに遷移した時、さらにその前のページが無かったらカーソルをリストの最後に移動させる
    if @cursor.index == 14 then
      if @tab_index == 0 && @weapon_page == 0 then
        @cursor.index = 12
      end
      if @tab_index == 1 && @armor_page  == 0 then
        @cursor.index = 12
      end
    end
    
    # カーソルキーの操作
    if Input.pad_push?(P_UP) then
      if @cursor.index == 4 then
        @cursor.index = 0
      elsif @cursor.index > 4 && @cursor.index <= 12 then
        @cursor.index -= 1
      elsif @cursor.index == 13 then
        @cursor.index = 0
      elsif @cursor.index == 14 then
        @cursor.index = 12
      elsif @cursor.index == 15 then
        @cursor.index = 12
      end
    end
    if Input.pad_push?(P_LEFT) then
      if @cursor.index == 0 then
        @cursor.index = 13
      elsif @cursor.index >= 1 && @cursor.index <= 3 then
        @cursor.index -= 1
      elsif @cursor.index >= 4 && @cursor.index <= 12
        @cursor.index = 13
      elsif @cursor.index == 14 then
        @cursor.index = 13
      elsif @cursor.index == 15 then
        @cursor.index = 14
      end
    end
    if Input.pad_push?(P_RIGHT) then
      if @cursor.index == 3 then
        @cursor.index = 0
      elsif @cursor.index >= 0 && @cursor.index <= 2 then
        @cursor.index += 1
      elsif @cursor.index == 13 then
        @cursor.index = 0
      elsif @cursor.index == 14 then
        @cursor.index = 15
      end
    end
    if Input.pad_push?(P_DOWN) then
      if @cursor.index >= 0 && @cursor.index <= 3 then
        @cursor.index = 4
      elsif @cursor.index >= 4 && @cursor.index < 12 then
        @cursor.index += 1
      elsif @cursor.index == 12 then
        @cursor.index = 14
      elsif @cursor.index == 13 then
        @cursor.index = 13
      end
    end
    
    if (Input.mouse_push?(M_LBUTTON) && $control_mode == 0) || (Input.pad_push?($attack_button) && $control_mode == 1) then
      
      # 武器ボタンを押下
      if @cursor.index == 0 then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
        @tab_index = 0
      end
      # 防具ボタンを押下
      if @cursor.index == 1 then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
        @tab_index = 1
      end
      # 髪型ボタンを押下
      if @cursor.index == 2 then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
        @tab_index = 2
      end
      # 店を出るボタンを押下
      if @cursor.index == 3 then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
        @fade_effect.setup(0)
        @scene_index = 1
      end
      
      # 次のページボタンを押下
      if @cursor.index == 15 then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
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
      if @cursor.index == 14 then
        # 決定音を鳴らす
        $sounds["decision"].play(1, 0)
        
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
      
      
      # 一括売却ボタンを押下
      if @cursor.index == 13 then

        $sounds["decision"].play(1, 0)
        
        total = 0
        
        # 武器売却処理
        if $player.have_weapon.size > 1 then
          save_weapon = Array.new
          save_weapon.push({"idx"=>$player.have_weapon[$player.equip_weapon]["idx"], "name"=>$player.have_weapon[$player.equip_weapon]["name"], "element"=>$player.have_weapon[$player.equip_weapon]["element"], "bonus"=>$player.have_weapon[$player.equip_weapon]["bonus"], "value"=>$player.have_weapon[$player.equip_weapon]["value"], "skill"=>$player.have_weapon[$player.equip_weapon]["skill"]})
          
          for i in 0..$player.have_weapon.size - 1 do
            if $player.have_weapon[i]["idx"] == 24 && $player.equip_weapon != i then
              save_weapon.push({"idx"=>$player.have_weapon[i]["idx"], "name"=>$player.have_weapon[i]["name"], "element"=>$player.have_weapon[i]["element"], "bonus"=>$player.have_weapon[i]["bonus"], "value"=>$player.have_weapon[i]["value"], "skill"=>$player.have_weapon[i]["skill"]})
            end
          end
          
          for i in 0..$player.have_weapon.size - 1 do
            if $player.equip_weapon != i && $player.have_weapon[i]["idx"] != 24 then
              total += $weapondata.get_weapon_data($player.have_weapon[i]["idx"])[:price]
              $player.sell_weapon.push($player.have_weapon[i])
            end
          end
          
          $player.have_weapon.clear
          for i in 0..save_weapon.size - 1 do
            $player.have_weapon.push(save_weapon[i])
          end
          $player.equip_weapon = 0
          
          $player.sort_sell_weapon()
          $player.sort_weapon()
        end
        
        # 防具売却処理
        if $player.have_armor.size > 1 then
          save_armor = Array.new
          save_armor.push({"idx"=>$player.have_armor[$player.equip_armor]["idx"], "name"=>$player.have_armor[$player.equip_armor]["name"], "element"=>$player.have_armor[$player.equip_armor]["element"], "bonus"=>$player.have_armor[$player.equip_armor]["bonus"], "heal"=>$player.have_armor[$player.equip_armor]["heal"], "value"=>$player.have_armor[$player.equip_armor]["value"]})
          
          for i in 0..$player.have_armor.size - 1 do
            if $player.have_armor[i]["idx"] == 24 && $player.equip_armor != i then
              save_armor.push({"idx"=>$player.have_armor[i]["idx"], "name"=>$player.have_armor[i]["name"], "element"=>$player.have_armor[i]["element"], "bonus"=>$player.have_armor[i]["bonus"], "heal"=>$player.have_armor[i]["heal"], "value"=>$player.have_armor[i]["value"]})
            end
          end

          for i in 0..$player.have_armor.size - 1 do
            if $player.equip_armor != i && $player.have_armor[i]["idx"] != 24 then
              total += $armordata.get_armor_data($player.have_armor[i]["idx"])[:price]
              $player.sell_armor.push($player.have_armor[i])
            end
          end
          
          $player.have_armor.clear
          for i in 0..save_armor.size - 1 do
            $player.have_armor.push(save_armor[i])
          end
          $player.equip_armor = 0
          
          $player.sort_sell_armor()
          $player.sort_armor()
        end
        
        total = total / 2
        
        $player.gold += total
        
      end
      
      # アイテム名を左クリック
      if @cursor.index >= 4 && @cursor.index <= 12 then
        $sounds["decision"].play(1, 0)
        idx = @cursor.index - 4
        # 武器購入処理
        if @tab_index == 0 then
          idx = idx + @weapon_page * 9
          if idx < $player.sell_weapon.size then
            weapon = $player.sell_weapon[idx]
            if weapon != nil then
              price = $weapondata.get_weapon_data(weapon["idx"])[:price] * (weapon["bonus"] + 1)
              if $player.gold >= price then
                # 武器を所持品に追加
                $player.have_weapon.push(weapon)
                $player.sort_weapon()
                # プレイヤーの所持金から代金を減算
                $player.gold -= price
                @message = "ありがとよ！"
                @wait_frame = 60
              else
                @message = "お金が足りないぜ"
                @wait_frame = 60
              end
            end
          end
        end
        # 防具購入処理
        if @tab_index == 1 then
          idx = idx + @armor_page * 9
          if idx < $player.sell_armor.size then
            armor = $player.sell_armor[idx]
            if armor != nil then
              price = $armordata.get_armor_data(armor["idx"])[:price] * (armor["bonus"] + 1)
              if $player.gold >= price then
                # 指定の防具を所持品に追加
                $player.have_armor.push(armor)
                $player.sort_armor()
                # プレイヤーの所持金から代金を減算
                $player.gold -= price
                @message = "ありがとよ！"
                @wait_frame = 60
              else
                @message = "お金が足りないぜ"
                @wait_frame = 60
              end
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

    # 右クリックで街に戻る
    if (Input.mouse_push?(M_RBUTTON) && $control_mode == 0) then
      @cursor.index = 3
      # 決定音を鳴らす
      $sounds["decision"].play(1, 0)
      @fade_effect.setup(0)
      @scene_index = 1
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
      # 店を出るボタン
      if mouse_widthin_button?("quit") then
        @cursor.index = 3
      end
      # 一括売却ボタン
      if mouse_widthin_button?("bulk1") then
        @cursor.index = 13
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

      # 前のページボタンを押下
      if mouse_widthin_button?("prev_page") then
        if @tab_index == 0 && @weapon_page > 0 then
          @cursor.index = 14
        end
        if @tab_index == 1 && @armor_page > 0 then
          @cursor.index = 14
        end
      end
      # 次のページボタンを押下
      if mouse_widthin_button?("next_page") then
        if @tab_index == 0 && @weapon_page + 1 < @max_weapon_page then
          @cursor.index = 15
        end
        if @tab_index == 1 && @armor_page + 1 < @max_armor_page then
          @cursor.index = 15
        end
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