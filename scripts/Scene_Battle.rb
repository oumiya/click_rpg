require 'dxruby'
require_relative 'Attack_Effect.rb'
require_relative 'Attack_Icon.rb'
require_relative 'Fade_Effect.rb'
require_relative 'Guard_Rank_Text.rb'
require_relative 'Message_Box.rb'
require_relative 'Scene_Box.rb'
require_relative 'Scene_Ending.rb'
require_relative 'Scene_Event.rb'
require_relative 'Scene_Home.rb'
require_relative 'Sparkly.rb'
require_relative 'Wave_Result.rb'
require_relative 'Scene_Tower.rb'
require_relative 'Effect.rb'

class Guard_Frame_Effect < Effect
  attr_accessor :scale
  
  def initialize()
    super()
    @counter = 30
    @scale = 2.0
    @alpha = 0
    @images = Array.new
    @images.push(Image.load("image/system/guard_frame.png"))
  end
  
  def draw()
    if visible then
      Window.draw_ex(@x, @y, @images[0], {:scale_x=>@scale, :scale_y=>@scale, :alpha=>@alpha})
    end
  end
  
  def show()
    @visible = true
    @counter = 0
    @scale = 1.0
  end
  
  def update()
    if @visible then
      if $frame_counter % 2 == 0 then
        # 徐々に拡大する
        @scale += 0.1
        @alpha += 13
        if @scale >= 2.0 then
          @scale = 1.0
          @visible = false
        end
      end
    end
  end
  
end

class Scene_Battle

  ENEMY_X = 237         # 敵画像の表示原点 X座標
  ENEMY_Y = 72          # 敵画像の表示原点 Y座標
  BATTLE_COUNT_MAX = 8  # 1ウェーブで戦う戦闘回数

  def initialize()
    super
    @next_scene = nil
    @message = ""
    @e_atk_move = 0
    @combo_frame = 0
    @combo_count = 0
    @combo_option = {:color=>[255, 60, 17], :edge=>true, :edge_color=>C_WHITE, :edge_width=>4, :edge_level=>10}
    @atk_count = 0
    @prev_mouse_pos = [Input.mouse_x, Input.mouse_y]
    @wait_frame = 0
    @result = Wave_Result.new
    @heal_wait = 0
    @elements = Array.new
    @help = Array.new
    @effective = false
    
    # プレイヤーが敵に何回攻撃したかカウントする変数
    @p_atk_count = 0
    # プレイヤーが何回ガードしかたカウントする変数
    @p_gd_count = 0
    # プレイヤーが何回薬草を使ったかカウントする変数
    @p_heal_count = 0
    
    # プレイヤーが現在装備しているスキル
    if $player.equip_weapon >= 0 then
      @equip_skill = $active_skills.get_active_skill($player.have_weapon[$player.equip_weapon]["skill"])
    end
    
    # プレイヤーの防御範囲拡大フラグ
    @guard_range = false
  end
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
    # フェードイン/フェードアウトの演出用クラス
    @fade_effect = Fade_Effect.new
    @fade_effect.setup(1) # 画面表示時はフェードインで表示
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
    when 7
      @background = Image.load("image/background/tower.jpg")
    end
    # 属性画像の読込
    @elements.push(Image.load("image/system/e_fire.png"))
    @elements.push(Image.load("image/system/e_ice.png"))
    @elements.push(Image.load("image/system/e_earth.png"))
    @elements.push(Image.load("image/system/e_wind.png"))
    @elements.push(Image.load("image/system/e_light.png"))
    @elements.push(Image.load("image/system/e_dark.png"))
    # ヒント画像の読込
    @help.push(Image.load("image/help/00_note_attack.png"))
    @help.push(Image.load("image/help/01_note_guard.png"))
    @help.push(Image.load("image/help/02_note_heal.png"))
    @help.push(Image.load("image/help/03_note_fever.png"))
    # 回復エフェクトの読込
    @heal_effect = Effect.new
    @heal_effect.x = 0
    @heal_effect.y = 290
    @heal_effect.images = Image.load_tiles("image/effect/heal.png", 9, 1)
    # スペシャルアタックエフェクトの読込
    @sp_effect = Effect.new
    @sp_effect.x = 300
    @sp_effect.y = 80
    @sp_effect.images = Image.load_tiles("image/effect/sp_attack.png", 1, 10)
    # ガード強化枠画像の読込
    @guard_frame_effect = Guard_Frame_Effect.new
    @guard_frame_effect.x = 285
    @guard_frame_effect.y = 386
    @guard_frame = Image.load("image/system/guard_frame.png")
    
    # 敵データの読込
    @enemies = Array.new
    if $dungeon_id == 7 then
      e_idx = $wave_id + 41
      @enemies.push($enemydata.get_enemy(e_idx))
      @enemy_idx = 0
    else
      s = ($dungeon_id - 1) * 7
      e = $dungeon_id * 7
      for idx in s..e-1 do
        @enemies.push($enemydata.get_enemy(idx))
      end
      @enemy_idx = -1
    end
    
    # 攻撃エフェクトを初期化
    @attack_effect = Attack_Effect.new
    # ガードゲージ画像の読込
    @guard_gauge = Image.load("image/system/guard_gauge.png")
    # 攻撃アイコン画像の読込
    @attack_icon = Image.load("image/system/attack_icon.png")
    @attack_icons = Array.new(10){|idx| Attack_Icon.new }
    # ガード評価を初期化
    @guard_rank = Guard_Rank_Text.new
    # HPゲージ画像の読込
    @hp_gauge = Image.load("image/system/hp_gauge.png")
    # 薬草ボタン画像の読込
    @heal_button = Image.load("image/system/heal_button.png")
    @heal_font = Font.new(32, "ＭＳ Ｐゴシック", {"weight" => true})
    @heal_option = {:color=>[0, 128, 0], :edge=>true, :edge_color=>C_WHITE, :edge_width=>4, :edge_level=>10}
    # フィーバー関係の画像の読込
    @fever_text = Image.load("image/system/fever.png")
    @fever_anime = Image.load_tiles("image/system/fever_tile.png", 6, 6)
    @background_fever = Image.load("image/background/fever.png")
    @fever_gauge_frame = Image.load("image/system/fever_gauge.png")
    @sparkly = Sparkly.new
    # ダンシングアバター画像の読込
    filename = "image/avater/dance0" + ($player.skin_color + 1).to_s + ".png"
    @dance_image = Image.load_tiles(filename, 9, 1)
    @dance_index = 0
    
    # 戦闘回数
    @battle_count = 0
    
    # 画面状態
    # 0 が待機状態 1 敵が出現 2 戦闘中 3 敗北 4 敵消滅中 5 勝利
    @state = 0
    # その状態になってから何フレーム経過したかのカウント
    @state_count = 0
  end
  
  # フレーム更新処理
  def update()
    #エフェクトの更新
    @heal_effect.update
    @sp_effect.update
    @guard_frame_effect.update
    
    if @equip_skill then
      if @equip_skill.id == 1 && @equip_skill.skill_continued?() == false then
        @guard_range = false
      end
    end

    # フェードアウト/フェードインの表示
    @fade_effect.update
    if @fade_effect.effect_end? == false then
      return
    end
    
    # ウェイト処理
    return if wait?
    
    # キー入力処理
    input()
    
    # 画面状態の遷移処理
    state_change()
  end
  
  # ループ後処理
  def terminate()
    # BGMの停止
    $bgm["battle"].stop(0)
    $bgm["boss_battle"].stop(0)
    $bgm["last_battle"].stop(0)
  end
  
  # 次のシーンに遷移
  # 遷移しない場合は nil を返す
  def get_next_scene()
    return @next_scene
  end
  
  # 画面状態の遷移処理
  def state_change()
    @state_count += 1
    if @state == 0 then
      @combo_count = 0
      # 待機状態
      @battle_count += 1
      # 出現する敵の決定
      if $dungeon_id == 7 then
        @enemy_idx = 0
        $bgm["battle"].stop(0)
        $bgm["tower_battle"].play(0, 0)
      else
        if @battle_count >= BATTLE_COUNT_MAX && $wave_id == 5 then
          @enemy_idx = 6
          $bgm["battle"].stop(0)
          if @enemies[@enemy_idx].id == 41 then
            $bgm["last_battle"].play(0, 0)
          else
            $bgm["boss_battle"].play(0, 0)
          end
        else
          @enemy_idx = rand(6)
          if $bgm["fever"].playing? == false then
            if $bgm["battle"].playing? == false then
              $bgm["battle"].play(0, 0)
            end
          end
        end
      end
      
      # 出現する敵の全回復
      @enemies[@enemy_idx].hp = @enemies[@enemy_idx].max_hp
      # 画面状態を敵が出現に変更
      @state = 1
      @state_count = 0
    elsif @state == 1 then
      # 敵が出現中
      if @state_count == 1 then
        # エンカウント音を再生
        $sounds["encount"].play(1, 0)
      end
      if @state_count < 45 then
        # 45フレームの間、メッセージを表示
        @message = @enemies[@enemy_idx].name + "があらわれた！"
      end
      if @state_count >= 45 then
        # 画面状態を戦闘中に遷移する
        @state = 2
        @state_count = 0
      end
    elsif @state == 2 then
      # 戦闘中
      if $player.fever? then
        $player.fever_point -= 1
        $player.fever_frame -= 1
        if $player.fever_frame <= 0 then
          $player.fever_frame = 0
          $player.fever_point = 0
        end
      end
      # プレイヤーか敵のHPが 0 以下になったら画面状態を遷移
      if $player.hp <= 0 then
        @state = 3
        @state_count = 0
      elsif @enemies[@enemy_idx].hp <= 0 then
        @state = 4
        @state_count = 0
      end
    elsif @state == 3 then
      # 敗北
      # 敗北音を再生
      if @state_count == 60 then
        $bgm["battle"].stop(0)
        $bgm["boss_battle"].stop(0)
        $bgm["last_battle"].stop(0)
        $bgm["tower_battle"].stop(0)
        $bgm["fever"].stop(0)
        $sounds["lose"].play(1, 0)
      end
      
      if @state_count == 240 then
        if $dungeon_id == 7 then
          @next_scene = Scene_Tower.new
        else
          @result.result = false
          @next_scene = Scene_Box.new(@result)
        end
      end
    elsif @state == 4 then
      if @state_count == 1 then
        @attack_icons.each{|icon|
          icon.die()
        }
        @result.battle_count += 1
        if $player.fever? then
          @result.exp += @enemies[@enemy_idx].exp * 2
          @result.gold += @enemies[@enemy_idx].gold * 2
        else
          @result.exp += @enemies[@enemy_idx].exp
          @result.gold += @enemies[@enemy_idx].gold
        end
      end
      # 勝利中
      if @state_count == 60 then
        # 敵の撃破音を再生
        $sounds["die"].play(1, 0)
        @enemies[@enemy_idx].effect_index = 0
      end
      
      if @state_count >= 61 && @state_count <= 70 then
        @enemies[@enemy_idx].effect_index += 1
        if @enemies[@enemy_idx].effect_index >= @enemies[@enemy_idx].die_effects.size then
          # 敵エフェクトの再生が終わったので画面状態を遷移
          @enemies[@enemy_idx].effect_index = 0
        end
      end
      
      if @state_count > 113 then
        @state = 5
        @state_count = 0
        # HP自動回復処理
        if $player.equip_armor >= 0 then
          heal_point = $player.max_hp / 10
          heal_point *= $player.have_armor[$player.equip_armor]["heal"]
          $player.hp += heal_point
          if $player.hp >= $player.max_hp then
            $player.hp = $player.max_hp
          end
        end
      end
    elsif @state == 5 then
      # 勝利
      if @state_count == 1 then
        # 勝利音を再生
        $sounds["win"].play(1, 0)
      end
      
      if @state_count < 105 then
        @message = @enemies[@enemy_idx].name + "を倒した！"
      elsif @battle_count >= BATTLE_COUNT_MAX then
        # 結果表示画面に遷移
        # 進行度の計算
        progress = ($dungeon_id - 1) * 5
        progress += ($wave_id)

        if $player.progress < progress then
          $player.progress = progress
        end
        
        if @enemies[@enemy_idx].id == 41 && $player.cleared == false then
          @next_scene = Scene_Ending.new
        else
          @result.result = true
          @next_scene = Scene_Box.new(@result)
        end
      else
        if $dungeon_id == 7 then
          if $wave_id == 1 then
            progress = 31
          end
          if $wave_id == 2 then
            progress = 32
          end
          if $wave_id == 3 then
            progress = 33
          end
          if $wave_id == 4 then
            progress = 34
          end
          if $wave_id == 5 then
            progress = 35
          end
          if $wave_id == 6 then
            progress = 36
          end
          if $wave_id == 7 then
            progress = 37
          end
          if $wave_id == 8 then
            progress = 38
          end
          
          if $player.progress < progress then
            $player.progress = progress
          end
          
          if $wave_id != 8 then
            @next_scene = Scene_Tower.new
          else
            @next_scene = Scene_Event.new("salmon3.dat")
          end
          
        else
          # 続けて戦闘を続行
          @state = 0
        end
      end
    end
  end
  
  def draw()
    # 背景画像の描画
    if $player.fever? then
      Window.draw(0,0, @background_fever)
      @sparkly.draw()
    else
      Window.draw(0, 0, @background)
    end
    # 敵画像の描画
    if @state >= 1 && @state <= 3 then
      Window.draw(ENEMY_X, ENEMY_Y, @enemies[@enemy_idx].image)
    elsif @state == 4 then
      # 死亡中
      if @state_count < 60 then
        Window.draw(ENEMY_X, ENEMY_Y, @enemies[@enemy_idx].image)
      elsif @enemies[@enemy_idx].effect_index < @enemies[@enemy_idx].die_effects.size && @state_count < 70 then
        Window.draw(ENEMY_X, ENEMY_Y, @enemies[@enemy_idx].die_effects[@enemies[@enemy_idx].effect_index])
      end
    end
    # 敵属性の表示
    if @enemies[@enemy_idx].element == "火" then
      Window.draw(181, 58, @elements[0])
    elsif @enemies[@enemy_idx].element == "氷" then
      Window.draw(181, 58, @elements[1])
    elsif @enemies[@enemy_idx].element == "土" then
      Window.draw(181, 58, @elements[2])
    elsif @enemies[@enemy_idx].element == "風" then
      Window.draw(181, 58, @elements[3])
    elsif @enemies[@enemy_idx].element == "光" then
      Window.draw(181, 58, @elements[4])
    elsif @enemies[@enemy_idx].element == "闇" then
      Window.draw(181, 58, @elements[5])
    end
    
    # コンボ回数の表示
    if @state == 2 && @combo_count > 0 then
      Window.draw_font_ex(540, 290, (@combo_count + 1).to_s + "HIT", @heal_font, @combo_option)
    end
    # 攻撃エフェクトの描画
    @attack_effect.update(@effective)
    # ガードゲージの描画
    Window.draw(230, 392, @guard_gauge)
    # 攻撃アイコンの描画
    @attack_icons.each{|icon|
      if icon.visible then
        Window.draw(icon.x, icon.y, @attack_icon)
      end
    }
    # ガード評価の描画
    @guard_rank.update()
    # 敵HPゲージの描画
    Window.draw(174, 0, @hp_gauge)
    draw_enemy_hp_gauge()
    # プレイヤーHPゲージの描画
    Window.draw(174, 466, @hp_gauge)
    draw_player_hp_gauge()
    # 薬草ボタンの描画
    Window.draw(740, 461, @heal_button)
    # 薬草の残り数の描画
    Window.draw_font_ex(781, 505, $player.heal_count.to_s, @heal_font, @heal_option)
    # フィーバーロゴの描画
    if $player.fever? then
      idx = $frame_counter % 36
      Window.draw(758, 11, @fever_anime[idx])
    else
      Window.draw(758, 11, @fever_text)
    end
    # フィーバーゲージの描画
    fever_rate = $player.fever_point.to_f / Player::FEVER_MAX_POINT.to_f
    fever_gauge = 434 * fever_rate
    y = 510 - fever_gauge.ceil
    Window.draw_box_fill(824, y, 855, y + fever_gauge.ceil, [255, 202, 20])
    Window.draw(816, 69, @fever_gauge_frame)
    # アバター画像の描画
    if $player.fever? then
      # ダンシングアバターの描画
      Window.draw(29, 285, @dance_image[@dance_index])
      if $frame_counter % 4 == 0 then
        @dance_index += 1
      end
      if @dance_index >= @dance_image.size then
        @dance_index = 0
      end
    else
      # アバター本体の描画
      Window.draw(29, 285, $avater[$player.skin_color])
      # アバター防具の描画
      $armordata.draw
      # アバター髪型の描画
      $hair.draw
      # アバター武器の描画
      $weapondata.draw
    end
    # 戦闘の残り回数の描画
    if $dungeon_id == 7 then
      Message_Box.show("最終戦", 0, 0)
    else
      if BATTLE_COUNT_MAX - @battle_count <= 0 then
        Message_Box.show("最終戦", 0, 0)
      else
        Message_Box.show("あと" + (BATTLE_COUNT_MAX - @battle_count).to_s + "戦", 0, 0)
      end
    end
    
    # スキルの表示
    if @equip_skill then
      @equip_skill.draw
    end
    
    # エフェクトの表示
    @heal_effect.draw
    @sp_effect.draw
    @guard_frame_effect.draw
    if @guard_range then
      Window.draw(285, 386, @guard_frame)
    end
    
    # ヘルプの表示
    # 攻撃ヘルプの表示
    if @p_atk_count < 3 && $player.flag[3] == false then
      Window.draw(542, 63, @help[0])
    else
      $player.flag[3] = true
    end
    # ガードヘルプの表示
    if @p_gd_count < 3 && $player.flag[4] == false then
      Window.draw(145, 242, @help[1])
    else
      $player.flag[4] = true
    end
    # 回復ヘルプの表示
    if @p_heal_count < 3 && $player.flag[5] == false then
      Window.draw(722, 353, @help[2])
    else
      $player.flag[5] = true
    end
    # フィーバーヘルプの表示
    if $player.fever? && $player.fever_count <= 2 then
      Window.draw(5, 127, @help[3])
    end
    
    # メッセージボックスの表示
    if @message != "" then
      Message_Box.show(@message)
      if @wait_frame < 1 then
        @message = ""
      end
    end
  end
  
  # 敵HPゲージの描画
  def draw_enemy_hp_gauge()
    if @enemies[@enemy_idx].hp < @enemies[@enemy_idx].max_hp then
      hp_rate = @enemies[@enemy_idx].hp.to_f / @enemies[@enemy_idx].max_hp.to_f
      bar_width = (hp_rate * 470).round
    else
      bar_width = 470
    end
    Window.draw_box_fill(251, 16, 251 + bar_width, 42, [255, 0, 0])
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
  
  # キー入力処理
  def input()
    # コントロールモードのチェンジ
    control_mode_change()
    
    # 戦闘中のキー入力
    if @state == 2 then
      attack()
      guard()
      heal()
      skill()
      $player.fever_start()
      if $player.fever? then
        if $bgm["fever"].playing? == false then
          $bgm["last_battle"].stop(0)
          $bgm["boss_battle"].stop(0)
          $bgm["battle"].stop(0)
          $bgm["fever"].play(0, 0)
        end
      else
        if $bgm["fever"].playing? == true then
          $bgm["fever"].stop(0)
          if @battle_count >= BATTLE_COUNT_MAX && $wave_id == 5 then
            if @enemies[@enemy_idx].id == 41 then
              $bgm["last_battle"].play(0, 0)
            else
              $bgm["boss_battle"].play(0, 0)
            end
          else
            if $bgm["battle"].playing? == false then
              $bgm["battle"].play(0, 0)
            end
          end
        end
      end
      
      # プレイヤーが攻撃を受けた時のダメージ処理
      @attack_icons.each{|icon|
        if icon.visible then
          icon.x -= @enemies[@enemy_idx].attack_speed
          
          # ガードせずに攻撃を受けた
          if icon.x < 200 then
            if $player.fever? == false then
              $player.fever_point += 4
            end
            icon.die()
            
            $sounds["p_damage_sound"].play(1,0)
            damage = calc_damage(@enemies[@enemy_idx].attack, $player.DEF)

            if $player.equip_armor >= 0 then
              # ダメージ属性補正
              if $player.have_armor[$player.equip_armor]["element"] == "火" && @enemies[@enemy_idx].element == "火" then
                damage /= 2
              end
              
              if $player.have_armor[$player.equip_armor]["element"] == "氷" && @enemies[@enemy_idx].element == "氷" then
                damage /= 2
              end
              
              if $player.have_armor[$player.equip_armor]["element"] == "土" && @enemies[@enemy_idx].element == "土" then
                damage /= 2
              end
              
              if $player.have_armor[$player.equip_armor]["element"] == "風" && @enemies[@enemy_idx].element == "風" then
                damage /= 2
              end
              
              if $player.have_armor[$player.equip_armor]["element"] == "光" && @enemies[@enemy_idx].element == "光" then
                damage /= 2
              end
              
              if $player.have_armor[$player.equip_armor]["element"] == "闇" && @enemies[@enemy_idx].element == "闇" then
                damage /= 2
              end
            end
            
            $player.hp -= damage
            
            if $player.hp < 0 then
              $player.hp = 0
            end
          end
        end
      }
      # 敵の攻撃処理
      if @enemies[@enemy_idx].attack_frame? then
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
    end
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
  
  # ダメージ計算
  def calc_damage(attack, defence)
    damage = (attack.to_f / 2.0 - defence / 4.0).round
    if damage < 1 then
      damage = 1 # 確定で 1 ダメージは与える
    end
    return damage
  end
  
  # 攻撃処理
  def attack()
    if Input.mouse_push?(M_LBUTTON) || Input.pad_push?($attack_button) then
      if (Input.mouse_x >= @enemies[@enemy_idx].sx + ENEMY_X &&
         Input.mouse_y >= @enemies[@enemy_idx].sy + ENEMY_Y + @e_atk_move &&
         Input.mouse_x <= @enemies[@enemy_idx].ex + ENEMY_X &&
         Input.mouse_y <= @enemies[@enemy_idx].ey + ENEMY_Y + @e_atk_move) || Input.pad_push?($attack_button)then
         
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
          
          @attack_effect.show(@combo_count)
          damage = calc_damage($player.ATK, @enemies[@enemy_idx].defence)
          
          combo_correction_value = (@combo_count.to_f / 100.0) + 1.0
          
          if combo_correction_value > 2.0 then
            combo_correction_value = 2.0
          end
          
          damage = (damage.to_f * combo_correction_value).ceil
          
          # ダメージ属性補正
          @effective = false
          if $player.equip_weapon >= 0 then
            if $player.have_weapon[$player.equip_weapon]["element"] == "火" && @enemies[@enemy_idx].element == "氷" then
              @effective = true
              damage *= 2
            end
            
            if $player.have_weapon[$player.equip_weapon]["element"] == "氷" && @enemies[@enemy_idx].element == "火" then
              @effective = true
              damage *= 2
            end
            
            if $player.have_weapon[$player.equip_weapon]["element"] == "土" && @enemies[@enemy_idx].element == "風" then
              @effective = true
              damage *= 2
            end
            
            if $player.have_weapon[$player.equip_weapon]["element"] == "風" && @enemies[@enemy_idx].element == "土" then
              @effective = true
              damage *= 2
            end
            
            if $player.have_weapon[$player.equip_weapon]["element"] == "光" && @enemies[@enemy_idx].element == "闇" then
              @effective = true
              damage *= 2
            end
            
            if $player.have_weapon[$player.equip_weapon]["element"] == "闇" && @enemies[@enemy_idx].element == "光" then
              @effective = true
              damage *= 2
            end
          end
          
          @enemies[@enemy_idx].hp -= damage
          if @enemies[@enemy_idx].hp < 0 then
            @enemies[@enemy_idx].hp = 0
          end
          
          if @effective == true then
            $sounds["effective"].play(1, 0)
          else
            $sounds["p_attack"].play(1, 0)
          end
          
          @combo_frame = $frame_counter
          
          # 攻撃回数をカウント
          @p_atk_count += 1
        else
          @combo_frame = 0
        end

      end
    end
  end
  
  # ガードのキー入力処理
  def guard()
    # シフトキーでガード
    if Input.key_push?(K_LSHIFT) || Input.key_push?(K_RSHIFT) || Input.mouse_push?(M_RBUTTON) || Input.pad_push?($guard_button) || Input.pad_push?(P_LEFT) then
      # 攻撃アイコンがガードボタン内にあるか？
      @attack_icons.each{|icon|
        if icon.visible == true then
          if icon.x >= 240 && icon.x <= 354 then
            # ガード音を再生
            $sounds["p_guard_sound"].play(1, 0)
            
            damage = calc_damage(@enemies[@enemy_idx].attack, $player.DEF)
            
            # ガード評価
            diff = (297 - icon.x).abs
            rank = 0
            
            if diff <= 12 then
              rank = 1
            elsif diff <= 32 then
              rank = 2
            else
              rank = 3
            end
            
            if @guard_range then
              if rank > 1 then
                rank -= 1
              end
            end
            
            if rank == 1 then
              @guard_rank.set_rank("perfect")
              @p_damage = false # ガードがパーフェクトの場合は ダメージを受けない
              if $player.fever? == false then
                $player.fever_point += 4
              end
              damage = 0
            elsif rank == 2 then
              @guard_rank.set_rank("good")
              @p_damage = true
              if $player.fever? == false then
                $player.fever_point += 4
              end
              damage *= 0.5
            elsif rank == 3 then
              @guard_rank.set_rank("poor")
              @p_damage = true
              if $player.fever? == false then
                $player.fever_point += 4
              end
              damage *= 0.7
            end
            
            # ダメージ属性補正
            if $player.equip_armor >= 0 then
              if $player.have_armor[$player.equip_armor]["element"] == "火" && @enemies[@enemy_idx].element == "火" then
                damage /= 2
              end
              
              if $player.have_armor[$player.equip_armor]["element"] == "氷" && @enemies[@enemy_idx].element == "氷" then
                damage /= 2
              end
              
              if $player.have_armor[$player.equip_armor]["element"] == "土" && @enemies[@enemy_idx].element == "土" then
                damage /= 2
              end
              
              if $player.have_armor[$player.equip_armor]["element"] == "風" && @enemies[@enemy_idx].element == "風" then
                damage /= 2
              end
              
              if $player.have_armor[$player.equip_armor]["element"] == "光" && @enemies[@enemy_idx].element == "光" then
                damage /= 2
              end
              
              if $player.have_armor[$player.equip_armor]["element"] == "闇" && @enemies[@enemy_idx].element == "闇" then
                damage /= 2
              end
            end
            
            $player.hp -= damage
            
            if $player.hp < 0 then
              $player.hp = 0
            end
            
            icon.die() # ガードした場合は 攻撃アイコン を消去
            
            # ガード回数をカウント
            @p_gd_count += 1
            
            break
          end
        end
      }
    end
  end
  
  # 回復ボタンのキー入力処理
  def heal()
    if Input.key_push?(K_SPACE) || Input.pad_push?($heal_button) then
        if $player.heal_count > 0 then
          # HP が減っている場合のみ回復処理
          if $player.hp < $player.max_hp then
            # 回復音を再生
            $sounds["heal"].play(1, 0)
            @heal_effect.show
            heal_point = $player.max_hp * 0.25
            $player.hp += heal_point.to_i
            if $player.hp > $player.max_hp
              $player.hp = $player.max_hp
            end
            
            $player.heal_count -= 1
            @p_heal_count += 1
          end
        end
    end
  end
  
  # スキルキー入力処理
  def skill()
    if @equip_skill then
      @equip_skill.update
      
      # 持続スキルの場合、持続判定をする
      
      if Input.key_push?(K_S) then
        if @equip_skill.use_skill?() then
          @equip_skill.use()
          
          # HP回復スキル
          if @equip_skill.id == 0 then
            # 回復音を再生
            $sounds["heal"].play(1, 0)
            $player.hp = $player.max_hp
            @heal_effect.show
          end
          
          # 防御範囲拡大スキル
          if @equip_skill.id == 1 then
            @guard_range = true
            @guard_frame_effect.show
          end
          
          # 2倍攻撃
          if @equip_skill.id == 2 then
            # 効果音を再生
            $sounds["sp_attack"].play(1, 0)
            @sp_effect.show
            @super_attack = true
            damage = calc_damage($player.ATK, @enemies[@enemy_idx].defence)
            damage *= 2
            
            # ダメージ属性補正
            @effective = false
            if $player.equip_weapon >= 0 then
              if $player.have_weapon[$player.equip_weapon]["element"] == "火" && @enemies[@enemy_idx].element == "氷" then
                @effective = true
                damage *= 2
              end
              
              if $player.have_weapon[$player.equip_weapon]["element"] == "氷" && @enemies[@enemy_idx].element == "火" then
                @effective = true
                damage *= 2
              end
              
              if $player.have_weapon[$player.equip_weapon]["element"] == "土" && @enemies[@enemy_idx].element == "風" then
                @effective = true
                damage *= 2
              end
              
              if $player.have_weapon[$player.equip_weapon]["element"] == "風" && @enemies[@enemy_idx].element == "土" then
                @effective = true
                damage *= 2
              end
              
              if $player.have_weapon[$player.equip_weapon]["element"] == "光" && @enemies[@enemy_idx].element == "闇" then
                @effective = true
                damage *= 2
              end
              
              if $player.have_weapon[$player.equip_weapon]["element"] == "闇" && @enemies[@enemy_idx].element == "光" then
                @effective = true
                damage *= 2
              end
            end
            
            @enemies[@enemy_idx].hp -= damage
            if @enemies[@enemy_idx].hp < 0 then
              @enemies[@enemy_idx].hp = 0
            end
          end
          
          
          
          
        end
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