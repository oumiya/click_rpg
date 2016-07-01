require 'json'

# セーブデータを管理するクラス
module Save_Data
  # ゲームデータをセーブする
  # 2016.07.01 現時点ではプレイヤー情報のみセーブ
  def save()
    save_data = Hash.new
    
    save_data["level"] = $player.level             # レベル
    save_data["max_hp"] = $player.max_hp           # 最大HP
    save_data["attack"] = $player.attack           # 攻撃力
    save_data["defence"] = $player.defence         # 防御力
    save_data["heal_count"] = $player.heal_count   # 薬草の数
    save_data["exp"] = $player.exp                 # 経験値
    save_data["gold"] = $player.gold               # 所持金
  
    open("save_data.dat", 'w') do |io|
      JSON.dump(save_data, io)
    end
  end
  
  def load()
    $player = Player.new
    
    if File.exist?("save_data.dat") then
      save_data = open("save_data.dat") do |io|
        JSON.load(io)
      end
      
      $player.level = save_data["level"].to_i           # レベル
      $player.max_hp = save_data["max_hp"].to_i         # 最大HP
      $player.attack = save_data["attack"].to_i         # 攻撃力
      $player.defence = save_data["defence"].to_i       # 防御力
      $player.heal_count = save_data["heal_count"].to_i # 薬草の数
      $player.exp = save_data["exp"].to_i               # 経験値
      $player.gold = save_data["gold"].to_i             # 所持金
    end
    
  end
end