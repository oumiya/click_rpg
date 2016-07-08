require 'dxruby'
require_relative 'Scene_Home.rb'
require_relative 'Message_Box.rb'

# ゲーム中の全てのシーンのスーパークラス
class Scene_Key_Config
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
    @state = 0 # 0 決定/攻撃ボタン 1 売却/ガードボタン 2 回復ボタン 3 確認
    @next_scene = nil
    $attack_button = nil
    $guard_button = nil
    $heal_button = nil
    @wait_frame = 0
  end
  
  # フレーム更新処理
  def update()
    # 画面の描画
    if @state == 0 then
      Message_Box.show("決定/攻撃ボタンを押してください<br>（キャンセルする場合はキーボードのSPACEキーを押してください）")
    end
    
    if @state == 1 then
      Message_Box.show("ガード/売却ボタンを押してください<br>（キャンセルする場合はキーボードのSPACEキーを押してください）")
    end
    
    if @state == 2 then
      Message_Box.show("薬草（回復）ボタンを押してください<br>（キャンセルする場合はキーボードのSPACEキーを押してください）")
    end
    
    if @state == 3 then
      Message_Box.show("ボタンの設定が終わりました")
    end
    
    if @state == 4 then
      Message_Box.show("ボタンの設定をキャンセルしました。")
    end
    
    # ウェイト処理
    return if wait?
    
    if @state >= 3 then
      @next_scene = Scene_Home.new
    end
    
    # キー入力待ち
    if @state == 0 then
      $attack_button = P_BUTTON0 if Input.pad_push?(P_BUTTON0)
      $attack_button = P_BUTTON1 if Input.pad_push?(P_BUTTON1)
      $attack_button = P_BUTTON2 if Input.pad_push?(P_BUTTON2)
      $attack_button = P_BUTTON3 if Input.pad_push?(P_BUTTON3)
      $attack_button = P_BUTTON4 if Input.pad_push?(P_BUTTON4)
      $attack_button = P_BUTTON5 if Input.pad_push?(P_BUTTON5)
      $attack_button = P_BUTTON6 if Input.pad_push?(P_BUTTON6)
      $attack_button = P_BUTTON7 if Input.pad_push?(P_BUTTON7)
      $attack_button = P_BUTTON8 if Input.pad_push?(P_BUTTON8)
      $attack_button = P_BUTTON9 if Input.pad_push?(P_BUTTON9)
      $attack_button = P_BUTTON10 if Input.pad_push?(P_BUTTON10)
      $attack_button = P_BUTTON11 if Input.pad_push?(P_BUTTON11)
      $attack_button = P_BUTTON12 if Input.pad_push?(P_BUTTON12)
      $attack_button = P_BUTTON13 if Input.pad_push?(P_BUTTON13)
      $attack_button = P_BUTTON14 if Input.pad_push?(P_BUTTON14)
      $attack_button = P_BUTTON15 if Input.pad_push?(P_BUTTON15)
    end
    
    if @state == 1 then
      $guard_button = P_BUTTON0 if Input.pad_push?(P_BUTTON0)
      $guard_button = P_BUTTON1 if Input.pad_push?(P_BUTTON1)
      $guard_button = P_BUTTON2 if Input.pad_push?(P_BUTTON2)
      $guard_button = P_BUTTON3 if Input.pad_push?(P_BUTTON3)
      $guard_button = P_BUTTON4 if Input.pad_push?(P_BUTTON4)
      $guard_button = P_BUTTON5 if Input.pad_push?(P_BUTTON5)
      $guard_button = P_BUTTON6 if Input.pad_push?(P_BUTTON6)
      $guard_button = P_BUTTON7 if Input.pad_push?(P_BUTTON7)
      $guard_button = P_BUTTON8 if Input.pad_push?(P_BUTTON8)
      $guard_button = P_BUTTON9 if Input.pad_push?(P_BUTTON9)
      $guard_button = P_BUTTON10 if Input.pad_push?(P_BUTTON10)
      $guard_button = P_BUTTON11 if Input.pad_push?(P_BUTTON11)
      $guard_button = P_BUTTON12 if Input.pad_push?(P_BUTTON12)
      $guard_button = P_BUTTON13 if Input.pad_push?(P_BUTTON13)
      $guard_button = P_BUTTON14 if Input.pad_push?(P_BUTTON14)
      $guard_button = P_BUTTON15 if Input.pad_push?(P_BUTTON15)
    end
    
    if @state == 2 then
      $heal_button = P_BUTTON0 if Input.pad_push?(P_BUTTON0)
      $heal_button = P_BUTTON1 if Input.pad_push?(P_BUTTON1)
      $heal_button = P_BUTTON2 if Input.pad_push?(P_BUTTON2)
      $heal_button = P_BUTTON3 if Input.pad_push?(P_BUTTON3)
      $heal_button = P_BUTTON4 if Input.pad_push?(P_BUTTON4)
      $heal_button = P_BUTTON5 if Input.pad_push?(P_BUTTON5)
      $heal_button = P_BUTTON6 if Input.pad_push?(P_BUTTON6)
      $heal_button = P_BUTTON7 if Input.pad_push?(P_BUTTON7)
      $heal_button = P_BUTTON8 if Input.pad_push?(P_BUTTON8)
      $heal_button = P_BUTTON9 if Input.pad_push?(P_BUTTON9)
      $heal_button = P_BUTTON10 if Input.pad_push?(P_BUTTON10)
      $heal_button = P_BUTTON11 if Input.pad_push?(P_BUTTON11)
      $heal_button = P_BUTTON12 if Input.pad_push?(P_BUTTON12)
      $heal_button = P_BUTTON13 if Input.pad_push?(P_BUTTON13)
      $heal_button = P_BUTTON14 if Input.pad_push?(P_BUTTON14)
      $heal_button = P_BUTTON15 if Input.pad_push?(P_BUTTON15)
    end
    
    if @state == 0 && $attack_button != nil then
      @state = 1
      @wait_frame = 30
    end
    
    if @state == 1 && $guard_button != nil then
      @state = 2
      @wait_frame = 30
    end
    
    if @state == 2 && $heal_button != nil then
      @state = 3
      
      File.open("config.ini", "w"){|f|
        f.print("attack_button:" + $attack_button.to_s + "\n")
        f.print("guard_button:" + $guard_button.to_s + "\n")
        f.print("heal_button:" + $heal_button.to_s + "\n")
      }
      
      @wait_frame = 60
    end
    
    if Input.key_push?(K_SPACE) then
      @state = 4
      @wait_frame = 60
    end
    
  end
  
  # ループ後処理
  def terminate()
    if $attack_button == nil then
      $attack_button = P_BUTTON0
    end
    if $guard_button == nil then
      $guard_button = P_BUTTON1
    end
    if $heal_button == nil then
      $heal_button = P_BUTTON1
    end
  end
  
  # 次のシーンに遷移
  # 遷移しない場合は nil を返す
  def get_next_scene()
    return @next_scene
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
