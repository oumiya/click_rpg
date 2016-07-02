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
    @weapon.push({:name=>"日本刀", :value=>9, :effect_id=>1, :price=>6400})
    @weapon.push({:name=>"日本刀（業物）", :value=>10, :effect_id=>1, :price=>12800})
    @weapon.push({:name=>"曲月刀", :value=>11, :effect_id=>1, :price=>25600})
    @weapon.push({:name=>"青龍刀", :value=>12, :effect_id=>1, :price=>51200})
    @weapon.push({:name=>"鉄の槍", :value=>13, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"鋼の槍", :value=>14, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"マサムネ", :value=>15, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"モミジ", :value=>16, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"テラニシ", :value=>17, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"チカオ", :value=>18, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"ノウテラス", :value=>19, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"フシッギ", :value=>20, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"ジョカ", :value=>21, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"炎の剣", :value=>22, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"氷の剣", :value=>23, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"雷の剣", :value=>24, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"ゼログン", :value=>25, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"ソシエイト", :value=>26, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"ナンクル", :value=>27, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"ナイサー", :value=>28, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"銀の翼", :value=>29, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"草薙の剣", :value=>30, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"レキインテン", :value=>31, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"バンテン", :value=>32, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"バンテンイン", :value=>33, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"鳳天華", :value=>34, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"孔雀蓮華", :value=>35, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"アナンキ", :value=>36, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"ヴィシュヌ", :value=>37, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"レーヴァチィン", :value=>38, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"カシナート", :value=>39, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"カリバーン", :value=>40, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"エクスカリバーン", :value=>41, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"アース", :value=>42, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"月光剣", :value=>43, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"マーズソード", :value=>44, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"マーキュリー", :value=>45, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"ジュピター", :value=>46, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"ヴィーナス", :value=>47, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"サターン", :value=>48, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"サン", :value=>49, :effect_id=>1, :price=>102400})
    @weapon.push({:name=>"冥王剣", :value=>50, :effect_id=>1, :price=>102400})
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
