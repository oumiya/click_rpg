require 'dxruby'
require_relative 'Fade_Effect.rb'
require_relative 'Facility.rb'
require_relative 'Message_Box.rb'
require_relative 'Scene_Base.rb'
require_relative 'Scene_Home.rb'

class Scene_Creation < Scene_Base
  D_BEGIN_X = 160 # 描画開始位置X座標
  D_BEGIN_Y = 0   # 描画開始位置Y座標
  
  NONE      = 0 # 何もない草原
  FARMER    = 1 # 農家
  HOUSE     = 2 # 住宅
  SHOP      = 3 # 商店
  FOOD_SHOP = 4 # 食料品店
  MANSION   = 5 # 高級住宅
  
  def initialize()
    super
    @next_scene = nil
    @message = ""
    @wait_frame = 0
    # 人口
    @population = 0
    # 食料
    @food = 0
    # 1戦闘ごとの収入
    @income = 0
    # 消費人口
    @consumed_population = 0
    # 消費食料
    @consumed_food = 0
    # 使える人口
    @surplus_population = 0
    # 使える食料
    @surplus_food = 0
    # 各施設情報
    @facilities = Array.new(6)
    @facilities[NONE]      = Facility.new(0)
    @facilities[FARMER]    = Facility.new(1)
    @facilities[HOUSE]     = Facility.new(2)
    @facilities[SHOP]      = Facility.new(3)
    @facilities[FOOD_SHOP] = Facility.new(4)
    @facilities[MANSION]   = Facility.new(5)
    # ボタン座標情報
    @button_hitbox = Hash.new
    @button_hitbox["farmer"]      = [13,   61,  148, 100]
    @button_hitbox["house"]       = [13,  113,  148, 152]
    @button_hitbox["shop"]        = [13,  167,  148, 206]
    @button_hitbox["food_shop"]   = [13,  219,  148, 258]
    @button_hitbox["mansion"]     = [13,  270,  148, 309]
    @button_hitbox["back"]        = [160, 509, 284, 539]
    @button_hitbox["install"]     = [9,    11,  70,  43]
    @button_hitbox["info"]        = [81,   11, 142,  43]
    @button_hitbox["map"]         = [160,   0, 959, 518]
    # マウスカーソルを表示
    Input.mouse_enable = true
  end
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
    super
    @fade_effect = Fade_Effect.new
    @fade_effect.setup(1)
    
    # 画像の読込
    @install_frame = Image.load("image/creation/install.png")
    @info_frame = Image.load("image/creation/info.png")
    @map_chip = Image.load_tiles("image/creation/map_chip.png", 6, 1)
    
    @font = Font.new(28)
    @system_font = Font.new(18, "ＭＳ ゴシック")
    
    # メニュー状態 0 が設置メニューで 1 が情報メニュー
    @menu_state = 0
    
    # 現在選択している施設
    @select_facility = 0
    
    @back_home = false
  end
  
  # フレーム更新処理
  def update()
    # フェードアウト/フェードインの表示
    @fade_effect.update
    if @fade_effect.effect_end? then
      if @back_home == true then
        @next_scene = Scene_Home.new
      end
    else
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
    calc_parameter()
    $player.income = @income
  end
  
  # 次のシーンに遷移
  # 遷移しない場合は nil を返す
  def get_next_scene()
    return @next_scene
  end
  
  # 画面状態の遷移処理
  def state_change()
  end
  
  # 画面の描画
  def draw()
    # マップの描画
    for x in 0..19 do
      for y in 0..12 do
        Window.draw(D_BEGIN_X + (x*40), D_BEGIN_Y + (y*40), @map_chip[0])
        case $player.town[x][y]
        when FARMER
          Window.draw(D_BEGIN_X + (x*40), D_BEGIN_Y + (y*40), @map_chip[1])
        when HOUSE
          Window.draw(D_BEGIN_X + (x*40), D_BEGIN_Y + (y*40), @map_chip[2])
        when SHOP
          Window.draw(D_BEGIN_X + (x*40), D_BEGIN_Y + (y*40), @map_chip[3])
        when FOOD_SHOP
          Window.draw(D_BEGIN_X + (x*40), D_BEGIN_Y + (y*40), @map_chip[4])
        when MANSION
          Window.draw(D_BEGIN_X + (x*40), D_BEGIN_Y + (y*40), @map_chip[5])
        end
      end
    end
    
    # フレームの描画
    if @menu_state == 0 then
      Window.draw(0, 0, @install_frame)
      Window.draw_font(11, 13, "設置", @font, {:color=>[255, 128, 0]})
      Window.draw_font(83, 13, "情報", @font)
      
      # 施設情報の描画
      if @select_facility > 0 then
        Window.draw_font(92, 355, @facilities[@select_facility].population.to_s, @system_font)
        Window.draw_font(92, 355 + @system_font.size, @facilities[@select_facility].food.to_s, @system_font)
        Window.draw_font(92, 355 + (@system_font.size*2)+2, @facilities[@select_facility].add_population.to_s, @system_font)
        Window.draw_font(92, 355 + (@system_font.size*3)+2, @facilities[@select_facility].add_food.to_s, @system_font)
        Window.draw_font(92, 355 + (@system_font.size*4)+4, @facilities[@select_facility].add_income.to_s, @system_font)
        Window.draw_font(92, 355 + (@system_font.size*5)+5, @facilities[@select_facility].price.to_s, @system_font)
      end
      
      # 所持金の描画
      Window.draw_font(9, 507, sprintf("% 16d", $player.gold), @system_font)
      
      # 施設名の描画
      if set_facility?(1) then
        Window.draw_font(56, 61, "農家", @system_font)
      else
        Window.draw_font(56, 61, "農家", @system_font, {:color=>[128, 128, 128]})
      end
      if set_facility?(2) then
        Window.draw_font(56, 113, "住宅", @system_font)
      else
        Window.draw_font(56, 113, "住宅", @system_font, {:color=>[128, 128, 128]})
      end
      if set_facility?(3) then
        Window.draw_font(56, 167, "商店", @system_font)
      else
        Window.draw_font(56, 167, "商店", @system_font, {:color=>[128, 128, 128]})
      end
      if set_facility?(4) then
        Window.draw_font(56, 219, "食料品店", @system_font)
      else
        Window.draw_font(56, 219, "食料品店", @system_font, {:color=>[128, 128, 128]})
      end
      if set_facility?(5) then
        Window.draw_font(56, 270, "高級住宅", @system_font)
      else
        Window.draw_font(56, 270, "高級住宅", @system_font, {:color=>[128, 128, 128]})
      end
    else
      Window.draw(0, 0, @info_frame)
      Window.draw_font(11, 13, "設置", @font)
      Window.draw_font(83, 13, "情報", @font, {:color=>[255, 128, 0]})
      
      # マップ情報の描画
      # 現在の人口
      Window.draw_font(10, 77, sprintf("% 15d", @population), @system_font)
      # 現在の食料
      Window.draw_font(10, 141, sprintf("% 15d", @food), @system_font)
      # 1戦闘ごとの収入
      Window.draw_font(10, 206, sprintf("% 15d", @income), @system_font)
      # 消費人口
      Window.draw_font(10, 269, sprintf("% 15d", @consumed_population), @system_font)
      # 消費食料
      Window.draw_font(10, 335, sprintf("% 15d", @consumed_food), @system_font)
      # 使える人口
      Window.draw_font(10, 393, sprintf("% 15d", @surplus_population), @system_font)
      # 使える食料
      Window.draw_font(10, 461, sprintf("% 15d", @surplus_food), @system_font)
    end
    
    # メッセージボックスの表示
    if @message != "" then
      Message_Box.show(@message)
      if @wait_frame < 1 then
        @message = ""
      end
    end
  end
  
  # キー入力処理
  def input()
    x = Input.mouse_x - 160
    y = Input.mouse_y
    x = (x.to_f / 40.0).floor
    y = (y.to_f / 40.0).floor

    # マウスホバー
    if mouse_widthin_button?("map") then
      if @select_facility > 0 then
        # 半透明で選択中の施設を表示
        Window.draw_alpha(x * 40 + 160, y * 40, @map_chip[@select_facility], 128)
      end
    end
    
    # マウス左ボタンクリック
    if Input.mouse_push?(M_LBUTTON) then
      # 街に戻るボタンを押した
      if mouse_widthin_button?("back") then
        @back_home = true
        @fade_effect.setup(0)
      end
      
      if mouse_widthin_button?("install") then
        # 設置ボタンを押した
        calc_parameter()
        @menu_state = 0
      elsif mouse_widthin_button?("info") then
        # 情報ボタンを押した
        calc_parameter()
        @menu_state = 1
      end
      
      if @select_facility > 0 then
        if mouse_widthin_button?("map") then
          if @select_facility > 0 then
            # その施設を置ける条件を満たしているか？
            if set_facility?(@select_facility) then
              # 置ける
              $player.gold -= @facilities[@select_facility].price
              $player.town[x][y] = @select_facility
            else
              @message = "選択している施設を置けません！"
              if @facilities[@select_facility].population > @surplus_population then
                @message += "<br>人口が不足しています！"
              end
              if @facilities[@select_facility].food > @surplus_food then
                @message += "<br>食料が不足しています！"
              end
              if @facilities[@select_facility].price > $player.gold then
                @message += "<br>所持金が不足しています！"
              end
              @wait_frame = 95
            end
          end
        end
      end
      
      if @menu_state == 0 then
        temp_select_facility = @select_facility
        @select_facility = 0
        if mouse_widthin_button?("farmer") then
          @select_facility = 1
        elsif mouse_widthin_button?("house") then
          @select_facility = 2
        elsif mouse_widthin_button?("shop") then
          @select_facility = 3
        elsif mouse_widthin_button?("food_shop") then
          @select_facility = 4
        elsif mouse_widthin_button?("mansion") then
          @select_facility = 5
        else
          @select_facility = temp_select_facility
        end
      end
      
    end
    
    # マウス右ボタンクリック
    if Input.mouse_push?(M_RBUTTON) then
      if mouse_widthin_button?("map") then
        t_facility = $player.town[x][y]
        $player.town[x][y] = NONE
        calc_parameter()
        tear_down = true
        message_plus = ""
        if @surplus_population < 0 then
          tear_down = false
          message_plus = "<br>人口が不足するため、この施設を取り壊せません！"
        elsif @surplus_food < 0 then
          tear_down = false
          message_plus = "<br>食料が不足するため、この施設を取り壊せません！"
        end
        
        if tear_down then
          $player.gold += @facilities[t_facility].price
        else
          @message = "この施設を取り壊せません！" + message_plus
          @wait_frame = 95
          $player.town[x][y] = t_facility
        end
      end
    end
    
  end
  
  # 各パラメーターの計算
  def calc_parameter()
    @population = 0
    @food = 0
    @income = 0
    @consumed_population = 0
    @consumed_food = 0
    @surplus_population = 0
    @surplus_food = 0
    
    for x in 0..19 do
      for y in 0..12 do
        @population += @facilities[$player.town[x][y]].add_population
        @food += @facilities[$player.town[x][y]].add_food
        @income += @facilities[$player.town[x][y]].add_income
        @consumed_population += @facilities[$player.town[x][y]].population
        @consumed_food += @facilities[$player.town[x][y]].food
      end
    end
    
    @surplus_population = @population - @consumed_population
    @surplus_food = @food - @consumed_food
  end
  
  # 施設が配置できる条件を満たしているか？
  def set_facility?(idx)
    calc_parameter()
    
    if @facilities[idx].population <= @surplus_population &&
       @facilities[idx].food <= @surplus_food &&
       @facilities[idx].price <= $player.gold then
       
       return true
       
    end
    
    return false
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
  
  # ウェイト処理
  def wait?()
    if @wait_frame > 0 then
      @wait_frame -= 1
      return true
    end
    return false
  end
end