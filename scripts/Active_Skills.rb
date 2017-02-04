require 'dxruby'

# アクティブスキルクラス
class Active_Skills
  attr_accessor :id               # スキルID
  attr_accessor :name              # スキル名
  attr_accessor :description       # 説明
  attr_accessor :cool_time         # クールタイム（フレーム数）
  attr_accessor :cool_time_counter # クールタイムカウンタ
  attr_accessor :duration          # 持続時間
  attr_accessor :duration_counter  # 持続時間カウンタ
  attr_accessor :icon              # アイコン
  attr_accessor :icon_shadow       # スキルが使えない時にアイコンを若干黒くするための画像
  
  def initialize(id, name, description, cool_time, duration, icon_filename)
    @id = id
    @name = name
    @description = description
    @cool_time = cool_time
    @cool_time_counter = @cool_time
    @duration = duration
    @duration_counter = 0
    @icon = Image.load("image/skill/" + icon_filename)
    @icon_shadow = Image.new(96, 96, [128, 0, 0, 0]) # 半透明の黒色塗りつぶしボックス
  end
  
  # スキルを使用した
  def use()
    @cool_time_counter = 0
    @duration_counter = @duration
  end
  
  # スキルアイコンとスキルゲージの描画
  def draw()
    width = 95
    percent = @cool_time_counter.to_f / @cool_time.to_f
    gauge = (width.to_f * percent).ceil.to_i
  
    # ゲージの黒地を描く
    Window.draw_box_fill(71, 216, 166, 224, [140, 140, 140])
    # ゲージの黄色を描く
    Window.draw_box_fill(71, 216, 71 + gauge, 224, [255, 200, 0])
    
    # アイコンを描画する
    Window.draw(71, 117, @icon)
    
    # スキルが使えない時はアイコンを若干暗く描画する
    if use_skill? == false then
      Window.draw(71, 117, @icon_shadow)
    end
  end
  
  # スキルの更新処理
  def update()
    @cool_time_counter += 1
    if @cool_time_counter >= @cool_time then
      @cool_time_counter = @cool_time
    end
    @duration_counter -= 1
    if @duration_counter < 0 then
      @duration_counter = 0
    end
  end
  
  # スキルが継続中か？
  def skill_continued?()
    if @duration_counter > 0 then
      return true
    end
    return false
  end
  
  # スキルが現在使用できるかどうか
  def use_skill?()
    if @cool_time_counter >= @cool_time then
      return true
    end
    return false
  end
end

# アクティブスキルデータ
class Active_Skills_Data
  attr_accessor :skills
  
  def initialize()
    @skills = Array.new
    @skills.push(Active_Skills.new(0, "HP回復", "HPを全回復する", 600, 0, "00_heal.png"))
    @skills.push(Active_Skills.new(1, "防御範囲拡大", "防御範囲を拡大する", 600, 300, "01_guard_range_up.png"))
    @skills.push(Active_Skills.new(2, "２倍攻撃", "攻撃力２倍で攻撃する", 600, 0, "02_super_attack.png"))
    @skills.push(Active_Skills.new(3, "攻撃力UP", "攻撃力が150%アップする", 600, 300, "03_up_attack.png"))
    @skills.push(Active_Skills.new(4, "防御力UP", "防御力が150%アップする", 600, 300, "04_up_guard.png"))
    @skills.push(Active_Skills.new(5, "敵の攻撃力DOWN", "敵の攻撃力が50%になる", 600, 300, "05_down_attack.png"))
    @skills.push(Active_Skills.new(6, "敵の防御力DOWN", "敵の防御力が50%になる", 600, 300, "06_down_guard.png"))
    @skills.push(Active_Skills.new(7, "スタン", "敵の攻撃をかき消す", 300, 150, "07_shout.png"))
    @skills.push(Active_Skills.new(8, "属性反転", "自分の武器属性が相反属性に反転する", 60, 0, "08_reverse.png"))
  end
  
  def get_active_skill(idx)
    if idx then
      if idx == -1 then
        return nil
      end
      return @skills[idx]
    else
      return nil
    end
  end
end