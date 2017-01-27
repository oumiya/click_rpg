# 防具データクラス
# 防具の属性について 0:無属性 1:火属性 2:氷属性 3:土属性 4:風属性 5:光属性 6:闇属性
class Armor_Data

  # 防具データをハッシュの配列で定義
  def initialize()
    @armor = Array.new
    @armor.push({:name=>"丈夫な服", :value=>10, :price=>10, :filename=>"clothes.png", :element=>"", :heal=>0})
    @armor.push({:name=>"革の鎧", :value=>20, :price=>20, :filename=>"leather.png", :element=>"", :heal=>0})
    @armor.push({:name=>"合板の鎧", :value=>50, :price=>50, :filename=>"plywood.png", :element=>"", :heal=>0})
    @armor.push({:name=>"スケイルメイル", :value=>80, :price=>100, :filename=>"scales.png", :element=>"", :heal=>0})
    @armor.push({:name=>"チェーンメイル", :value=>90, :price=>220, :filename=>"chain.png", :element=>"", :heal=>0})
    @armor.push({:name=>"鉄の鎧", :value=>110, :price=>350, :filename=>"iron.png", :element=>"", :heal=>0})
    @armor.push({:name=>"飛天の服", :value=>130, :price=>400, :filename=>"hiten.png", :element=>"風", :heal=>0})
    @armor.push({:name=>"魔法の服", :value=>150, :price=>800, :filename=>"magic.png", :element=>"光", :heal=>0})
    @armor.push({:name=>"漆黒の服", :value=>180, :price=>1000, :filename=>"black.png", :element=>"闇", :heal=>0})
    @armor.push({:name=>"黒銀の鎧", :value=>200, :price=>1500, :filename=>"silver.png", :element=>"闇", :heal=>0})
    @armor.push({:name=>"悪魔の鎧", :value=>220, :price=>2500, :filename=>"devil.png", :element=>"闇", :heal=>0})
    @armor.push({:name=>"死神の服", :value=>240, :price=>4000, :filename=>"death.png", :element=>"闇", :heal=>0})
    @armor.push({:name=>"火鼠の衣", :value=>280, :price=>5500, :filename=>"fire_mouse.png", :element=>"火", :heal=>0})
    @armor.push({:name=>"石綿の衣", :value=>300, :price=>7000, :filename=>"asbestos.png", :element=>"火", :heal=>0})
    @armor.push({:name=>"戦国鎧", :value=>320, :price=>8500, :filename=>"sengoku.png", :element=>"", :heal=>0})
    @armor.push({:name=>"風林火山", :value=>350, :price=>10000, :filename=>"furinkazan.png", :element=>"", :heal=>0})
    @armor.push({:name=>"厚い服", :value=>380, :price=>11500, :filename=>"heavy.png", :element=>"", :heal=>0})
    @armor.push({:name=>"魔法の鎧", :value=>400, :price=>13000, :filename=>"magic_armor.png", :element=>"光", :heal=>0})
    @armor.push({:name=>"氷の鎧", :value=>420, :price=>14500, :filename=>"ice_armor.png", :element=>"氷", :heal=>0})
    @armor.push({:name=>"ジュピターの鎧", :value=>440, :price=>16000, :filename=>"jupiter.png", :element=>"", :heal=>0})
    @armor.push({:name=>"白金の鎧", :value=>450, :price=>17500, :filename=>"platinum.png", :element=>"", :heal=>0})
    @armor.push({:name=>"勇者の鎧", :value=>480, :price=>19000, :filename=>"brave.png", :element=>"光", :heal=>15})
    @armor.push({:name=>"荒武者の鎧", :value=>500, :price=>20500, :filename=>"aramusha.png", :element=>"", :heal=>0})
    @armor.push({:name=>"神秘の服", :value=>550, :price=>22000, :filename=>"mystery.png", :element=>"光", :heal=>20})
    
    @images = Array.new
    @armor.each{|a|
      img = Image.load("image/armor/" + a[:filename])
      @images.push(img)
    }
  end
  
  def draw()
    return if $player.equip_armor < 0
    return if $player.equip_armor >= @images.size
    Window.draw(29, 285, @images[$player.have_armor[$player.equip_armor]["idx"]])
  end
  
  # 防具データを返す
  def get_armor_data(id)
    return nil if id < 0
    return nil if id >= @armor.size
    return @armor[id]
  end
  
  def length()
    return @armor.length
  end
end
