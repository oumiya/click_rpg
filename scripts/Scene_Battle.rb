require 'dxruby'
require_relative 'Scene_Base.rb'
require_relative 'Enemy.rb'
require_relative 'Attack_Icon.rb'
require_relative 'Guard_Rank_Text.rb'
require_relative 'Attack_Effect.rb'
require_relative 'Sparkly.rb'
require_relative 'Save_Data.rb'
require_relative 'Message_Box.rb'
include Save_Data

# 戦闘シーン
class Scene_Battle < Scene_Base
  
  ENEMY_X = 237  # 敵画像の表示原点 X座標
  ENEMY_Y = 72   # 敵画像の表示原点 Y座標

  # ダンジョン選択用カーソルクラス
  class Cursor
    attr_accessor :index
    attr_accessor :flash
    attr_accessor :visible
    
    def initialize()
      @pos = [[244, 326], [520, 326]]
      @image = Image.load("image/system/cursor.png")
      @visible = true
      @flash = false
      @index = 0
    end
    
    def update()
      if @visible then
        draw()
      end
    end
    
    def draw()
      if @flash then
        if $frame_counter % 6 > 2 then
          Window.draw(@pos[@index][0], @pos[@index][1], @image)
        end
      else
        Window.draw(@pos[@index][0], @pos[@index][1], @image)
      end
    end
  end

  def initialize()
    super
  end
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
    # フェードイン用の黒い四角を準備
    @black_box = Image.new(Game_Main::WINDOW_WIDTH, Game_Main::WINDOW_HEIGHT, C_BLACK)
    
    # 攻撃アイコンを初期化
    @attack_icons = Array.new(10){|idx| Attack_Icon.new }
    
    # ガード評価を初期化
    @guard_rank = Guard_Rank_Text.new
    
    # 攻撃エフェクトを初期化
    @attack_effect = Attack_Effect.new
    
    # 薬草の残り数を描画するためのフォントを設定
    @heal_font = Font.new(32, "ＭＳ Ｐゴシック", {"weight" => true})
    
    # 汎用テキスト用フォントを設定
    @text_font = Font.new(24, "ＭＳ Ｐゴシック", {"weight" => true})
    
    # 次の戦闘へボタンを設定
    @next_battle = Image.new(138, 42, [128, 0, 0, 0])
    @next_battle.box_fill(2, 2, 135, 39, [128, 255, 255, 255])
    @next_battle.box_fill(4, 4, 132, 37, [128, 0, 0, 0])
    @next_battle.draw_font(9, 9, "次の戦闘へ", @text_font)
    
    @dungeon_end = Image.new(138, 42, [128, 0, 0, 0])
    @dungeon_end.box_fill(2, 2, 135, 39, [128, 255, 255, 255])
    @dungeon_end.box_fill(4, 4, 132, 37, [128, 0, 0, 0])
    @dungeon_end.draw_font(9, 9, "街に戻る", @text_font)
    
    # 背景画像読み込み
    @background = nil
    case $dungeon_id
    when 1
      @background = Image.load("image/background/cave.jpg")
    when 2
      @background = Image.load("image/background/forest.jpg")
    when 3
      @background = Image.load("image/background/mansion.jpg")
    when 4
      @background = Image.load("image/background/volcano.jpg")
    when 5
      @background = Image.load("image/background/ice_world.jpg")
    when 6
      @background = Image.load("image/background/castle.jpg")
    else
      # 一応、入れておく
      @background = Image.load("image/background/cave.jpg")
    end
    
    # フィーバー画像の読み込み
    @background_fever = Image.load("image/background/fever.png")
    @sparkly = Sparkly.new
    
    # フィーバーダンスの読み込み
    @dance_image = Array.new
    @dance_image.push(Image.load_tiles("image/avater/dance01.png", 9, 1))
    @dance_image.push(Image.load_tiles("image/avater/dance02.png", 9, 1))
    @dance_image.push(Image.load_tiles("image/avater/dance03.png", 9, 1))
    @dance_image.push(Image.load_tiles("image/avater/dance04.png", 9, 1))
    @dance_image.push(Image.load_tiles("image/avater/dance05.png", 9, 1))
    @dance_image.push(Image.load_tiles("image/avater/dance06.png", 9, 1))
    @dance_image.push(Image.load_tiles("image/avater/dance07.png", 9, 1))
    @dance_image.push(Image.load_tiles("image/avater/dance08.png", 9, 1))
    @dance_index = 0
    
    # 選択カーソルの初期化
    @cursor = Cursor.new
    
    # バトルカウント
    @battle_count = 0
    # 初回戦闘前処理が終わったことを示す
    @before_end = false
    
    # 初回戦闘画面(1) 戦闘前画面(0)、戦闘中画面(1)、戦闘後画面(2)の切り替えをする
    @cut = -1
    @cut_counter = 0
    @alpha = 255
    
    # ホームに戻るかどうかを示す
    @go_home = false
    
    @next_scene = nil
  end
  
  def before_battle()
    case $dungeon_id
    when 1
      # どうくつダンジョン
      if @battle_count < 14
        @enemy = $enemydata.get_enemy(rand(6))
        @battle_count += 1
      else
        @enemy = $enemydata.get_enemy(6)
        @battle_count += 1
      end
    when 2
      # 森のダンジョン
      if @battle_count < 14
        @enemy = $enemydata.get_enemy(rand(6) + 7)
        @battle_count += 1
      else
        @enemy = $enemydata.get_enemy(13)
        @battle_count += 1
      end
    when 3
      # 死者の館
      if @battle_count < 14
        @enemy = $enemydata.get_enemy(rand(6) + 14)
        @battle_count += 1
      else
        @enemy = $enemydata.get_enemy(20)
        @battle_count += 1
      end
    end
    
    # 戦闘前テキストウィンドウの生成
    @start_window = Image.new(413, 77, [128, 0, 0, 0])
    @start_window.box_fill(2, 2, 410, 74, [128, 255, 255, 255])
    @start_window.box_fill(4, 4, 408, 72, [128, 0, 0, 0])
    @start_window.draw_font(15, 27, @enemy.name + " があらわれた！", @text_font)
    
    # 戦闘後テキストウィンドウの生成
    @win_window = Image.new(413, 200, [128, 0, 0, 0])
    @win_window.box_fill(2, 2, 410, 197, [128, 255, 255, 255])
    @win_window.box_fill(4, 4, 408, 195, [128, 0, 0, 0])
    @win_window.draw_font(15, 11, @enemy.name + " をたおした！", @text_font)
    
    # 敗北時ウィンドウの生成
    @lose_window = Image.new(413, 77, [128, 0, 0, 0])
    @lose_window.box_fill(2, 2, 410, 74, [128, 255, 255, 255])
    @lose_window.box_fill(4, 4, 408, 72, [128, 0, 0, 0])
    @lose_window.draw_font(15, 27, "あなたは ちから つきて しまった！", @text_font)
    
    # 戦闘結果 勝利なら true, 敗北ならfalseが入る
    @battle_result = true
    
    # コンボ猶予フレーム
    @combo_frame = 0
    
    # コンボ数
    @combo_count = 0
    
    # 敵攻撃時の移動ピクセル数
    @e_atk_move = 0
    
    # 敵攻撃時の移動フレーム数
    @atk_count = 0
    
    # 攻撃アイコンを初期化しておく
    @attack_icons.each{|icon|
      icon.die()
    }
  end
  
  # フレーム更新処理
  def update()
    $player.fever_start()

    if $player.fever? then
      Window.draw(0, 0, @background_fever)
      @sparkly.draw()
      
      if $playing_bgm != "fever" then
        $last_bgm = $playing_bgm
        $playing_bgm = "fever"
        $bgm["battle"].stop(0)
        $bgm["boss_battle"].stop(0)
        $bgm["fever"].play(0, 0)
      end
    else
      Window.draw(0, 0, @background)
      
      if $playing_bgm == "fever" then
        $bgm["fever"].stop(0)
        if @battle_count < 14 then
          $bgm["battle"].play(0, 0)
          $playing_bgm = "battle"
        else
          $bgm["battle"].stop(0)
          $bgm["boss_battle"].play(0, 0)
          $playing_bgm = "boss_battle"
        end
      end
    end
    
    Window.draw_font(0, 0, "fever:" + $player.fever_point.to_s + " / " + Player::FEVER_MAX_POINT.to_s, @text_font)
    
    @p_damage = false          # プレイヤーがダメージを受けたか true, false
    @p_guard = false           # プレイヤーがガードしたか true, false
    @p_guard_rank = "no_guard" # no_guard, perfect, good, poor の 4種の値が入る
    
    if @cut == 1 then
      if $player.fever_frame > 0 then
        $player.fever_frame -= 1
      end

      # キー入力処理
      attack()
      guard()
      heal()
      
      # 攻撃アイコンの描画
      @attack_icons.each{|icon|
        if icon.visible then
          icon.x -= @enemy.attack_speed
          
          Window.draw(icon.x, icon.y, $system_image["attack_icon"])
          
          # ガードせずに攻撃を受けた
          if icon.x < 200 then
            if $player.fever? == false then
              $player.fever_point += 4
            end
            icon.die()
            @p_damage = true
          end
        end
      }
     
      # プレイヤーのダメージ処理
      if @p_damage && @p_guard == false then
        # ガードせずにダメージを受けたので、ダメージ音を再生
        $sounds["p_damage_sound"].play(1, 0)
      end
      
      if @p_damage then
        damage = calc_damage(@enemy.attack, $player.DEF)
        case @p_guard_rank
        when "good"
          damage *= 0.5
        when "poor"
          damage *= 0.8
        end
        $player.hp -= damage.to_i
        
        if $player.hp < 0 then
          $player.hp = 0
        end
      end
      
      # 攻撃フレームが来たら攻撃アイコンを表示
      if @enemy.attack_frame? then
        @atk_count = $frame_counter
        @e_atk_move = 24
        
        # 非表示になっているアイコンがあるか検索
        # ※ なければ攻撃タイミングが来ても攻撃はしない
        @attack_icons.each{|icon|
          if icon.visible == false then
            icon.visible = true
            break
          end
        }
      end
      
      if $frame_counter - @atk_count > 16 then
        @e_atk_move = 0
      end
      
      # ガード評価の表示
      if @p_guard_rank != "no_guard" then
        @guard_rank.set_rank(@p_guard_rank)
      end
      
      # 戦闘終了の判断
      if $player.hp < 1 then
        @battle_result = false
        @cut = 2
        @cut_counter = 0
      end
      
      if @enemy.hp < 1 then
        @battle_result = true
        @cut = 2
        @cut_counter = 0
      end
    end
    
    # はじめて戦闘シーンを表示した時はフェードイン演出を入れる
    if @cut == -1 then
      if @cut_counter == 0 then
        before_battle() # バトル開始前準備
      end
      
      if @cut_counter < 60 then
        Window.draw_alpha(0, 0, @black_box, @alpha, z=1000)
        @alpha -= 4
      end
      
      @cut_counter += 1
      
      if @cut_counter > 60 then
        @cut = 0
        @cut_counter = 0
      end
    end
    
    # 戦闘前の演出
    if @cut == 0 then
      if @cut_counter == 0 then
        if @before_end then
          before_battle() # バトル開始前準備"
        end
        $sounds["encount"].play(1, 0)
      end

      if @cut_counter == 45 then
        $sounds["v_b_start"].play(1, 0)
      end
      
      @cut_counter += 1
      if @cut_counter > 120 then
        if @battle_count < 15 then
          if $playing_bgm != "fever" then
            if $playing_bgm != "battle" then
              $playing_bgm = "battle"
              $bgm["battle"].play(0, 0)
            end
          end
        else
          if $playing_bgm != "fever" then
            if $playing_bgm != "boss_battle" then
              $bgm["battle"].stop(0)
              $playing_bgm = "boss_battle"
              $bgm["boss_battle"].play(0, 0)
            end
          end
        end
        
        $bgm["battle"].set_volume(90, 0)
        $bgm["boss_battle"].set_volume(90, 0)
        @cut = 1
        @cut_counter = 0
      end
      
      # 戦闘前ウィンドウの表示
      Window.draw(267, 187, @start_window, 1000)
    end
    
    # 画像の表示
    draw()
    
    # 戦闘後演出
    if @cut == 2 then
      
      if @go_home then
        if @cut_counter < 60 then
          Window.draw_alpha(0, 0, @black_box, @alpha, z=1000)
          @alpha += 4
        else
          Window.draw_alpha(0, 0, @black_box, 255, z=1000)
          @next_scene = Scene_Home.new
        end
      else
        battle_end()
      end
      
      @cut_counter += 1
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
  
  # ダメージ計算
  def calc_damage(attack, defence)
    damage = (attack.to_f * 4.0 - defence * 2.0).round
    if damage < 1 then
      damage = 1 # 確定で 1 ダメージは与える
    end
    return damage
  end
  
  # 攻撃処理
  def attack()
    if Input.mouse_push?(M_LBUTTON) || Input.pad_push?(P_BUTTON0) then
      if (Input.mouse_x >= @enemy.sx + ENEMY_X &&
         Input.mouse_y >= @enemy.sy + ENEMY_Y + @e_atk_move &&
         Input.mouse_x <= @enemy.ex + ENEMY_X &&
         Input.mouse_y <= @enemy.ey + ENEMY_Y + @e_atk_move) || Input.pad_push?(P_BUTTON0)then
         
        if @attack_effect.visible == false || @attack_effect.frame_count > 15 then
          diff = $frame_counter - @combo_frame
          if diff <= 80 then
            @combo_count += 1
            if $player.fever? == false then
              if @combo_count > 10
                $player.fever_point += 10
              else
                $player.fever_point += @combo_count
              end
            end
          else
            @combo_count = 0
          end
          
          if $player.fever? == false then
            $player.fever_point += 1
          end
          
          $sounds["p_attack"].play(1, 0)
          @attack_effect.show(@combo_count)
          damage = calc_damage($player.ATK, @enemy.defence)
          
          combo_correction_value = (@combo_count.to_f / 100.0) + 1.0
          
          if combo_correction_value > 2.0 then
            combo_correction_value = 2.0
          end
          
          damage = (damage.to_f * combo_correction_value).ceil
          
          @enemy.hp -= damage
          if @enemy.hp < 0 then
            @enemy.hp = 0
          end
          
          @combo_frame = $frame_counter
        else
          @combo_frame = 0
        end

      end
    end
  end
  
  # ガードのキー入力処理
  def guard()
    # シフトキーでガード
    if Input.key_push?(K_LSHIFT) || Input.key_push?(K_RSHIFT) || Input.mouse_push?(M_RBUTTON) || Input.pad_push?(P_BUTTON1) || Input.pad_push?(P_LEFT) then
      # 攻撃アイコンがガードボタン内にあるか？
      @attack_icons.each{|icon|
        if icon.visible == true then
          if icon.x >= 240 && icon.x <= 354 then
            @p_guard = true
            
            # ガード音を再生
            $sounds["p_guard_sound"].play(1, 0)
            
            # ガード評価
            diff = (297 - icon.x).abs
            
            if diff <= 12 then
              @p_guard_rank = "perfect"
              @p_damage = false # ガードがパーフェクトの場合は ダメージを受けない
              if $player.fever? == false then
                $player.fever_point += 4
              end
            elsif diff <= 32 then
              @p_guard_rank = "good"
              @p_damage = true
              if $player.fever? == false then
                $player.fever_point += 4
              end
            else
              @p_guard_rank = "poor"
              @p_damage = true
              if $player.fever? == false then
                $player.fever_point += 4
              end
            end
            
            icon.die() # ガードした場合は 攻撃アイコン を消去
            break
          end
        end
      }
    end
  end
  
  # 回復ボタンのキー入力処理
  def heal()
    if Input.key_push?(K_SPACE) || Input.pad_push?(P_BUTTON2) then
        if $player.heal_count > 0 then
          # HP が減っている場合のみ回復処理
          if $player.hp < $player.max_hp then
            # 回復音を再生
            $sounds["heal"].play(1, 0)
            heal_point = $player.max_hp * 0.25
            $player.hp += heal_point.to_i
            if $player.hp > $player.max_hp
              $player.hp = $player.max_hp
            end
            
            $player.heal_count -= 1
          end
        end
    end
  end
  
  # 画像の描画
  def draw()
      if $player.fever? then
        Window.draw(29, 285, @dance_image[$player.skin_color][@dance_index])
        if $frame_counter % 6 == 0 then
          @dance_index = @dance_index + 1
          @dance_index = 0 if @dance_index >= @dance_image[$player.skin_color].size
        end
      else
        # アバターの描画
        Window.draw(29, 285, $avater[$player.skin_color])
        
        # 防具の描画
        $armordata.draw
      
        # 髪型を描画
        $hair.draw
      end
      
      # プレイヤーHPゲージの表示
      Window.draw(174, 466, $system_image["hp_gauge"])
      draw_player_hp_gauge()
      
      # 敵HPゲージの表示
      Window.draw(174, 0, $system_image["hp_gauge"])
      draw_enemy_hp_gauge()
      
      # 回復ボタンの表示
      Window.draw(740, 461, $system_image["heal_button"])
      
      # 回復ボタンの残り数表示
      Window.draw_font_ex(781, 505, $player.heal_count.to_s, @heal_font, {:color=>[0, 128, 0], :edge=>true, :edge_color=>C_WHITE, :edge_width=>4, :edge_level=>10})
      
      # 敵画像の表示
      if @cut < 2 then
        Window.draw(ENEMY_X, ENEMY_Y + @e_atk_move, @enemy.image)
      end
      
      # コンボ回数の表示
      if @combo_count > 0 then
        Window.draw_font_ex(540, 290, @combo_count.to_s + "HIT", @heal_font, {:color=>[255, 60, 17], :edge=>true, :edge_color=>C_WHITE, :edge_width=>4, :edge_level=>10})
      end
      
      # ガードゲージの表示
      Window.draw(230, 392, $system_image["guard_gauge"])
      
      # ガードランクの表示
      @guard_rank.update()
      
      # 攻撃エフェクトの表示
      @attack_effect.update()
      
      # あと何匹倒せば良いのかを表示
      Message_Box.show("あと" + (15 - @battle_count).to_s + " 回", 0, 34)
  end
  
  # プレイヤーのHPゲージの描画
  def draw_player_hp_gauge()
    if $player.hp < $player.max_hp then
      hp_rate = $player.hp.to_f / $player.max_hp.to_f
      bar_width = (hp_rate * 470).round
    else
      bar_width = 470
    end

    Window.draw_box_fill(251, 482, 251 + bar_width, 508, [255, 0, 0])
  end
  
  # 敵HPゲージの描画
  def draw_enemy_hp_gauge()
    if @enemy.hp < @enemy.max_hp then
      hp_rate = @enemy.hp.to_f / @enemy.max_hp.to_f
      bar_width = (hp_rate * 470).round
    else
      bar_width = 470
    end

    Window.draw_box_fill(251, 16, 251 + bar_width, 42, [255, 0, 0])
  end

  # 戦闘後演出
  def battle_end()
    if @battle_result then
      if @cut_counter < 60 then
        Window.draw(237, 72, @enemy.image, 10)
      end
      
      if @cut_counter == 60 then
        # 撃破音の再生
        $sounds["die"].play(1, 0)
        @enemy.effect_index = 0
        
        exp = @enemy.exp
        gold = @enemy.gold
        
        if $player.fever? then
          exp *= 2
          gold *= 2
        end
        
        @win_window.draw_font(15, 37, exp.to_s + " ポイントの経験値を獲得！", @text_font)
        @win_window.draw_font(15, 63, gold.to_s + " ゴールドを獲得！", @text_font)
        
        $player.exp += exp
        $player.gold += gold
        
        
        
        # この戦闘でプレイヤーはレベルアップしたか？
        if $player.level_up?() then
          @win_window.draw_font(15, 89, "レベルが上がった！", @text_font)
        end
        
        # この戦闘でプレイヤーはアイテムを手に入れたか？
        item_hit = rand(15)
        if $player.fever? then
          item_hit =15
        end
        
        if item_hit > 10 then
          drop_item = rand(2) # 0 なら武器 1 なら防具
          item_name = ""
          case $dungeon_id
          when 1
            if drop_item == 0 then
              idx = rand(5)
              $player.have_weapon[idx][1] += 1
              item_name = $weapondata.get_weapon_data(idx)[:name]
            else
              idx = rand(5)
              $player.have_armor[idx][1] += 1
              item_name = $armordata.get_armor_data(idx)[:name]
            end
          when 2
            if drop_item == 0 then
              idx = rand(5) + 5
              $player.have_weapon[idx][1] += 1
              item_name = $weapondata.get_weapon_data(idx)[:name]
            else
              idx = rand(5) + 5
              $player.have_armor[idx][1] += 1
              item_name = $armordata.get_armor_data(idx)[:name]
            end
          when 3
            if drop_item == 0 then
              idx = rand(5) + 10
              $player.have_weapon[idx][1] += 1
              item_name = $weapondata.get_weapon_data(idx)[:name]
            else
              idx = rand(5) + 10
              $player.have_armor[idx][1] += 1
              item_name = $armordata.get_armor_data(idx)[:name]
            end
          end
          
          @win_window.draw_font(15, 123, item_name + "を手に入れた！", @text_font)
        end
        
        # プレイヤー情報を保存
        save()
      end
      
      if @cut_counter >= 60 && @cut_counter < 120 then
        Window.draw(ENEMY_X, ENEMY_Y, @enemy.die_effects[@enemy.effect_index])
        if @cut_counter % 6 == 0 then
          @enemy.effect_index += 1
          if @enemy.effect_index >= @enemy.die_effects.length then
            @enemy.effect_index = @enemy.die_effects.length - 1
          end
        end
      end
      
      if @cut_counter == 120 then
        $sounds["win"].play(1, 0)
      end
      
      if @cut_counter >= 120 then
        # 勝利ウィンドウの表示
        Window.draw(267, 113, @win_window)
      end
      
      if @cut_counter == 225 then
        # 勝利ボイスの再生
        $sounds["v_win"].play(1, 0)
        @cursor.index = 1
      end
      
      if @cut_counter > 225 then
        # 次の戦闘へボタンの表示
        if @battle_count < 15
          Window.draw(542, 327, @next_battle)
          Window.draw(269, 327, @dungeon_end)
        else
          Window.draw(542, 327, @dungeon_end)
        end
        
        if Input.pad_push?(P_LEFT) && @battle_count < 15 then
          @cursor.index = 0
        end
        
        if Input.pad_push?(P_RIGHT) then
          @cursor.index = 1
        end
        
        @cursor.draw
        
        if Input.mouse_push?(M_LBUTTON) || Input.pad_push?(P_BUTTON0) then
          # 戦闘後、次の戦闘へ行くボタンを押した
          # （ボス戦終了後は街へ戻るボタンに変化）
          if (Input.mouse_x >= 542 &&
             Input.mouse_y >= 327 &&
             Input.mouse_x <= 680 &&
             Input.mouse_y <= 369) || (Input.pad_push?(P_BUTTON0) && @cursor.index == 1) then
             
             if @before_end == false then
               @before_end = true
             end
             
             if @battle_count < 15
               @cut = 0
               @cut_counter = -1
             else
               @go_home = true
               @cut_counter = -1
             end
          end
          
          # 戦闘後、街へ戻るボタンを押した
          if (Input.mouse_x >= 269 &&
             Input.mouse_y >= 327 &&
             Input.mouse_x <= 407 &&
             Input.mouse_y <= 369) || (Input.pad_push?(P_BUTTON0) && @cursor.index == 0) then
             
             @go_home = true
             @cut_counter = -1
          end
        end
        
        # マウスカーソルホバー
        if (Input.mouse_x >= 542 &&
           Input.mouse_y >= 327 &&
           Input.mouse_x <= 680 &&
           Input.mouse_y <= 369) then
          @cursor.index = 1
        end
        
        if (Input.mouse_x >= 269 &&
            Input.mouse_y >= 327 &&
            Input.mouse_x <= 407 &&
            Input.mouse_y <= 369) then
          @cursor.index = 0
        end
      end
    else
      Window.draw(237, 72, @enemy.image, 10)
      
      if @cut_counter == 60 then
        # 敗北音の再生
        $bgm["battle"].stop(0)
        $bgm["boss_battle"].stop(0)
        $playing_bgm = nil
        $sounds["lose"].play(1, 0)
      end
      
      if @cut_counter >= 60 then
        # 戦闘前ウィンドウの表示
        Window.draw(267, 187, @lose_window, 20)
      end
      
      if @cut_counter == 204 then
        $sounds["v_lose"].play(1, 0)
      end
      
      if @cut_counter >= 360 then
        @go_home = true
        @cut_counter = -1
      end
    end
  end
  
end