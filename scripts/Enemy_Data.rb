require_relative 'Enemy.rb'

# 敵データ
class Enemy_Data
  # 敵データを作成
  def get_enemy(id)
    enemy = Enemy.new
    case id
    when 0
      enemy.id = 0
      enemy.image_file_name = "bat.png"
      enemy.name = "コウモリ"
      enemy.description = "巨大な吸血コウモリ"
      enemy.max_hp = 60
      enemy.attack = 40
      enemy.defence = 20
      enemy.attack_frequency = [60]
      enemy.ai = 0
      enemy.attack_speed = 6
      enemy.exp = 1
      enemy.gold = 10
    when 1
      enemy.id = 1
      enemy.image_file_name = "rat.png"
      enemy.name = "大ネズミ"
      enemy.description = "人間すら捕食する獰猛なネズミ"
      enemy.max_hp = 66
      enemy.attack = 43
      enemy.defence = 20
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
      enemy.max_hp = 72
      enemy.attack = 46
      enemy.defence = 20
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
      enemy.max_hp = 78
      enemy.attack = 49
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
      enemy.max_hp = 84
      enemy.attack = 52
      enemy.defence = 20
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
      enemy.max_hp = 90
      enemy.attack = 58
      enemy.defence = 20
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
      enemy.max_hp = 360
      enemy.attack = 70
      enemy.defence = 20
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
      enemy.max_hp = 160
      enemy.attack = 98
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
      enemy.max_hp = 176
      enemy.attack = 104
      enemy.defence = 20
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
      enemy.max_hp = 192
      enemy.attack = 110
      enemy.defence = 20
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
      enemy.max_hp = 208
      enemy.attack = 116
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
      enemy.max_hp = 224
      enemy.attack = 122
      enemy.defence = 20
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
      enemy.max_hp = 240
      enemy.attack = 128
      enemy.defence = 20
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
      enemy.max_hp = 960
      enemy.attack = 192
      enemy.defence = 20
      enemy.attack_frequency = [10, 45, 60, 72]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 50
      enemy.gold = 50
    when 14
      enemy.id = 14
      enemy.image_file_name = "skelton_knight.png"
      enemy.name = "がいこつけんし"
      enemy.description = "ただのスケルトンではなく剣士らしい"
      enemy.max_hp = 160
      enemy.attack = 220
      enemy.defence = 20
      enemy.attack_frequency = [25, 45, 60, 70]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 25
      enemy.gold = 40
    when 15
      enemy.id = 15
      enemy.image_file_name = "ghost.png"
      enemy.name = "おばけ"
      enemy.description = "ふわふわ漂う悪霊。こんな顔をしているがすぐに人を呪い殺す。"
      enemy.max_hp = 363
      enemy.attack = 235
      enemy.defence = 20
      enemy.attack_frequency = [45, 23, 63, 89]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 23
      enemy.gold = 30
    when 16
      enemy.id = 16
      enemy.image_file_name = "zombie.png"
      enemy.name = "ゾンビ"
      enemy.description = "土葬された死体を蘇らせて作った死の奴隷。"
      enemy.max_hp = 396
      enemy.attack = 250
      enemy.defence = 20
      enemy.attack_frequency = [12,45, 55, 65, 75, 82]
      enemy.ai = 1
      enemy.attack_speed = 6
      enemy.exp = 30
      enemy.gold = 50
    when 17
      enemy.id = 17
      enemy.image_file_name = "vampire.png"
      enemy.name = "吸血鬼"
      enemy.description = "血ぃ吸うたろかぁ？"
      enemy.max_hp = 429
      enemy.attack = 265
      enemy.defence = 20
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 28
      enemy.gold = 50
    when 18
      enemy.id = 18
      enemy.image_file_name = "zombie_dog.png"
      enemy.name = "ゾンビ犬"
      enemy.description = "とにかく攻撃が速い！"
      enemy.max_hp = 462
      enemy.attack = 280
      enemy.defence = 20
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 16
      enemy.exp = 32
      enemy.gold = 40
    when 19
      enemy.id = 19
      enemy.image_file_name = "pumpkin.png"
      enemy.name = "ランタンおばけ"
      enemy.description = "お金持ちのモンスター。死出の旅路の案内人と言われている。"
      enemy.max_hp = 495
      enemy.attack = 295
      enemy.defence = 20
      enemy.attack_frequency = [20, 45, 50, 60]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 45
      enemy.gold = 100
    when 20
      enemy.id = 20
      enemy.image_file_name = "wight_king.png"
      enemy.name = "ワイトキング"
      enemy.description = "不死者の王！　めっちゃ強そう！"
      enemy.max_hp = 2000
      enemy.attack = 336
      enemy.defence = 20
      enemy.attack_frequency = [10, 45, 60, 72]
      enemy.ai = 0
      enemy.attack_speed = 10
      enemy.exp = 100
      enemy.gold = 100
    when 21
      enemy.id = 21
      enemy.image_file_name = "giant.png"
      enemy.name = "きょじん"
      enemy.description = "意外にも漫才が得意だという"
      enemy.max_hp = 460
      enemy.attack = 298
      enemy.defence = 20
      enemy.attack_frequency = [30, 90]
      enemy.ai = 0
      enemy.attack_speed = 6
      enemy.exp = 50
      enemy.gold = 50
    when 22
      enemy.id = 22
      enemy.image_file_name = "fire_rock.png"
      enemy.name = "炎の岩"
      enemy.description = "燃え盛る岩、巨大な熱量と質量を持っている！"
      enemy.max_hp = 506
      enemy.attack = 319
      enemy.defence = 40
      enemy.attack_frequency = [15, 20, 30, 90]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 55
      enemy.gold = 60
    when 23
      enemy.id = 23
      enemy.image_file_name = "blazeman.png"
      enemy.name = "炎の精霊"
      enemy.description = "炎が魔力によって意思を持った精霊。怒ると怖い"
      enemy.max_hp = 552
      enemy.attack = 340
      enemy.defence = 20
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 52
      enemy.gold = 80
    when 24
      enemy.id = 24
      enemy.image_file_name = "rizard.png"
      enemy.name = "サラマンダー"
      enemy.description = "炎を食べて生きると言う巨大なトカゲ。もうほぼドラゴンでいいんじゃないですかね？"
      enemy.max_hp = 598
      enemy.attack = 361
      enemy.defence = 20
      enemy.attack_frequency = [20, 45, 85]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 55
      enemy.gold = 100
    when 25
      enemy.id = 25
      enemy.image_file_name = "technopolice.png"
      enemy.name = "テクノポリス"
      enemy.description = "謎のモンスター。何気に手強い"
      enemy.max_hp = 644
      enemy.attack = 382
      enemy.defence = 20
      enemy.attack_frequency = [60]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 100
      enemy.gold = 50
    when 26
      enemy.id = 26
      enemy.image_file_name = "red_bull.png"
      enemy.name = "燃える牛"
      enemy.description = "何故か燃えている牛。燃え尽きるまで待っていればウェルダンのステーキになるのかな？"
      enemy.max_hp = 690
      enemy.attack = 403
      enemy.defence = 20
      enemy.attack_frequency = [30,45,60,75,80]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 60
      enemy.gold = 30
    when 27
      enemy.id = 27
      enemy.image_file_name = "red_dragon.png"
      enemy.name = "レッドドラゴン"
      enemy.description = "岩をも溶かすマグマを食べて生きているという。その吐く息は一つの街を簡単に焼きつくすという。"
      enemy.max_hp = 3000
      enemy.attack = 448
      enemy.defence = 20
      enemy.attack_frequency = [10, 45, 60, 72]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 200
      enemy.gold = 500
    when 28
      enemy.id = 28
      enemy.image_file_name = "snowman.png"
      enemy.name = "雪だるさん"
      enemy.description = "キモチ悪い！　何この生物！"
      enemy.max_hp = 620
      enemy.attack = 405
      enemy.defence = 20
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 120
      enemy.gold = 500
    when 29
      enemy.id = 29
      enemy.image_file_name = "iceman.png"
      enemy.name = "氷の精霊"
      enemy.description = "炎の精霊の色違いだろ！"
      enemy.max_hp = 682
      enemy.attack = 439
      enemy.defence = 20
      enemy.attack_frequency = [35, 64, 92]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 125
      enemy.gold = 300
    when 30
      enemy.id = 30
      enemy.image_file_name = "killer.png"
      enemy.name = "殺人鬼"
      enemy.description = "そんな格好で寒くないの？"
      enemy.max_hp = 744
      enemy.attack = 473
      enemy.defence = 20
      enemy.attack_frequency = [12, 24, 60]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 145
      enemy.gold = 600
    when 31
      enemy.id = 31
      enemy.image_file_name = "gadamanks.png"
      enemy.name = "ガダマンクス"
      enemy.description = "お前、色違いに大活躍だな！！"
      enemy.max_hp = 806
      enemy.attack = 507
      enemy.defence = 20
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 155
      enemy.gold = 250
    when 32
      enemy.id = 32
      enemy.image_file_name = "manmoss.png"
      enemy.name = "マンモス"
      enemy.description = "象牙が高く売れるから！　象牙が高く売れるから！"
      enemy.max_hp = 868
      enemy.attack = 541
      enemy.defence = 20
      enemy.attack_frequency = [24, 36, 45, 60]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 180
      enemy.gold = 1000
    when 33
      enemy.id = 33
      enemy.image_file_name = "twick.png"
      enemy.name = "トゥイック"
      enemy.description = "お前……ペンギン……なのか？"
      enemy.max_hp = 930
      enemy.attack = 576
      enemy.defence = 20
      enemy.attack_frequency = [45]
      enemy.ai = 1
      enemy.attack_speed = 12
      enemy.exp = 200
      enemy.gold = 300
    when 34
      enemy.id = 34
      enemy.image_file_name = "icewoman.png"
      enemy.name = "氷の女王"
      enemy.description = "可愛い"
      enemy.max_hp = 4000
      enemy.attack = 665
      enemy.defence = 20
      enemy.attack_frequency = [10, 45, 60, 72]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 800
      enemy.gold = 500
    when 35
      enemy.id = 35
      enemy.image_file_name = "daemon.png"
      enemy.name = "デーモン"
      enemy.description = "そのフォークでスパゲッティ食べるの？"
      enemy.max_hp = 740
      enemy.attack = 484
      enemy.defence = 20
      enemy.attack_frequency = [3, 45, 65, 72]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 200
      enemy.gold = 500
    when 36
      enemy.id = 36
      enemy.image_file_name = "vampire2.png"
      enemy.name = "ヴァンパイア"
      enemy.description = "吸血鬼のかっこいいバージョンのヤツ"
      enemy.max_hp = 814
      enemy.attack = 505
      enemy.defence = 20
      enemy.attack_frequency = [12, 24, 48]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 300
      enemy.gold = 600
    when 37
      enemy.id = 37
      enemy.image_file_name = "grater_daemon.png"
      enemy.name = "グレーターデーモン"
      enemy.description = "何に座ってるんですか？"
      enemy.max_hp = 888
      enemy.attack = 526
      enemy.defence = 20
      enemy.attack_frequency = [60]
      enemy.ai = 0
      enemy.attack_speed = 16
      enemy.exp = 400
      enemy.gold = 800
    when 38
      enemy.id = 38
      enemy.image_file_name = "joker.png"
      enemy.name = "ジョーカー"
      enemy.description = "いやなんで武器がバールやねん！"
      enemy.max_hp = 962
      enemy.attack = 547
      enemy.defence = 20
      enemy.attack_frequency = [15]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 500
      enemy.gold = 1000
    when 39
      enemy.id = 39
      enemy.image_file_name = "death.png"
      enemy.name = "死神"
      enemy.description = "死神だけに 420 なんやね！"
      enemy.max_hp = 1036
      enemy.attack = 568
      enemy.defence = 20
      enemy.attack_frequency = [30,45,60,75,80]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 420
      enemy.gold = 420
    when 40
      enemy.id = 40
      enemy.image_file_name = "iron_giant.png"
      enemy.name = "てつきょじん"
      enemy.description = "もうロボットやん！"
      enemy.max_hp = 1200
      enemy.attack = 690
      enemy.defence = 20
      enemy.attack_frequency = [3, 45, 65, 72]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 1000
      enemy.gold = 1000
    when 41
      enemy.id = 41
      enemy.image_file_name = "evil_king.png"
      enemy.name = "まおー"
      enemy.description = "そんでロリかい！"
      enemy.max_hp = 5200
      enemy.attack = 875
      enemy.defence = 20
      enemy.attack_frequency = [10, 45, 60, 72]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 2000
      enemy.gold = 10000
    else
      puts id
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