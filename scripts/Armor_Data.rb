# 防具データクラス
class Armor_Data

  # 防具データをハッシュの配列で定義
  def initialize()
    @armor = Array.new
    @armor.push({:name=>"汚いシャツ", :value=>1, :price=>10, :filename=>"old_shirt.png"})
    @armor.push({:name=>"白シャツ", :value=>2, :price=>50, :filename=>"shirt-white.png"})
    @armor.push({:name=>"灰色シャツ", :value=>3, :price=>100, :filename=>"shirt-gray.png"})
    @armor.push({:name=>"黒シャツ", :value=>4, :price=>200, :filename=>"shirt-black.png"})
    @armor.push({:name=>"赤シャツ", :value=>5, :price=>400, :filename=>"shirt-red.png"})
    @armor.push({:name=>"青シャツ", :value=>6, :price=>800, :filename=>"shirt-blue.png"})
    @armor.push({:name=>"黄色シャツ", :value=>7, :price=>1600, :filename=>"shirt-yellow.png"})
    @armor.push({:name=>"白シャツ（長袖）", :value=>8, :price=>3200, :filename=>"long_shirt-white.png"})
    @armor.push({:name=>"灰色シャツ（長袖）", :value=>9, :price=>6400, :filename=>"long_shirt-gray.png"})
    @armor.push({:name=>"黒シャツ（長袖）", :value=>10, :price=>12800, :filename=>"long_shirt-black.png"})
    @armor.push({:name=>"赤シャツ（長袖）", :value=>11, :price=>25600, :filename=>"long_shirt-red.png"})
    @armor.push({:name=>"青シャツ（長袖）", :value=>12, :price=>51200, :filename=>"long_shirt-blue.png"})
    @armor.push({:name=>"黄色シャツ（長袖）", :value=>13, :price=>102400, :filename=>"long_shirt-yellow.png"})
    @armor.push({:name=>"白ポロシャツ", :value=>14, :price=>102400, :filename=>"polo_shirt-white.png"})
    @armor.push({:name=>"灰色ポロシャツ", :value=>15, :price=>102400, :filename=>"polo_shirt-gray.png"})
    @armor.push({:name=>"黒ポロシャツ", :value=>16, :price=>102400, :filename=>"polo_shirt-black.png"})
    @armor.push({:name=>"赤ポロシャツ", :value=>17, :price=>102400, :filename=>"polo_shirt-red.png"})
    @armor.push({:name=>"青ポロシャツ", :value=>18, :price=>102400, :filename=>"polo_shirt-blue.png"})
    @armor.push({:name=>"黄色ポロシャツ", :value=>19, :price=>102400, :filename=>"polo_shirt-yellow.png"})
    @armor.push({:name=>"白タンクトップ", :value=>20, :price=>102400, :filename=>"tanktop-white.png"})
    @armor.push({:name=>"灰色タンクトップ", :value=>21, :price=>102400, :filename=>"tanktop-gray.png"})
    @armor.push({:name=>"黒タンクトップ", :value=>22, :price=>102400, :filename=>"tanktop-black.png"})
    @armor.push({:name=>"赤タンクトップ", :value=>23, :price=>102400, :filename=>"tanktop-red.png"})
    @armor.push({:name=>"青タンクトップ", :value=>24, :price=>102400, :filename=>"tanktop-blue.png"})
    @armor.push({:name=>"黄色タンクトップ", :value=>25, :price=>102400, :filename=>"tanktop-yellow.png"})
    @armor.push({:name=>"白ブラ", :value=>26, :price=>102400, :filename=>"bra-white.png"})
    @armor.push({:name=>"灰色ブラ", :value=>27, :price=>102400, :filename=>"bra-gray.png"})
    @armor.push({:name=>"黒ブラ", :value=>28, :price=>102400, :filename=>"bra-black.png"})
    @armor.push({:name=>"赤ブラ", :value=>29, :price=>102400, :filename=>"bra-red.png"})
    @armor.push({:name=>"青ブラ", :value=>30, :price=>102400, :filename=>"bra-blue.png"})
    @armor.push({:name=>"黄色ブラ", :value=>31, :price=>102400, :filename=>"bra-yellow.png"})
    @armor.push({:name=>"白ワンピース", :value=>32, :price=>102400, :filename=>"onepiece-white.png"})
    @armor.push({:name=>"灰色ワンピース", :value=>33, :price=>102400, :filename=>"onepiece-gray.png"})
    @armor.push({:name=>"黒ワンピース", :value=>34, :price=>102400, :filename=>"onepiece-black.png"})
    @armor.push({:name=>"赤ワンピース", :value=>35, :price=>102400, :filename=>"onepiece-red.png"})
    @armor.push({:name=>"青ワンピース", :value=>36, :price=>102400, :filename=>"onepiece-blue.png"})
    @armor.push({:name=>"黄色ワンピース", :value=>37, :price=>102400, :filename=>"onepiece-yellow.png"})
    @armor.push({:name=>"白ジャケット", :value=>38, :price=>102400, :filename=>"jacket-white.png"})
    @armor.push({:name=>"灰色ジャケット", :value=>39, :price=>102400, :filename=>"jacket-gray.png"})
    @armor.push({:name=>"黒ジャケット", :value=>40, :price=>102400, :filename=>"jacket-black.png"})
    @armor.push({:name=>"赤ジャケット", :value=>41, :price=>102400, :filename=>"jacket-red.png"})
    @armor.push({:name=>"青ジャケット", :value=>42, :price=>102400, :filename=>"jacket-blue.png"})
    @armor.push({:name=>"黄色ジャケット", :value=>43, :price=>102400, :filename=>"jacket-yellow.png"})
    @armor.push({:name=>"白の鎧", :value=>44, :price=>102400, :filename=>"armor-white.png"})
    @armor.push({:name=>"灰色の鎧", :value=>45, :price=>102400, :filename=>"armor-gray.png"})
    @armor.push({:name=>"黒の鎧", :value=>46, :price=>102400, :filename=>"armor-black.png"})
    @armor.push({:name=>"赤の鎧", :value=>47, :price=>102400, :filename=>"armor-red.png"})
    @armor.push({:name=>"青の鎧", :value=>48, :price=>102400, :filename=>"armor-blue.png"})
    @armor.push({:name=>"黄の鎧", :value=>49, :price=>102400, :filename=>"armor-yellow.png"})
    @armor.push({:name=>"Yパンツ", :value=>50, :price=>102400, :filename=>"y-pants.png"})
    
    @images = Array.new
    @armor.each{|a|
      img = Image.load("image/armor/" + a[:filename])
      img.set_color_key([0,0,0])
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
