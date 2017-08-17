# 髪型クラス
class Hair
  attr_accessor :colors
  
  def initialize()
    @images = Hash.new
    
    hairs = Hash.new
    hairs["beige"] = Image.load("image/hair/crew_cut-beige.png")
    hairs["black"] = Image.load("image/hair/crew_cut-black.png")
    hairs["blue"] = Image.load("image/hair/crew_cut-blue.png")
    hairs["brown"] = Image.load("image/hair/crew_cut-brown.png")
    hairs["copper"] = Image.load("image/hair/crew_cut-copper.png")
    hairs["gold"] = Image.load("image/hair/crew_cut-gold.png")
    hairs["green"] = Image.load("image/hair/crew_cut-green.png")
    hairs["natural"] = Image.load("image/hair/crew_cut-natural.png")
    hairs["pink"] = Image.load("image/hair/crew_cut-pink.png")
    hairs["red"] = Image.load("image/hair/crew_cut-red.png")
    hairs["violet"] = Image.load("image/hair/crew_cut-violet.png")
    hairs["white"] = Image.load("image/hair/crew_cut-white.png")
    @images["crew_cut"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/hair/guile-beige.png")
    hairs["black"] = Image.load("image/hair/guile-black.png")
    hairs["blue"] = Image.load("image/hair/guile-blue.png")
    hairs["brown"] = Image.load("image/hair/guile-brown.png")
    hairs["copper"] = Image.load("image/hair/guile-copper.png")
    hairs["gold"] = Image.load("image/hair/guile-gold.png")
    hairs["green"] = Image.load("image/hair/guile-green.png")
    hairs["natural"] = Image.load("image/hair/guile-natural.png")
    hairs["pink"] = Image.load("image/hair/guile-pink.png")
    hairs["red"] = Image.load("image/hair/guile-red.png")
    hairs["violet"] = Image.load("image/hair/guile-violet.png")
    hairs["white"] = Image.load("image/hair/guile-white.png")
    @images["guile"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/hair/long-beige.png")
    hairs["black"] = Image.load("image/hair/long-black.png")
    hairs["blue"] = Image.load("image/hair/long-blue.png")
    hairs["brown"] = Image.load("image/hair/long-brown.png")
    hairs["copper"] = Image.load("image/hair/long-copper.png")
    hairs["gold"] = Image.load("image/hair/long-gold.png")
    hairs["green"] = Image.load("image/hair/long-green.png")
    hairs["natural"] = Image.load("image/hair/long-natural.png")
    hairs["pink"] = Image.load("image/hair/long-pink.png")
    hairs["red"] = Image.load("image/hair/long-red.png")
    hairs["violet"] = Image.load("image/hair/long-violet.png")
    hairs["white"] = Image.load("image/hair/long-white.png")
    @images["long"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/hair/mohawk-beige.png")
    hairs["black"] = Image.load("image/hair/mohawk-black.png")
    hairs["blue"] = Image.load("image/hair/mohawk-blue.png")
    hairs["brown"] = Image.load("image/hair/mohawk-brown.png")
    hairs["copper"] = Image.load("image/hair/mohawk-copper.png")
    hairs["gold"] = Image.load("image/hair/mohawk-gold.png")
    hairs["green"] = Image.load("image/hair/mohawk-green.png")
    hairs["natural"] = Image.load("image/hair/mohawk-natural.png")
    hairs["pink"] = Image.load("image/hair/mohawk-pink.png")
    hairs["red"] = Image.load("image/hair/mohawk-red.png")
    hairs["violet"] = Image.load("image/hair/mohawk-violet.png")
    hairs["white"] = Image.load("image/hair/mohawk-white.png")
    @images["mohawk"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/hair/semi_long-beige.png")
    hairs["black"] = Image.load("image/hair/semi_long-black.png")
    hairs["blue"] = Image.load("image/hair/semi_long-blue.png")
    hairs["brown"] = Image.load("image/hair/semi_long-brown.png")
    hairs["copper"] = Image.load("image/hair/semi_long-copper.png")
    hairs["gold"] = Image.load("image/hair/semi_long-gold.png")
    hairs["green"] = Image.load("image/hair/semi_long-green.png")
    hairs["natural"] = Image.load("image/hair/semi_long-natural.png")
    hairs["pink"] = Image.load("image/hair/semi_long-pink.png")
    hairs["red"] = Image.load("image/hair/semi_long-red.png")
    hairs["violet"] = Image.load("image/hair/semi_long-violet.png")
    hairs["white"] = Image.load("image/hair/semi_long-white.png")
    @images["semi_long"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/hair/short-beige.png")
    hairs["black"] = Image.load("image/hair/short-black.png")
    hairs["blue"] = Image.load("image/hair/short-blue.png")
    hairs["brown"] = Image.load("image/hair/short-brown.png")
    hairs["copper"] = Image.load("image/hair/short-copper.png")
    hairs["gold"] = Image.load("image/hair/short-gold.png")
    hairs["green"] = Image.load("image/hair/short-green.png")
    hairs["natural"] = Image.load("image/hair/short-natural.png")
    hairs["pink"] = Image.load("image/hair/short-pink.png")
    hairs["red"] = Image.load("image/hair/short-red.png")
    hairs["violet"] = Image.load("image/hair/short-violet.png")
    hairs["white"] = Image.load("image/hair/short-white.png")
    @images["short"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/hair/short_mohawk-beige.png")
    hairs["black"] = Image.load("image/hair/short_mohawk-black.png")
    hairs["blue"] = Image.load("image/hair/short_mohawk-blue.png")
    hairs["brown"] = Image.load("image/hair/short_mohawk-brown.png")
    hairs["copper"] = Image.load("image/hair/short_mohawk-copper.png")
    hairs["gold"] = Image.load("image/hair/short_mohawk-gold.png")
    hairs["green"] = Image.load("image/hair/short_mohawk-green.png")
    hairs["natural"] = Image.load("image/hair/short_mohawk-natural.png")
    hairs["pink"] = Image.load("image/hair/short_mohawk-pink.png")
    hairs["red"] = Image.load("image/hair/short_mohawk-red.png")
    hairs["violet"] = Image.load("image/hair/short_mohawk-violet.png")
    hairs["white"] = Image.load("image/hair/short_mohawk-white.png")
    @images["short_mohawk"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/hair/tails-beige.png")
    hairs["black"] = Image.load("image/hair/tails-black.png")
    hairs["blue"] = Image.load("image/hair/tails-blue.png")
    hairs["brown"] = Image.load("image/hair/tails-brown.png")
    hairs["copper"] = Image.load("image/hair/tails-copper.png")
    hairs["gold"] = Image.load("image/hair/tails-gold.png")
    hairs["green"] = Image.load("image/hair/tails-green.png")
    hairs["natural"] = Image.load("image/hair/tails-natural.png")
    hairs["pink"] = Image.load("image/hair/tails-pink.png")
    hairs["red"] = Image.load("image/hair/tails-red.png")
    hairs["violet"] = Image.load("image/hair/tails-violet.png")
    hairs["white"] = Image.load("image/hair/tails-white.png")
    @images["tails"] = hairs
    
    hairs = Hash.new
    hairs["beige"] = Image.load("image/hair/unruly-beige.png")
    hairs["black"] = Image.load("image/hair/unruly-black.png")
    hairs["blue"] = Image.load("image/hair/unruly-blue.png")
    hairs["brown"] = Image.load("image/hair/unruly-brown.png")
    hairs["copper"] = Image.load("image/hair/unruly-copper.png")
    hairs["gold"] = Image.load("image/hair/unruly-gold.png")
    hairs["green"] = Image.load("image/hair/unruly-green.png")
    hairs["natural"] = Image.load("image/hair/unruly-natural.png")
    hairs["pink"] = Image.load("image/hair/unruly-pink.png")
    hairs["red"] = Image.load("image/hair/unruly-red.png")
    hairs["violet"] = Image.load("image/hair/unruly-violet.png")
    hairs["white"] = Image.load("image/hair/unruly-white.png")
    @images["unruly"] = hairs
    
    @images.each{|key, value|
      value.each{|color_name, image|
        image.set_color_key([0,0,0])
      }
    }
    
    @colors = {"white" => [255, 213, 210, 205],
          "black" => [255, 44, 40, 39],
          "natural" => [255, 191, 125, 3],
          "brown" => [255, 153, 82, 0],
          "beige" => [255, 230, 202, 154],
          "blue" => [255, 2, 80, 165],
          "green" => [255, 58, 152, 42],
          "gold" => [255, 255, 212, 9],
          "copper" => [255, 240, 143, 0],
          "red" => [255, 229, 0, 65],
          "violet" => [255, 137, 132, 198],
          "pink" => [255, 236, 159, 195]
    }
  end
  
  def draw()
    if @images.has_key?($player.hair) then
      image = @images[$player.hair][$player.hair_color]
      Window.draw(34, 236, image)
    end
  end

end