require 'dxruby'

# 髪型クラス
class Hair
  def initialize()
    @images = Hash.new
    @images["unruly"] = Image.load("image/hair/unruly.png")
    @images["short"] = Image.load("image/hair/short.png")
    @images["crew_cut"] = Image.load("image/hair/crew_cut.png")
    @images["short_mohawk"] = Image.load("image/hair/short_mohawk.png")
    @images["mohawk"] = Image.load("image/hair/mohawk.png")
    @images["guile"] = Image.load("image/hair/guile.png")
    @images["semi_long"] = Image.load("image/hair/semi_long.png")
    @images["long"] = Image.load("image/hair/long.png")
    @images["tails"] = Image.load("image/hair/tails.png")
  end
  
  def draw()
    if @images.has_key?($player.hair) then
      image = @images[$player.hair]
      Window.draw(34, 236, image)
    end
  end
  
  
end