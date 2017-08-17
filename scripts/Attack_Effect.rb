# 攻撃エフェクトを表示する
class Attack_Effect
  attr_accessor :visible
  attr_accessor :frame_count
  
  def initialize()
    @frames = Array.new
    @frames.push(Image.load_tiles("image/animation/leftdown.png", 9, 1))
    @frames.push(Image.load_tiles("image/animation/leftup.png", 9, 1))
    @frames.push(Image.load_tiles("image/animation/right.png", 9, 1))
    @frames.push(Image.load_tiles("image/animation/left.png", 9, 1))
    @frames.push(Image.load_tiles("image/animation/rightup.png", 9, 1))
    @frames.push(Image.load_tiles("image/animation/rightdown.png", 9, 1))
    @frames.push(Image.load_tiles("image/animation/up.png", 9, 1))
    @frames.push(Image.load_tiles("image/animation/down.png", 9, 1))
    # 属性攻撃が倍加ダメージを与えた時の表示画像
    @effective_image = Image.load("image/system/effective.png")

    @frame_count = 0
    @index = 0
    @visible = false
    @combo = 0
  end
  
  def show(combo)
    @visible = true
    @frame_count = 0
    @index = 0
    @combo = combo - 1
    @combo = 0 if @combo < 0
    @combo = @combo % 8
  end
  
  def hidden()
    @visible = false
  end
  
  def update(effective)
    if @visible then
      x = 232 - @frames[@combo][@index].width / 2
      y = 152 - @frames[@combo][@index].height / 2
    
      Window.draw(237 + x, 72 + y, @frames[@combo][@index], 100)
      
      # ダメージ倍加の場合はエフェクティブというエフェクトを表示！
      if effective == true then
        Window.draw(321, 45, @effective_image, 100)
      end
      
      @frame_count += 1
      
      if @frame_count % 2 == 0 then
        @index += 1
        
        if @index > 8 then
          hidden()
        end
      end
      
    end
  end
  
  def dispose
    @frames.each{|f|
      f.each{|image|
        image.dispose
      }
    }
  end
end