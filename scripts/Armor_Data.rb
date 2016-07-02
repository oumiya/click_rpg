# 防具データクラス
class Armor_Data

  # 防具データをハッシュの配列で定義
  def initialize()
    @armor = Array.new
    @armor.push({:name=>"汚いシャツ", :value=>1, :filename=>"shirt.png", :price=>10})
    @armor.push({:name=>"白シャツ", :value=>2, :filename=>"shirt.png", :price=>50})
    @armor.push({:name=>"灰色シャツ", :value=>3, :filename=>"shirt.png", :price=>100})
    @armor.push({:name=>"黒シャツ", :value=>4, :filename=>"shirt.png", :price=>200})
    @armor.push({:name=>"赤シャツ", :value=>5, :filename=>"shirt.png", :price=>400})
    @armor.push({:name=>"青シャツ", :value=>6, :filename=>"shirt.png", :price=>800})
    @armor.push({:name=>"黄色シャツ", :value=>7, :filename=>"shirt.png", :price=>1600})
    @armor.push({:name=>"白シャツ（長袖）", :value=>8, :filename=>"shirt.png", :price=>3200})
    @armor.push({:name=>"灰色シャツ（長袖）", :value=>9, :filename=>"shirt.png", :price=>6400})
    @armor.push({:name=>"黒シャツ（長袖）", :value=>10, :filename=>"shirt.png", :price=>12800})
    @armor.push({:name=>"赤シャツ（長袖）", :value=>11, :filename=>"shirt.png", :price=>25600})
    @armor.push({:name=>"青シャツ（長袖）", :value=>12, :filename=>"shirt.png", :price=>51200})
    @armor.push({:name=>"黄色シャツ（長袖）", :value=>13, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"白ポロシャツ", :value=>14, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"灰色ポロシャツ", :value=>15, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"黒ポロシャツ", :value=>16, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"赤ポロシャツ", :value=>17, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"青ポロシャツ", :value=>18, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"黄色ポロシャツ", :value=>19, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"白タンクトップ", :value=>20, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"灰色タンクトップ", :value=>21, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"黒タンクトップ", :value=>22, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"赤タンクトップ", :value=>23, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"青タンクトップ", :value=>24, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"黄色タンクトップ", :value=>25, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"白ブラ", :value=>26, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"灰色ブラじ", :value=>27, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"黒ブラ", :value=>28, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"赤ブラ", :value=>29, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"青ブラ", :value=>30, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"黄色ブラ", :value=>31, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"白ワンピース", :value=>32, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"灰色ワンピース", :value=>33, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"黒ワンピース", :value=>34, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"赤ワンピース", :value=>35, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"青ワンピース", :value=>36, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"黄色ワンピース", :value=>37, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"白ジャケット", :value=>38, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"灰色ジャケット", :value=>39, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"黒ジャケット", :value=>40, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"赤ジャケット", :value=>41, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"青ジャケット", :value=>42, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"黄色ジャケット", :value=>43, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"皮の鎧", :value=>44, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"木の鎧", :value=>45, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"銅の鎧", :value=>46, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"鉄の鎧", :value=>47, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"鋼の鎧", :value=>48, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"派手な鎧", :value=>49, :filename=>"shirt.png", :price=>102400})
    @armor.push({:name=>"Yパンツ", :value=>50, :filename=>"shirt.png", :price=>102400})
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
