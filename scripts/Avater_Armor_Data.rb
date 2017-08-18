# イベント用アバターの防具データクラス
class Avater_Armor_Data

  # 防具データをハッシュの配列で定義
  def initialize()
    @armor = Array.new
    @armor.push({:filename=>"clothes.png"})
    @armor.push({:filename=>"leather.png"})
    @armor.push({:filename=>"plywood.png"})
    @armor.push({:filename=>"scales.png"})
    @armor.push({:filename=>"chain.png"})
    @armor.push({:filename=>"iron.png"})
    @armor.push({:filename=>"hiten.png"})
    @armor.push({:filename=>"magic.png"})
    @armor.push({:filename=>"black.png"})
    @armor.push({:filename=>"silver.png"})
    @armor.push({:filename=>"devil.png"})
    @armor.push({:filename=>"death.png"})
    @armor.push({:filename=>"fire_mouse.png"})
    @armor.push({:filename=>"asbestos.png"})
    @armor.push({:filename=>"sengoku.png"})
    @armor.push({:filename=>"furinkazan.png"})
    @armor.push({:filename=>"heavy.png"})
    @armor.push({:filename=>"magic_armor.png"})
    @armor.push({:filename=>"ice_armor.png"})
    @armor.push({:filename=>"jupiter.png"})
    @armor.push({:filename=>"platinum.png"})
    @armor.push({:filename=>"brave.png"})
    @armor.push({:filename=>"aramusha.png"})
    @armor.push({:filename=>"mystery.png"})
    @armor.push({:filename=>"arrow.png"})
    
    @images = Array.new
    @armor.each{|a|
      img = Image.load("image/avater_event/armor/" + a[:filename])
      @images.push(img)
    }
  end
  
  def draw(draw_img, x, y)
    return if $player.equip_armor < 0
    draw_img.draw(x, y, @images[$player.have_armor[$player.equip_armor]["idx"]])
  end
  
  def length()
    return @armor.length
  end
end
