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
    @armor.push({:name=>"灰色シャツ（長袖）", :value=>10, :price=>6400, :filename=>"long_shirt-gray.png"}) #2
    @armor.push({:name=>"黒シャツ（長袖）", :value=>12, :price=>12800, :filename=>"long_shirt-black.png"}) #2
    @armor.push({:name=>"赤シャツ（長袖）", :value=>14, :price=>25600, :filename=>"long_shirt-red.png"}) #2
    @armor.push({:name=>"青シャツ（長袖）", :value=>16, :price=>51200, :filename=>"long_shirt-blue.png"}) #2
    @armor.push({:name=>"黄色シャツ（長袖）", :value=>18, :price=>102400, :filename=>"long_shirt-yellow.png"}) #2
    @armor.push({:name=>"白ポロシャツ", :value=>20, :price=>102400, :filename=>"polo_shirt-white.png"}) #2
    @armor.push({:name=>"灰色ポロシャツ", :value=>22, :price=>102400, :filename=>"polo_shirt-gray.png"}) #2
    @armor.push({:name=>"黒ポロシャツ", :value=>24, :price=>102400, :filename=>"polo_shirt-black.png"}) #2
    @armor.push({:name=>"赤ポロシャツ", :value=>27, :price=>102400, :filename=>"polo_shirt-red.png"}) #3
    @armor.push({:name=>"青ポロシャツ", :value=>30, :price=>102400, :filename=>"polo_shirt-blue.png"}) #3
    @armor.push({:name=>"黄色ポロシャツ", :value=>33, :price=>102400, :filename=>"polo_shirt-yellow.png"}) #3
    @armor.push({:name=>"白タンクトップ", :value=>36, :price=>102400, :filename=>"tanktop-white.png"}) #3
    @armor.push({:name=>"灰色タンクトップ", :value=>39, :price=>102400, :filename=>"tanktop-gray.png"}) #3
    @armor.push({:name=>"黒タンクトップ", :value=>42, :price=>102400, :filename=>"tanktop-black.png"}) #3
    @armor.push({:name=>"赤タンクトップ", :value=>45, :price=>102400, :filename=>"tanktop-red.png"}) #3
    @armor.push({:name=>"青タンクトップ", :value=>48, :price=>102400, :filename=>"tanktop-blue.png"}) #3
    @armor.push({:name=>"黄色タンクトップ", :value=>52, :price=>102400, :filename=>"tanktop-yellow.png"}) #4
    @armor.push({:name=>"白ブラ", :value=>56, :price=>102400, :filename=>"bra-white.png"}) #4
    @armor.push({:name=>"灰色ブラ", :value=>60, :price=>102400, :filename=>"bra-gray.png"}) #4
    @armor.push({:name=>"黒ブラ", :value=>64, :price=>102400, :filename=>"bra-black.png"}) #4
    @armor.push({:name=>"赤ブラ", :value=>68, :price=>102400, :filename=>"bra-red.png"}) #4
    @armor.push({:name=>"青ブラ", :value=>72, :price=>102400, :filename=>"bra-blue.png"}) #4
    @armor.push({:name=>"黄色ブラ", :value=>76, :price=>102400, :filename=>"bra-yellow.png"}) #4
    @armor.push({:name=>"白ワンピース", :value=>80, :price=>102400, :filename=>"onepiece-white.png"}) #4
    @armor.push({:name=>"灰色ワンピース", :value=>85, :price=>102400, :filename=>"onepiece-gray.png"}) #5
    @armor.push({:name=>"黒ワンピース", :value=>90, :price=>102400, :filename=>"onepiece-black.png"}) #5
    @armor.push({:name=>"赤ワンピース", :value=>95, :price=>102400, :filename=>"onepiece-red.png"}) #5
    @armor.push({:name=>"青ワンピース", :value=>100, :price=>102400, :filename=>"onepiece-blue.png"}) #5
    @armor.push({:name=>"黄色ワンピース", :value=>105, :price=>102400, :filename=>"onepiece-yellow.png"}) #5
    @armor.push({:name=>"白ジャケット", :value=>110, :price=>102400, :filename=>"jacket-white.png"}) #5
    @armor.push({:name=>"灰色ジャケット", :value=>115, :price=>102400, :filename=>"jacket-gray.png"}) #5
    @armor.push({:name=>"黒ジャケット", :value=>120, :price=>102400, :filename=>"jacket-black.png"}) #5
    @armor.push({:name=>"赤ジャケット", :value=>125, :price=>102400, :filename=>"jacket-red.png"}) #5
    @armor.push({:name=>"青ジャケット", :value=>130, :price=>102400, :filename=>"jacket-blue.png"}) #5
    @armor.push({:name=>"黄色ジャケット", :value=>135, :price=>102400, :filename=>"jacket-yellow.png"}) #5
    @armor.push({:name=>"白の鎧", :value=>140, :price=>102400, :filename=>"armor-white.png"}) #5
    @armor.push({:name=>"灰色の鎧", :value=>145, :price=>102400, :filename=>"armor-gray.png"}) #5
    @armor.push({:name=>"黒の鎧", :value=>150, :price=>102400, :filename=>"armor-black.png"}) #5
    @armor.push({:name=>"赤の鎧", :value=>155, :price=>102400, :filename=>"armor-red.png"}) #5
    @armor.push({:name=>"青の鎧", :value=>160, :price=>102400, :filename=>"armor-blue.png"}) #5
    @armor.push({:name=>"黄の鎧", :value=>165, :price=>102400, :filename=>"armor-yellow.png"})
    @armor.push({:name=>"Yパンツ", :value=>180, :price=>102400, :filename=>"y-pants.png"})
    
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
