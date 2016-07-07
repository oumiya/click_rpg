# 防具データクラス
class Armor_Data

  # 防具データをハッシュの配列で定義
  def initialize()
    @armor = Array.new
    @armor.push({:name=>"丈夫な服", :value=>1, :price=>10, :filename=>"clothes.png"})
    @armor.push({:name=>"革の鎧", :value=>2, :price=>20, :filename=>"leather.png"})
    @armor.push({:name=>"合板の鎧", :value=>5, :price=>50, :filename=>"plywood.png"})
    @armor.push({:name=>"スケイルメイル", :value=>8, :price=>100, :filename=>"scales.png"})
    @armor.push({:name=>"チェーンメイル", :value=>9, :price=>220, :filename=>"chain.png"})
    @armor.push({:name=>"鉄の鎧", :value=>11, :price=>350, :filename=>"iron.png"})
    @armor.push({:name=>"飛天の服", :value=>13, :price=>400, :filename=>"hiten.png"})
    @armor.push({:name=>"魔法の服", :value=>15, :price=>800, :filename=>"magic.png"})
    @armor.push({:name=>"漆黒の服", :value=>18, :price=>1000, :filename=>"black.png"})
    @armor.push({:name=>"黒銀の鎧", :value=>20, :price=>1500, :filename=>"silver.png"})
    @armor.push({:name=>"悪魔の鎧", :value=>22, :price=>2500, :filename=>"devil.png"})
    @armor.push({:name=>"死神の服", :value=>24, :price=>4000, :filename=>"death.png"})
    @armor.push({:name=>"火鼠の衣", :value=>28, :price=>5500, :filename=>"fire_mouse.png"})
    @armor.push({:name=>"石綿の衣", :value=>30, :price=>7000, :filename=>"asbestos.png"})
    @armor.push({:name=>"戦国鎧", :value=>32, :price=>8500, :filename=>"sengoku.png"})
    @armor.push({:name=>"風林火山", :value=>35, :price=>10000, :filename=>"furinkazan.png"})
    @armor.push({:name=>"厚い服", :value=>38, :price=>11500, :filename=>"heavy.png"})
    @armor.push({:name=>"魔法の鎧", :value=>40, :price=>13000, :filename=>"magic_armor.png"})
    @armor.push({:name=>"氷の鎧", :value=>42, :price=>14500, :filename=>"ice_armor.png"})
    @armor.push({:name=>"ジュピターの鎧", :value=>44, :price=>16000, :filename=>"jupiter.png"})
    @armor.push({:name=>"白金の鎧", :value=>45, :price=>17500, :filename=>"platinum.png"})
    @armor.push({:name=>"勇者の鎧", :value=>48, :price=>19000, :filename=>"brave.png"})
    @armor.push({:name=>"荒武者の鎧", :value=>50, :price=>20500, :filename=>"aramusha.png"})
    @armor.push({:name=>"神秘の服", :value=>55, :price=>22000, :filename=>"mystery.png"})
    
    @images = Array.new
    @armor.each{|a|
      img = Image.load("image/armor/" + a[:filename])
      @images.push(img)
    }
  end
  
  def draw()
    return if $player.equip_armor < 0
    return if $player.equip_armor >= @images.size
    Window.draw(29, 285, @images[$player.equip_armor])
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
