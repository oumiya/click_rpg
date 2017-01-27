# 武器データクラス
# 武器の属性について 0:無属性 1:火属性 2:氷属性 3:土属性 4:風属性 5:光属性 6:闇属性
class Weapon_Data

  # 武器データをハッシュの配列で定義
  def initialize()
    @weapon = Array.new
    @weapon.push({:name=>"木剣", :value=>10, :price=>10, :element=>""})
    @weapon.push({:name=>"棍棒", :value=>20, :price=>20, :element=>""})
    @weapon.push({:name=>"銅の剣", :value=>50, :price=>50, :element=>""})
    @weapon.push({:name=>"鉄の剣", :value=>80, :price=>100, :element=>""})
    @weapon.push({:name=>"木の棍", :value=>90, :price=>220, :element=>""})
    @weapon.push({:name=>"鉄の棍", :value=>110, :price=>350, :element=>""})
    @weapon.push({:name=>"数打ちの剣", :value=>130, :price=>400, :element=>""})
    @weapon.push({:name=>"業物の剣", :value=>150, :price=>800, :element=>""})
    @weapon.push({:name=>"三節棍", :value=>180, :price=>1000, :element=>""})
    @weapon.push({:name=>"鉄の槍", :value=>200, :price=>1500, :element=>""})
    @weapon.push({:name=>"鋼の剣", :value=>220, :price=>2500, :element=>""})
    @weapon.push({:name=>"レザーウィップ", :value=>240, :price=>4000, :element=>""})
    @weapon.push({:name=>"鉄の爪", :value=>280, :price=>5500, :element=>""})
    @weapon.push({:name=>"炎の爪", :value=>300, :price=>7000, :element=>"火"})
    @weapon.push({:name=>"カタナ", :value=>320, :price=>8500, :element=>"風"})
    @weapon.push({:name=>"ツインブレード", :value=>350, :price=>10000, :element=>""})
    @weapon.push({:name=>"バンテン", :value=>380, :price=>11500, :element=>"闇"})
    @weapon.push({:name=>"アースの剣", :value=>400, :price=>13000, :element=>"土"})
    @weapon.push({:name=>"ムラマサ", :value=>420, :price=>14500, :element=>"風"})
    @weapon.push({:name=>"月光剣", :value=>440, :price=>16000, :element=>"光"})
    @weapon.push({:name=>"バンテンイン", :value=>450, :price=>17500, :element=>"闇"})
    @weapon.push({:name=>"マーズの剣", :value=>480, :price=>19000, :element=>"氷"})
    @weapon.push({:name=>"マサムネ", :value=>500, :price=>20500, :element=>"風"})
    @weapon.push({:name=>"冥王剣", :value=>550, :price=>22000, :element=>"闇"})
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
