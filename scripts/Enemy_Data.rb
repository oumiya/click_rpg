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
      enemy.name = "こうもり"
      enemy.description = "巨大な吸血こうもり"
      enemy.max_hp = 100
      enemy.hp = enemy.max_hp
      enemy.attack = 10
      enemy.defence = 10
      enemy.attack_frequency = 60
      enemy.attack_speed = 4
      enemy.sx = 81
      enemy.sy = 83
      enemy.ex = 388
      enemy.ey = 219
      enemy.exp = 10
      enemy.gold = 10
    when 1
      enemy.id = 1
      enemy.image_file_name = "rat.png"
      enemy.name = "大ネズミ"
      enemy.description = "人間すら捕食する獰猛なネズミ"
      enemy.max_hp = 100
      enemy.hp = enemy.max_hp
      enemy.attack = 10
      enemy.defence = 10
      enemy.attack_frequency = 60
      enemy.attack_speed = 8
      enemy.sx = 156
      enemy.sy = 74
      enemy.ex = 318
      enemy.ey = 216
      enemy.exp = 10
      enemy.gold = 10
    when 2
      enemy.id = 2
      enemy.image_file_name = "slime.png"
      enemy.name = "スライム"
      enemy.description = "ぶよぶよとした粘体生物。獲物を包むようにして消化する"
      enemy.max_hp = 100
      enemy.hp = enemy.max_hp
      enemy.attack = 10
      enemy.defence = 10
      enemy.attack_frequency = 60
      enemy.attack_speed = 8
      enemy.sx = 154
      enemy.sy = 67
      enemy.ex = 318
      enemy.ey = 219
      enemy.exp = 10
      enemy.gold = 10
    when 3
      enemy.id = 3
      enemy.image_file_name = "goblin.png"
      enemy.name = "ゴブリン"
      enemy.description = "洞窟に隠れ住む弱い種族。とはいえ殴られたらそれなりに痛い"
      enemy.max_hp = 100
      enemy.hp = enemy.max_hp
      enemy.attack = 10
      enemy.defence = 10
      enemy.attack_frequency = 60
      enemy.attack_speed = 8
      enemy.sx = 127
      enemy.sy = 37
      enemy.ex = 291
      enemy.ey = 272
      enemy.exp = 10
      enemy.gold = 10
    when 4
      enemy.id = 4
      enemy.image_file_name = "skeleton.png"
      enemy.name = "スケルトン"
      enemy.description = "はるか昔に死んだ人の骨に魔力が集まった結果、動くガイコツ戦士となった"
      enemy.max_hp = 100
      enemy.hp = enemy.max_hp
      enemy.attack = 10
      enemy.defence = 10
      enemy.attack_frequency = 60
      enemy.attack_speed = 8
      enemy.sx = 131
      enemy.sy = 6
      enemy.ex = 353
      enemy.ey = 290
      enemy.exp = 10
      enemy.gold = 10
    when 5
      enemy.id = 5
      enemy.image_file_name = "monkey.png"
      enemy.name = "ケイヴモンキー"
      enemy.description = "モンキーというにはデカすぎる！"
      enemy.max_hp = 100
      enemy.hp = enemy.max_hp
      enemy.attack = 10
      enemy.defence = 10
      enemy.attack_frequency = 60
      enemy.attack_speed = 8
      enemy.sx = 95
      enemy.sy = 9
      enemy.ex = 364
      enemy.ey = 294
      enemy.exp = 10
      enemy.gold = 10
    when 6
      enemy.id = 6
      enemy.image_file_name = "dragon.png"
      enemy.name = "ドラゴン"
      enemy.description = "洞窟の主であるドラゴン"
      enemy.max_hp = 100
      enemy.hp = enemy.max_hp
      enemy.attack = 10
      enemy.defence = 10
      enemy.attack_frequency = 60
      enemy.attack_speed = 8
      enemy.sx = 110
      enemy.sy = 4
      enemy.ex = 368
      enemy.ey = 284
      enemy.exp = 10
      enemy.gold = 10
    end
    
    enemy.image = Image.load("image/enemy/" + enemy.image_file_name)
    enemy.create_die_effect()
    
    return enemy
  end
end