class Effect
  attr_accessor :images
  attr_accessor :counter
  attr_accessor :x
  attr_accessor :y
  attr_accessor :visible
  
  def initialize()
    @counter = 0
    @x = 0
    @y = 0
    @visible = false
  end
  
  def draw()
    if visible then
      Window.draw(@x, @y, @images[@counter])
    end
  end
  
  def show()
    @visible = true
    @counter = 0
  end
  
  def update()
    if @visible then
      if $frame_counter % 2 == 0 then
        @counter += 1
        if @counter >= @images.size then
          @counter = 0
          @visible = false
        end
      end
    end
  end
end
