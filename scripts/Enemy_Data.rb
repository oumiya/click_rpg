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
      enemy.max_hp = 3000
      enemy.attack = 18
      enemy.defence = 10
      enemy.attack_frequency = [35,43,51,59,67]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 10
      enemy.gold = 10
    when 7
      enemy.id = 7
      enemy.image_file_name = "dog.png"
      enemy.name = "のらいぬ"
      enemy.description = "元は飼い犬だったという犬。怖いくらい攻撃速度が速い"
      enemy.max_hp = 1140
      enemy.attack = 22
      enemy.defence = 20
      enemy.attack_frequency = [30, 40]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 10
      enemy.gold = 15
    when 8
      enemy.id = 8
      enemy.image_file_name = "g_monkey.png"
      enemy.name = "グリーンモンキー"
      enemy.description = "ケイヴモンキーの色違い"
      enemy.max_hp = 1500
      enemy.attack = 25
      enemy.defence = 22
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 10
      enemy.gold = 15
    when 9
      enemy.id = 9
      enemy.image_file_name = "bear.png"
      enemy.name = "森のクマさん"
      enemy.description = "攻撃頻度がバリやばい！"
      enemy.max_hp = 1800
      enemy.attack = 28
      enemy.defence = 25
      enemy.attack_frequency = [35,43,51,59,67]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 18
      enemy.gold = 20
    when 10
      enemy.id = 10
      enemy.image_file_name = "redcap.png"
      enemy.name = "レッドキャップ"
      enemy.description = "洞窟の主であるドラゴン"
      enemy.max_hp = 1200
      enemy.attack = 23
      enemy.defence = 20
      enemy.attack_frequency = [35, 64, 92]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 10
      enemy.gold = 10
    when 11
      enemy.id = 11
      enemy.image_file_name = "bandit.png"
      enemy.name = "さんぞく"
      enemy.description = "お金をたくさん持っている"
      enemy.max_hp = 3000
      enemy.attack = 30
      enemy.defence = 28
      enemy.attack_frequency = [35,43,51,59,67]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 20
      enemy.gold = 30
    when 12
      enemy.id = 12
      enemy.image_file_name = "torrent.png"
      enemy.name = "トレント"
      enemy.description = "この木の人、ちんこ立ってね？"
      enemy.max_hp = 3000
      enemy.attack = 32
      enemy.defence = 18
      enemy.attack_frequency = [10, 45, 60, 72]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 20
      enemy.gold = 20
    when 13
      enemy.id = 13
      enemy.image_file_name = "duroid.png"
      enemy.name = "森の隠者"
      enemy.description = "森に隠れ住んでいるが、その昔は凄いやばい人だったらしい。"
      enemy.max_hp = 10000
      enemy.attack = 40
      enemy.defence = 25
      enemy.attack_frequency = [10, 45, 60, 72]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 50
      enemy.gold = 50

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