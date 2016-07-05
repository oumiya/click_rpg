# 武器データクラス
class Weapon_Data

  # 武器データをハッシュの配列で定義
  def initialize()
    @weapon = Array.new
    @weapon.push({:name=>"かたい木の棒", :value=>1, :effect_id=>1, :price=>10})
    @weapon.push({:name=>"棍棒", :value=>2, :effect_id=>1, :price=>50})
    @weapon.push({:name=>"石斧", :value=>3, :effect_id=>1, :price=>100})
    @weapon.push({:name=>"鉄棒", :value=>4, :effect_id=>1, :price=>200})
    @weapon.push({:name=>"良い鉄棒", :value=>5, :effect_id=>1, :price=>400})
    @weapon.push({:name=>"銅の剣", :value=>6, :effect_id=>1, :price=>800})
    @weapon.push({:name=>"鉄の剣", :value=>7, :effect_id=>1, :price=>1600})
    @weapon.push({:name=>"鋼の剣", :value=>8, :effect_id=>1, :price=>3200})
    @weapon.push({:name=>"日本刀", :value=>10, :effect_id=>1, :price=>6400})
    @weapon.push({:name=>"日本刀（業物）", :value=>12, :effect_id=>1, :price=>12800})
    @weapon.push({:name=>"曲月刀", :value=>13, :effect_id=>1, :price=>25600})
    @weapon.push({:name=>"青龍刀", :value=>15, :effect_id=>1, :price=>51200})
    @weapon.push({:name=>"鉄の槍", :value=>17, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"鋼の槍", :value=>19, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"マサムネ", :value=>21, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"モミジ", :value=>23, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"テラニシ", :value=>26, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"チカオ", :value=>29, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"ノウテラス", :value=>32, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"フシッギ", :value=>35, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"ジョカ", :value=>38, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"炎の剣", :value=>41, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"氷の剣", :value=>45, :effect_id=>1, :price=>102400})# 4
    @weapon.push({:name=>"雷の剣", :value=>49, :effect_id=>1, :price=>102400})# 4
    @weapon.push({:name=>"ゼログン", :value=>54, :effect_id=>1, :price=>102400})# 4
    @weapon.push({:name=>"ソシエイト", :value=>58, :effect_id=>1, :price=>102400})# 4
    @weapon.push({:name=>"ナンクル", :value=>62, :effect_id=>1, :price=>102400})# 4
    @weapon.push({:name=>"ナイサー", :value=>66, :effect_id=>1, :price=>102400})# 4
    @weapon.push({:name=>"銀の翼", :value=>70, :effect_id=>1, :price=>102400})# 4
    @weapon.push({:name=>"草薙の剣", :value=>74, :effect_id=>1, :price=>102400})# 4
    @weapon.push({:name=>"レキインテン", :value=>79, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"バンテン", :value=>84, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"バンテンイン", :value=>89, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"鳳天華", :value=>94, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"孔雀蓮華", :value=>99, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"アナンキ", :value=>104, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"ヴィシュヌ", :value=>109, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"レーヴァチィン", :value=>114, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"カシナート", :value=>119, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"カリバーン", :value=>125, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"エクスカリバーン", :value=>131, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"アース", :value=>136, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"月光剣", :value=>141, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"マーズソード", :value=>145, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"マーキュリー", :value=>150, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"ジュピター", :value=>155, :effect_id=>1, :price=>102400}) #5
    @weapon.push({:name=>"ヴィーナス", :value=>160, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"サターン", :value=>165, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"サン", :value=>170, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"冥王剣", :value=>180, :effect_id=>1, :price=>102400})
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
