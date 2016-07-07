# 武器データクラス
class Weapon_Data

  # 武器データをハッシュの配列で定義
  def initialize()
    @weapon = Array.new
    @weapon.push({:name=>"木剣", :value=>1, :price=>10})
    @weapon.push({:name=>"棍棒", :value=>2, :price=>20})
    @weapon.push({:name=>"銅の剣", :value=>5, :price=>50})
    @weapon.push({:name=>"鉄の剣", :value=>8, :price=>100})
    @weapon.push({:name=>"木の棍", :value=>9, :price=>220})
    @weapon.push({:name=>"鉄の棍", :value=>11, :price=>350})
    @weapon.push({:name=>"数打ちの剣", :value=>13, :price=>400})
    @weapon.push({:name=>"業物の剣", :value=>15, :price=>800})
    @weapon.push({:name=>"三節棍", :value=>18, :price=>1000})
    @weapon.push({:name=>"鉄の槍", :value=>20, :price=>1500})
    @weapon.push({:name=>"鋼の剣", :value=>22, :price=>2500})
    @weapon.push({:name=>"レザーウィップ", :value=>24, :price=>4000})
    @weapon.push({:name=>"鉄の爪", :value=>28, :price=>5500})
    @weapon.push({:name=>"炎の爪", :value=>30, :price=>7000})
    @weapon.push({:name=>"カタナ", :value=>32, :price=>8500})
    @weapon.push({:name=>"ツインブレード", :value=>35, :price=>10000})
    @weapon.push({:name=>"バンテン", :value=>38, :price=>11500})
    @weapon.push({:name=>"アースの剣", :value=>40, :price=>13000})
    @weapon.push({:name=>"ムラマサ", :value=>42, :price=>14500})
    @weapon.push({:name=>"月光剣", :value=>44, :price=>16000})
    @weapon.push({:name=>"バンテンイン", :value=>45, :price=>17500})
    @weapon.push({:name=>"マーズの剣", :value=>48, :price=>19000})
    @weapon.push({:name=>"マサムネ", :value=>50, :price=>20500})
    @weapon.push({:name=>"冥王剣", :value=>55, :price=>22000})
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
