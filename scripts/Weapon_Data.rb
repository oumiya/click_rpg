# 武器データクラス
# 武器の属性について 0:無属性 1:火属性 2:氷属性 3:土属性 4:風属性 5:光属性 6:闇属性
class Weapon_Data

  # 武器データをハッシュの配列で定義
  def initialize()
    @weapon = Array.new
    @weapon.push({:name=>"木剣", :value=>10, :price=>10, :element=>"", :filename=>"00_wood.png"})
    @weapon.push({:name=>"棍棒", :value=>20, :price=>20, :element=>"", :filename=>"01_konbo.png"})
    @weapon.push({:name=>"銅の剣", :value=>50, :price=>50, :element=>"", :filename=>"02_capper.png"})
    @weapon.push({:name=>"鉄の剣", :value=>80, :price=>100, :element=>"", :filename=>"03_iron.png"})
    @weapon.push({:name=>"木の棍", :value=>90, :price=>220, :element=>"", :filename=>"04_wood_bar.png"})
    @weapon.push({:name=>"鉄の棍", :value=>110, :price=>350, :element=>"", :filename=>"05_iron_bar.png"})
    @weapon.push({:name=>"数打ちの剣", :value=>130, :price=>400, :element=>"", :filename=>"06_sword.png"})
    @weapon.push({:name=>"業物の剣", :value=>150, :price=>800, :element=>"", :filename=>"07_sword.png"})
    @weapon.push({:name=>"三節棍", :value=>180, :price=>1000, :element=>"", :filename=>"08_sansetsukon.png"})
    @weapon.push({:name=>"鉄の槍", :value=>200, :price=>1500, :element=>"", :filename=>"09_spear.png"})
    @weapon.push({:name=>"鋼の剣", :value=>220, :price=>2500, :element=>"", :filename=>"10_sword.png"})
    @weapon.push({:name=>"レザーウィップ", :value=>240, :price=>4000, :element=>"", :filename=>"11_whip.png"})
    @weapon.push({:name=>"鉄の爪", :value=>280, :price=>5500, :element=>"", :filename=>"12_iron_claw.png"})
    @weapon.push({:name=>"炎の爪", :value=>300, :price=>7000, :element=>"火", :filename=>"13_flame_claw.png"})
    @weapon.push({:name=>"カタナ", :value=>320, :price=>8500, :element=>"風", :filename=>"14_katana.png"})
    @weapon.push({:name=>"ツインブレード", :value=>350, :price=>10000, :element=>"", :filename=>"15_twin_blade.png"})
    @weapon.push({:name=>"バンテン", :value=>380, :price=>11500, :element=>"闇", :filename=>"16_banten.png"})
    @weapon.push({:name=>"アースの剣", :value=>400, :price=>13000, :element=>"土", :filename=>"17_earth.png"})
    @weapon.push({:name=>"ムラマサ", :value=>420, :price=>14500, :element=>"風", :filename=>"18_muramasa.png"})
    @weapon.push({:name=>"月光剣", :value=>440, :price=>16000, :element=>"光", :filename=>"19_moon.png"})
    @weapon.push({:name=>"バンテンイン", :value=>450, :price=>17500, :element=>"", :filename=>"20_bantenin.png"})
    @weapon.push({:name=>"マーズの剣", :value=>480, :price=>19000, :element=>"", :filename=>"21_mars.png"})
    @weapon.push({:name=>"マサムネ", :value=>500, :price=>20500, :element=>"", :filename=>"22_masamune.png"})
    @weapon.push({:name=>"冥王剣", :value=>550, :price=>22000, :element=>"", :filename=>"23_pluto.png"})
    @weapon.push({:name=>"アロウの剣", :value=>500, :price=>22000, :element=>"光", :filename=>"24_arrow.png"})
    
    @images = Array.new
    @weapon.each{|a|
      img = Image.load("image/weapon/" + a[:filename])
      @images.push(img)
    }
  end
  
  def draw()
    return if $player.equip_weapon < 0
    Window.draw(0, 285, @images[$player.have_weapon[$player.equip_weapon]["idx"]])
  end
  
  # 武器データを返す
  def get_weapon_data(id)
    return nil if id < 0
    return nil if id >= @weapon.size
    return @weapon[id]
  end
  
  def length()
    return @weapon.length
  end
end
