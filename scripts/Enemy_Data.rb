require_relative 'Enemy.rb'

# 敵データ
class Enemy_Data
  # 敵データを取得
  def get_enemy(id)
    enemy = Enemy.new
    case id
    when 0
      enemy.id = 0
      enemy.image_file_name = "bat.png"
      enemy.name = "コウモリ"
      enemy.description = "巨大な吸血コウモリ"
      enemy.max_hp = 520
      enemy.attack = 10
      enemy.defence = 35
      enemy.attack_frequency = [60]
      enemy.ai = 0
      enemy.attack_speed = 4
      enemy.exp = 1
      enemy.gold = 10
    when 1
      enemy.id = 1
      enemy.image_file_name = "rat.png"
      enemy.name = "大ネズミ"
      enemy.description = "人間すら捕食する獰猛なネズミ"
      enemy.max_hp = 500
      enemy.attack = 11
      enemy.defence = 15
      enemy.attack_frequency = [60]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 1
      enemy.gold = 10
    when 2
      enemy.id = 2
      enemy.image_file_name = "slime.png"
      enemy.name = "スライム"
      enemy.description = "ぶよぶよとした粘体生物。獲物を包むようにして消化する"
      enemy.max_hp = 600
      enemy.attack = 9
      enemy.defence = 10
      enemy.attack_frequency = [30, 82]
      enemy.ai = 0
      enemy.attack_speed = 6
      enemy.exp = 1
      enemy.gold = 10
    when 3
      enemy.id = 3
      enemy.image_file_name = "goblin.png"
      enemy.name = "ゴブリン"
      enemy.description = "洞窟に隠れ住む弱い種族。とはいえ殴られたらそれなりに痛い"
      enemy.max_hp = 600
      enemy.attack = 13
      enemy.defence = 20
      enemy.attack_frequency = [35, 64, 92]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 2
      enemy.gold = 10
    when 4
      enemy.id = 4
      enemy.image_file_name = "skeleton.png"
      enemy.name = "スケルトン"
      enemy.description = "はるか昔に死んだ人の骨に魔力が集まった結果、動くガイコツ戦士となった"
      enemy.max_hp = 550
      enemy.attack = 15
      enemy.defence = 25
      enemy.attack_frequency = [60,75]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 3
      enemy.gold = 10
    when 5
      enemy.id = 5
      enemy.image_file_name = "monkey.png"
      enemy.name = "ケイヴモンキー"
      enemy.description = "モンキーというにはデカすぎる！"
      enemy.max_hp = 800
      enemy.attack = 15
      enemy.defence = 10
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 5
      enemy.gold = 10
    when 6
      enemy.id = 6
      enemy.image_file_name = "dragon.png"
      enemy.name = "ドラゴン"
      enemy.description = "洞窟の主であるドラゴン"
      enemy.max_hp = 1800
      enemy.attack = 10
      enemy.defence = 10
      enemy.attack_frequency = [60,75,90]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 10
      enemy.gold = 10

    end

    # 現在HPに最大HPを代入
    enemy.hp = enemy.max_hp
    # 敵画像を読み込み
    enemy.image = Image.load("image/enemy/" + enemy.image_file_name)
    # 敵死亡時エフェクトを作成
    enemy.create_die_effect()
    # 敵の当たり判定を作成
    enemy.calc_hitbox()
    
    return enemy
  end
end