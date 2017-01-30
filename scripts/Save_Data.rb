require 'json'

# セーブデータを管理するクラス
module Save_Data
  # ゲームデータをセーブする
  # 2016.07.01 現時点ではプレイヤー情報のみセーブ
  def save()
    save_data = Hash.new
    
    save_data["name"] = $player.name                     # 名前
    save_data["level"] = $player.level                   # レベル
    save_data["max_hp"] = $player.max_hp                 # 最大HP
    save_data["attack"] = $player.attack                 # 攻撃力
    save_data["defence"] = $player.defence               # 防御力
    save_data["heal_count"] = $player.heal_count         # 薬草の数
    save_data["exp"] = $player.exp                       # 経験値
    save_data["gold"] = $player.gold                     # 所持金
    save_data["hair"] = $player.hair                     # 髪型
    save_data["hair_color"] = $player.hair_color         # 髪の色
    save_data["skin_color"] = $player.skin_color         # 肌の色
    save_data["have_hair"] = $player.have_hair           # 持っている髪型
    save_data["equip_weapon"] = $player.equip_weapon     # 装備している武器
    save_data["weapon_bonus"] = $player.weapon_bonus     # 装備している武器の武器ボーナス
    save_data["weapon_element"] = $player.weapon_element # 装備している武器の武器属性
    save_data["have_weapon"] = $player.have_weapon       # 持っている武器
    save_data["equip_armor"] = $player.equip_armor       # 装備している防具
    save_data["armor_bonus"] = $player.armor_bonus       # 装備している防具の防具ボーナス
    save_data["armor_element"] = $player.armor_element   # 装備している防具の防具属性
    save_data["armor_heal"] = $player.armor_heal         # 装備している防具の自動回復 毎秒n%回復
    save_data["have_armor"] = $player.have_armor         # 持っている防具
    save_data["fever_point"] = $player.fever_point       # フィーバーポイント
    save_data["fever_frame"] = $player.fever_frame       # フィーバー持続時間
    save_data["fever_count"] = $player.fever_count       # フィーバー回数
    save_data["opening"] = $player.opening               # オープニングを見たかどうか
    save_data["cleared"] = $player.cleared               # クリア済みかどうか
    save_data["progress"] = $player.progress             # 進行度
    save_data["town"] = $player.town                     # 街
    save_data["income"] = $player.income                 # 1戦闘ごとの収入
    save_data["flag"] = $player.flag                     # ストーリーフラグ
  
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
      
      $player.name = save_data["name"].to_s                  # 名前
      $player.level = save_data["level"].to_i                # レベル
      $player.max_hp = save_data["max_hp"].to_i              # 最大HP
      $player.attack = save_data["attack"].to_i              # 攻撃力
      $player.defence = save_data["defence"].to_i            # 防御力
      $player.heal_count = save_data["heal_count"].to_i      # 薬草の数
      $player.exp = save_data["exp"].to_i                    # 経験値
      $player.gold = save_data["gold"].to_i                  # 所持金
      $player.hair = save_data["hair"]                       # 髪型
      $player.hair_color = save_data["hair_color"]           # 髪の色
      $player.skin_color = save_data["skin_color"]           # 肌の色
      $player.have_hair = save_data["have_hair"]             # 持っている髪型
      $player.equip_weapon = save_data["equip_weapon"]       # 装備している武器
      $player.weapon_bonus = save_data["weapon_bonus"]       # 装備している武器の武器ボーナス
      $player.weapon_element = save_data["weapon_element"]   # 装備している武器の武器属性
      $player.have_weapon = save_data["have_weapon"]         # 持っている武器
      $player.equip_armor = save_data["equip_armor"]         # 装備している防具
      $player.armor_bonus = save_data["armor_bonus"]         # 装備している防具の防具ボーナス
      $player.armor_element = save_data["armor_element"]     # 装備している防具の防具属性
      $player.armor_heal = save_data["armor_heal"]           # 装備している防具の自動回復 毎秒n%回復
      $player.have_armor= save_data["have_armor"]            # 持っている防具
      $player.fever_point = save_data["fever_point"]         # フィーバーポイント
      $player.fever_frame = save_data["fever_frame"]         # フィーバー持続時間
      $player.fever_count = save_data["fever_count"]         # フィーバー回数
      $player.opening = save_data["opening"]                 # オープニングを見たかどうか
      $player.cleared = save_data["cleared"]                 # クリア済みかどうか
      $player.progress = save_data["progress"]               # 進行度
      $player.town = save_data["town"]                       # 街
      $player.income = save_data["income"]                   # 1戦闘ごとの収入
      $player.flag = save_data["flag"]                       # ストーリーフラグ
    end
    
  end
end