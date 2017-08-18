# イベント時のアバター髪型クラス
class Avater_Hair
  attr_accessor :colors
  
  def initialize()
    @images = Hash.new
    
    hairs = Hash.new
    hairs["beige"] = Image.load("image/avater_event/hair/crew_cut-beige.png")
    hairs["black"] = Image.load("image/avater_event/hair/crew_cut-black.png")
    hairs["blue"] = Image.load("image/avater_event/hair/crew_cut-blue.png")
    hairs["brown"] = Image.load("image/avater_event/hair/crew_cut-brown.png")
    hairs["copper"] = Image.load("image/avater_event/hair/crew_cut-copper.png")
    hairs["gold"] = Image.load("image/avater_event/hair/crew_cut-gold.png")
    hairs["green"] = Image.load("image/avater_event/hair/crew_cut-green.png")
    hairs["natural"] = Image.load("image/avater_event/hair/crew_cut-natural.png")
    hairs["pink"] = Image.load("image/avater_event/hair/crew_cut-pink.png")
    hairs["red"] = Image.load("image/avater_event/hair/crew_cut-red.png")
    hairs["violet"] = Image.load("image/avater_event/hair/crew_cut-violet.png")
    hairs["white"] = Image.load("image/avater_event/hair/crew_cut-white.png")
    @images["crew_cut"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/avater_event/hair/guile-beige.png")
    hairs["black"] = Image.load("image/avater_event/hair/guile-black.png")
    hairs["blue"] = Image.load("image/avater_event/hair/guile-blue.png")
    hairs["brown"] = Image.load("image/avater_event/hair/guile-brown.png")
    hairs["copper"] = Image.load("image/avater_event/hair/guile-copper.png")
    hairs["gold"] = Image.load("image/avater_event/hair/guile-gold.png")
    hairs["green"] = Image.load("image/avater_event/hair/guile-green.png")
    hairs["natural"] = Image.load("image/avater_event/hair/guile-natural.png")
    hairs["pink"] = Image.load("image/avater_event/hair/guile-pink.png")
    hairs["red"] = Image.load("image/avater_event/hair/guile-red.png")
    hairs["violet"] = Image.load("image/avater_event/hair/guile-violet.png")
    hairs["white"] = Image.load("image/avater_event/hair/guile-white.png")
    @images["guile"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/avater_event/hair/long-beige.png")
    hairs["black"] = Image.load("image/avater_event/hair/long-black.png")
    hairs["blue"] = Image.load("image/avater_event/hair/long-blue.png")
    hairs["brown"] = Image.load("image/avater_event/hair/long-brown.png")
    hairs["copper"] = Image.load("image/avater_event/hair/long-copper.png")
    hairs["gold"] = Image.load("image/avater_event/hair/long-gold.png")
    hairs["green"] = Image.load("image/avater_event/hair/long-green.png")
    hairs["natural"] = Image.load("image/avater_event/hair/long-natural.png")
    hairs["pink"] = Image.load("image/avater_event/hair/long-pink.png")
    hairs["red"] = Image.load("image/avater_event/hair/long-red.png")
    hairs["violet"] = Image.load("image/avater_event/hair/long-violet.png")
    hairs["white"] = Image.load("image/avater_event/hair/long-white.png")
    @images["long"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/avater_event/hair/mohawk-beige.png")
    hairs["black"] = Image.load("image/avater_event/hair/mohawk-black.png")
    hairs["blue"] = Image.load("image/avater_event/hair/mohawk-blue.png")
    hairs["brown"] = Image.load("image/avater_event/hair/mohawk-brown.png")
    hairs["copper"] = Image.load("image/avater_event/hair/mohawk-copper.png")
    hairs["gold"] = Image.load("image/avater_event/hair/mohawk-gold.png")
    hairs["green"] = Image.load("image/avater_event/hair/mohawk-green.png")
    hairs["natural"] = Image.load("image/avater_event/hair/mohawk-natural.png")
    hairs["pink"] = Image.load("image/avater_event/hair/mohawk-pink.png")
    hairs["red"] = Image.load("image/avater_event/hair/mohawk-red.png")
    hairs["violet"] = Image.load("image/avater_event/hair/mohawk-violet.png")
    hairs["white"] = Image.load("image/avater_event/hair/mohawk-white.png")
    @images["mohawk"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/avater_event/hair/semi_long-beige.png")
    hairs["black"] = Image.load("image/avater_event/hair/semi_long-black.png")
    hairs["blue"] = Image.load("image/avater_event/hair/semi_long-blue.png")
    hairs["brown"] = Image.load("image/avater_event/hair/semi_long-brown.png")
    hairs["copper"] = Image.load("image/avater_event/hair/semi_long-copper.png")
    hairs["gold"] = Image.load("image/avater_event/hair/semi_long-gold.png")
    hairs["green"] = Image.load("image/avater_event/hair/semi_long-green.png")
    hairs["natural"] = Image.load("image/avater_event/hair/semi_long-natural.png")
    hairs["pink"] = Image.load("image/avater_event/hair/semi_long-pink.png")
    hairs["red"] = Image.load("image/avater_event/hair/semi_long-red.png")
    hairs["violet"] = Image.load("image/avater_event/hair/semi_long-violet.png")
    hairs["white"] = Image.load("image/avater_event/hair/semi_long-white.png")
    @images["semi_long"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/avater_event/hair/short-beige.png")
    hairs["black"] = Image.load("image/avater_event/hair/short-black.png")
    hairs["blue"] = Image.load("image/avater_event/hair/short-blue.png")
    hairs["brown"] = Image.load("image/avater_event/hair/short-brown.png")
    hairs["copper"] = Image.load("image/avater_event/hair/short-copper.png")
    hairs["gold"] = Image.load("image/avater_event/hair/short-gold.png")
    hairs["green"] = Image.load("image/avater_event/hair/short-green.png")
    hairs["natural"] = Image.load("image/avater_event/hair/short-natural.png")
    hairs["pink"] = Image.load("image/avater_event/hair/short-pink.png")
    hairs["red"] = Image.load("image/avater_event/hair/short-red.png")
    hairs["violet"] = Image.load("image/avater_event/hair/short-violet.png")
    hairs["white"] = Image.load("image/avater_event/hair/short-white.png")
    @images["short"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/avater_event/hair/short_mohawk-beige.png")
    hairs["black"] = Image.load("image/avater_event/hair/short_mohawk-black.png")
    hairs["blue"] = Image.load("image/avater_event/hair/short_mohawk-blue.png")
    hairs["brown"] = Image.load("image/avater_event/hair/short_mohawk-brown.png")
    hairs["copper"] = Image.load("image/avater_event/hair/short_mohawk-copper.png")
    hairs["gold"] = Image.load("image/avater_event/hair/short_mohawk-gold.png")
    hairs["green"] = Image.load("image/avater_event/hair/short_mohawk-green.png")
    hairs["natural"] = Image.load("image/avater_event/hair/short_mohawk-natural.png")
    hairs["pink"] = Image.load("image/avater_event/hair/short_mohawk-pink.png")
    hairs["red"] = Image.load("image/avater_event/hair/short_mohawk-red.png")
    hairs["violet"] = Image.load("image/avater_event/hair/short_mohawk-violet.png")
    hairs["white"] = Image.load("image/avater_event/hair/short_mohawk-white.png")
    @images["short_mohawk"] = hairs

    hairs = Hash.new
    hairs["beige"] = Image.load("image/avater_event/hair/tails-beige.png")
    hairs["black"] = Image.load("image/avater_event/hair/tails-black.png")
    hairs["blue"] = Image.load("image/avater_event/hair/tails-blue.png")
    hairs["brown"] = Image.load("image/avater_event/hair/tails-brown.png")
    hairs["copper"] = Image.load("image/avater_event/hair/tails-copper.png")
    hairs["gold"] = Image.load("image/avater_event/hair/tails-gold.png")
    hairs["green"] = Image.load("image/avater_event/hair/tails-green.png")
    hairs["natural"] = Image.load("image/avater_event/hair/tails-natural.png")
    hairs["pink"] = Image.load("image/avater_event/hair/tails-pink.png")
    hairs["red"] = Image.load("image/avater_event/hair/tails-red.png")
    hairs["violet"] = Image.load("image/avater_event/hair/tails-violet.png")
    hairs["white"] = Image.load("image/avater_event/hair/tails-white.png")
    @images["tails"] = hairs
    
    hairs = Hash.new
    hairs["beige"] = Image.load("image/avater_event/hair/unruly-beige.png")
    hairs["black"] = Image.load("image/avater_event/hair/unruly-black.png")
    hairs["blue"] = Image.load("image/avater_event/hair/unruly-blue.png")
    hairs["brown"] = Image.load("image/avater_event/hair/unruly-brown.png")
    hairs["copper"] = Image.load("image/avater_event/hair/unruly-copper.png")
    hairs["gold"] = Image.load("image/avater_event/hair/unruly-gold.png")
    hairs["green"] = Image.load("image/avater_event/hair/unruly-green.png")
    hairs["natural"] = Image.load("image/avater_event/hair/unruly-natural.png")
    hairs["pink"] = Image.load("image/avater_event/hair/unruly-pink.png")
    hairs["red"] = Image.load("image/avater_event/hair/unruly-red.png")
    hairs["violet"] = Image.load("image/avater_event/hair/unruly-violet.png")
    hairs["white"] = Image.load("image/avater_event/hair/unruly-white.png")
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
  
  def draw(draw_image, x, y)
    if @images.has_key?($player.hair) then
      image = @images[$player.hair][$player.hair_color]
      draw_image.draw(x, y, image)
    end
  end

end