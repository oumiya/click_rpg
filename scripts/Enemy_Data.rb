require_relative 'Enemy.rb'

# 敵データ
# 属性について 0:無属性 1:火属性 2:氷属性 3:土属性 4:風属性 5:光属性 6:闇属性
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
      enemy.max_hp = 600
      enemy.attack = 400
      enemy.defence = 200
      enemy.attack_frequency = [60]
      enemy.ai = 0
      enemy.attack_speed = 6
      enemy.exp = 1
      enemy.gold = 10
      enemy.element = ""
    when 1
      enemy.id = 1
      enemy.image_file_name = "rat.png"
      enemy.name = "大ネズミ"
      enemy.description = "人間すら捕食する獰猛なネズミ"
      enemy.max_hp = 660
      enemy.attack = 430
      enemy.defence = 200
      enemy.attack_frequency = [60]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 1
      enemy.gold = 10
      enemy.element = ""
    when 2
      enemy.id = 2
      enemy.image_file_name = "slime.png"
      enemy.name = "スライム"
      enemy.description = "ぶよぶよとした粘体生物。獲物を包むようにして消化する"
      enemy.max_hp = 720
      enemy.attack = 460
      enemy.defence = 200
      enemy.attack_frequency = [30, 82]
      enemy.ai = 0
      enemy.attack_speed = 6
      enemy.exp = 1
      enemy.gold = 10
      enemy.element = "土"
    when 3
      enemy.id = 3
      enemy.image_file_name = "goblin.png"
      enemy.name = "ゴブリン"
      enemy.description = "洞窟に隠れ住む弱い種族。とはいえ殴られたらそれなりに痛い"
      enemy.max_hp = 780
      enemy.attack = 490
      enemy.defence = 200
      enemy.attack_frequency = [35, 64, 92]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 2
      enemy.gold = 10
      enemy.element = ""
    when 4
      enemy.id = 4
      enemy.image_file_name = "skeleton.png"
      enemy.name = "スケルトン"
      enemy.description = "はるか昔に死んだ人の骨に魔力が集まった結果、動くガイコツ戦士となった"
      enemy.max_hp = 840
      enemy.attack = 520
      enemy.defence = 200
      enemy.attack_frequency = [60,75]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 3
      enemy.gold = 10
      enemy.element = "闇"
    when 5
      enemy.id = 5
      enemy.image_file_name = "monkey.png"
      enemy.name = "ケイヴモンキー"
      enemy.description = "モンキーというにはデカすぎる！"
      enemy.max_hp = 900
      enemy.attack = 580
      enemy.defence = 200
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 5
      enemy.gold = 10
      enemy.element = "土"
    when 6
      enemy.id = 6
      enemy.image_file_name = "dragon.png"
      enemy.name = "ドラゴン"
      enemy.description = "洞窟の主であるドラゴン"
      enemy.max_hp = 5000
      enemy.attack = 700
      enemy.defence = 200
      enemy.attack_frequency = [35,43,51,59,67]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 10
      enemy.gold = 10
      enemy.element = "火"
    when 7
      enemy.id = 7
      enemy.image_file_name = "dog.png"
      enemy.name = "のらいぬ"
      enemy.description = "元は飼い犬だったという犬。怖いくらい攻撃速度が速い"
      enemy.max_hp = 1600
      enemy.attack = 980
      enemy.defence = 200
      enemy.attack_frequency = [30, 40]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 10
      enemy.gold = 15
      enemy.element = ""
    when 8
      enemy.id = 8
      enemy.image_file_name = "g_monkey.png"
      enemy.name = "グリーンモンキー"
      enemy.description = "ケイヴモンキーの色違い"
      enemy.max_hp = 1760
      enemy.attack = 1040
      enemy.defence = 200
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 10
      enemy.gold = 15
      enemy.element = "風"
    when 9
      enemy.id = 9
      enemy.image_file_name = "bear.png"
      enemy.name = "森のクマさん"
      enemy.description = "攻撃頻度がバリやばい！"
      enemy.max_hp = 1920
      enemy.attack = 1100
      enemy.defence = 200
      enemy.attack_frequency = [35,43,51,59,67]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 18
      enemy.gold = 20
      enemy.element = ""
    when 10
      enemy.id = 10
      enemy.image_file_name = "redcap.png"
      enemy.name = "レッドキャップ"
      enemy.description = "洞窟の主であるドラゴン"
      enemy.max_hp = 2080
      enemy.attack = 1160
      enemy.defence = 200
      enemy.attack_frequency = [35, 64, 92]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 10
      enemy.gold = 10
      enemy.element = "闇"
    when 11
      enemy.id = 11
      enemy.image_file_name = "bandit.png"
      enemy.name = "さんぞく"
      enemy.description = "お金をたくさん持っている"
      enemy.max_hp = 2240
      enemy.attack = 1220
      enemy.defence = 200
      enemy.attack_frequency = [35,43,51,59,67]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 20
      enemy.gold = 30
      enemy.element = ""
    when 12
      enemy.id = 12
      enemy.image_file_name = "torrent.png"
      enemy.name = "トレント"
      enemy.description = "この木の人、ちんこ立ってね？"
      enemy.max_hp = 2400
      enemy.attack = 1280
      enemy.defence = 200
      enemy.attack_frequency = [10, 45, 60, 72]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 20
      enemy.gold = 20
      enemy.element = "土"
    when 13
      enemy.id = 13
      enemy.image_file_name = "duroid.png"
      enemy.name = "森の隠者"
      enemy.description = "森に隠れ住んでいるが、その昔は凄いやばい人だったらしい。"
      enemy.max_hp = 10000
      enemy.attack = 1920
      enemy.defence = 200
      enemy.attack_frequency = [10, 45, 60, 72]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 50
      enemy.gold = 50
      enemy.element = "光"
    when 14
      enemy.id = 14
      enemy.image_file_name = "skelton_knight.png"
      enemy.name = "がいこつけんし"
      enemy.description = "ただのスケルトンではなく剣士らしい"
      enemy.max_hp = 1600
      enemy.attack = 2200
      enemy.defence = 200
      enemy.attack_frequency = [25, 45, 60, 70]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 25
      enemy.gold = 40
      enemy.element = "闇"
    when 15
      enemy.id = 15
      enemy.image_file_name = "ghost.png"
      enemy.name = "おばけ"
      enemy.description = "ふわふわ漂う悪霊。こんな顔をしているがすぐに人を呪い殺す。"
      enemy.max_hp = 3630
      enemy.attack = 2350
      enemy.defence = 200
      enemy.attack_frequency = [45, 23, 63, 89]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 23
      enemy.gold = 30
      enemy.element = "闇"
    when 16
      enemy.id = 16
      enemy.image_file_name = "zombie.png"
      enemy.name = "ゾンビ"
      enemy.description = "土葬された死体を蘇らせて作った死の奴隷。"
      enemy.max_hp = 3960
      enemy.attack = 2500
      enemy.defence = 200
      enemy.attack_frequency = [12,45, 55, 65, 75, 82]
      enemy.ai = 1
      enemy.attack_speed = 6
      enemy.exp = 30
      enemy.gold = 50
      enemy.element = "闇"
    when 17
      enemy.id = 17
      enemy.image_file_name = "vampire.png"
      enemy.name = "吸血鬼"
      enemy.description = "血ぃ吸うたろかぁ？"
      enemy.max_hp = 4290
      enemy.attack = 2650
      enemy.defence = 200
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 28
      enemy.gold = 50
      enemy.element = "闇"
    when 18
      enemy.id = 18
      enemy.image_file_name = "zombie_dog.png"
      enemy.name = "ゾンビ犬"
      enemy.description = "とにかく攻撃が速い！"
      enemy.max_hp = 4620
      enemy.attack = 2800
      enemy.defence = 200
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 16
      enemy.exp = 32
      enemy.gold = 40
      enemy.element = "闇"
    when 19
      enemy.id = 19
      enemy.image_file_name = "pumpkin.png"
      enemy.name = "ランタンおばけ"
      enemy.description = "お金持ちのモンスター。死出の旅路の案内人と言われている。"
      enemy.max_hp = 4950
      enemy.attack = 2950
      enemy.defence = 200
      enemy.attack_frequency = [20, 45, 50, 60]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 45
      enemy.gold = 100
      enemy.element = "闇"
    when 20
      enemy.id = 20
      enemy.image_file_name = "wight_king.png"
      enemy.name = "ワイトキング"
      enemy.description = "不死者の王！　めっちゃ強そう！"
      enemy.max_hp = 30000
      enemy.attack = 3360
      enemy.defence = 200
      enemy.attack_frequency = [10, 45, 60, 72]
      enemy.ai = 0
      enemy.attack_speed = 10
      enemy.exp = 100
      enemy.gold = 100
      enemy.element = "闇"
    when 21
      enemy.id = 21
      enemy.image_file_name = "giant.png"
      enemy.name = "きょじん"
      enemy.description = "意外にも漫才が得意だという"
      enemy.max_hp = 4600
      enemy.attack = 2980
      enemy.defence = 200
      enemy.attack_frequency = [30, 90]
      enemy.ai = 0
      enemy.attack_speed = 6
      enemy.exp = 50
      enemy.gold = 50
      enemy.element = ""
    when 22
      enemy.id = 22
      enemy.image_file_name = "fire_rock.png"
      enemy.name = "炎の岩"
      enemy.description = "燃え盛る岩、巨大な熱量と質量を持っている！"
      enemy.max_hp = 5060
      enemy.attack = 3190
      enemy.defence = 400
      enemy.attack_frequency = [15, 20, 30, 90]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 55
      enemy.gold = 60
      enemy.element = "土"
    when 23
      enemy.id = 23
      enemy.image_file_name = "blazeman.png"
      enemy.name = "炎の精霊"
      enemy.description = "炎が魔力によって意思を持った精霊。怒ると怖い"
      enemy.max_hp = 5520
      enemy.attack = 3400
      enemy.defence = 200
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 52
      enemy.gold = 80
      enemy.element = "火"
    when 24
      enemy.id = 24
      enemy.image_file_name = "rizard.png"
      enemy.name = "サラマンダー"
      enemy.description = "炎を食べて生きると言う巨大なトカゲ。もうほぼドラゴンでいいんじゃないですかね？"
      enemy.max_hp = 5980
      enemy.attack = 3610
      enemy.defence = 200
      enemy.attack_frequency = [20, 45, 85]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 55
      enemy.gold = 100
      enemy.element = "火"
    when 25
      enemy.id = 25
      enemy.image_file_name = "technopolice.png"
      enemy.name = "テクノポリス"
      enemy.description = "謎のモンスター。何気に手強い"
      enemy.max_hp = 6440
      enemy.attack = 3820
      enemy.defence = 200
      enemy.attack_frequency = [60]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 100
      enemy.gold = 50
      enemy.element = "風"
    when 26
      enemy.id = 26
      enemy.image_file_name = "red_bull.png"
      enemy.name = "燃える牛"
      enemy.description = "何故か燃えている牛。燃え尽きるまで待っていればウェルダンのステーキになるのかな？"
      enemy.max_hp = 6900
      enemy.attack = 4030
      enemy.defence = 200
      enemy.attack_frequency = [30,45,60,75,80]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 60
      enemy.gold = 30
      enemy.element = "火"
    when 27
      enemy.id = 27
      enemy.image_file_name = "red_dragon.png"
      enemy.name = "レッドドラゴン"
      enemy.description = "岩をも溶かすマグマを食べて生きているという。その吐く息は一つの街を簡単に焼きつくすという。"
      enemy.max_hp = 50000
      enemy.attack = 4480
      enemy.defence = 200
      enemy.attack_frequency = [10, 45, 60, 72]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 200
      enemy.gold = 500
      enemy.element = "火"
    when 28
      enemy.id = 28
      enemy.image_file_name = "snowman.png"
      enemy.name = "雪だるさん"
      enemy.description = "キモチ悪い！　何この生物！"
      enemy.max_hp = 6200
      enemy.attack = 4050
      enemy.defence = 200
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 120
      enemy.gold = 500
      enemy.element = "氷"
    when 29
      enemy.id = 29
      enemy.image_file_name = "iceman.png"
      enemy.name = "氷の精霊"
      enemy.description = "炎の精霊の色違いだろ！"
      enemy.max_hp = 6820
      enemy.attack = 4390
      enemy.defence = 200
      enemy.attack_frequency = [35, 64, 92]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 125
      enemy.gold = 300
      enemy.element = "氷"
    when 30
      enemy.id = 30
      enemy.image_file_name = "killer.png"
      enemy.name = "殺人鬼"
      enemy.description = "そんな格好で寒くないの？"
      enemy.max_hp = 7440
      enemy.attack = 4730
      enemy.defence = 200
      enemy.attack_frequency = [12, 24, 60]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 145
      enemy.gold = 600
      enemy.element = ""
    when 31
      enemy.id = 31
      enemy.image_file_name = "gadamanks.png"
      enemy.name = "ガダマンクス"
      enemy.description = "お前、色違いに大活躍だな！！"
      enemy.max_hp = 8060
      enemy.attack = 5070
      enemy.defence = 200
      enemy.attack_frequency = [45]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 155
      enemy.gold = 250
      enemy.element = ""
    when 32
      enemy.id = 32
      enemy.image_file_name = "manmoss.png"
      enemy.name = "マンモス"
      enemy.description = "象牙が高く売れるから！　象牙が高く売れるから！"
      enemy.max_hp = 8680
      enemy.attack = 5410
      enemy.defence = 200
      enemy.attack_frequency = [24, 36, 45, 60]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 180
      enemy.gold = 1000
      enemy.element = ""
    when 33
      enemy.id = 33
      enemy.image_file_name = "twick.png"
      enemy.name = "トゥイック"
      enemy.description = "お前……ペンギン……なのか？"
      enemy.max_hp = 9300
      enemy.attack = 5760
      enemy.defence = 200
      enemy.attack_frequency = [45]
      enemy.ai = 1
      enemy.attack_speed = 12
      enemy.exp = 200
      enemy.gold = 300
      enemy.element = "氷"
    when 34
      enemy.id = 34
      enemy.image_file_name = "icewoman.png"
      enemy.name = "氷の女王"
      enemy.description = "可愛い"
      enemy.max_hp = 70000
      enemy.attack = 6650
      enemy.defence = 200
      enemy.attack_frequency = [10, 45, 60, 72]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 800
      enemy.gold = 500
      enemy.element = "氷"
    when 35
      enemy.id = 35
      enemy.image_file_name = "daemon.png"
      enemy.name = "デーモン"
      enemy.description = "そのフォークでスパゲッティ食べるの？"
      enemy.max_hp = 7400
      enemy.attack = 4840
      enemy.defence = 200
      enemy.attack_frequency = [3, 45, 65, 72]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 200
      enemy.gold = 500
      enemy.element = "闇"
    when 36
      enemy.id = 36
      enemy.image_file_name = "vampire2.png"
      enemy.name = "ヴァンパイア"
      enemy.description = "吸血鬼のかっこいいバージョンのヤツ"
      enemy.max_hp = 8140
      enemy.attack = 5050
      enemy.defence = 200
      enemy.attack_frequency = [12, 24, 48]
      enemy.ai = 1
      enemy.attack_speed = 8
      enemy.exp = 300
      enemy.gold = 600
      enemy.element = "闇"
    when 37
      enemy.id = 37
      enemy.image_file_name = "grater_daemon.png"
      enemy.name = "グレーターデーモン"
      enemy.description = "何に座ってるんですか？"
      enemy.max_hp = 8880
      enemy.attack = 5260
      enemy.defence = 200
      enemy.attack_frequency = [60]
      enemy.ai = 0
      enemy.attack_speed = 16
      enemy.exp = 400
      enemy.gold = 800
      enemy.element = "闇"
    when 38
      enemy.id = 38
      enemy.image_file_name = "joker.png"
      enemy.name = "ジョーカー"
      enemy.description = "いやなんで武器がバールやねん！"
      enemy.max_hp = 9620
      enemy.attack = 5470
      enemy.defence = 200
      enemy.attack_frequency = [15]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 500
      enemy.gold = 1000
      enemy.element = "火"
    when 39
      enemy.id = 39
      enemy.image_file_name = "death.png"
      enemy.name = "死神"
      enemy.description = "死神だけに 420 なんやね！"
      enemy.max_hp = 10360
      enemy.attack = 5680
      enemy.defence = 200
      enemy.attack_frequency = [30,45,60,75,80]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 420
      enemy.gold = 420
      enemy.element = "風"
    when 40
      enemy.id = 40
      enemy.image_file_name = "iron_giant.png"
      enemy.name = "てつきょじん"
      enemy.description = "もうロボットやん！"
      enemy.max_hp = 12000
      enemy.attack = 6900
      enemy.defence = 200
      enemy.attack_frequency = [3, 45, 65, 72]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 1000
      enemy.gold = 1000
      enemy.element = "土"
    when 41
      enemy.id = 41
      enemy.image_file_name = "evil_king.png"
      enemy.name = "まおー"
      enemy.description = "そんでロリかい！"
      enemy.max_hp = 100000
      enemy.attack = 8750
      enemy.defence = 200
      enemy.attack_frequency = [10, 45, 60, 72]
      enemy.ai = 0
      enemy.attack_speed = 8
      enemy.exp = 2000
      enemy.gold = 10000
      enemy.element = "闇"
    when 42
      enemy.id = 42
      enemy.image_file_name = "lucifer.png"
      enemy.name = "ルシファー"
      enemy.description = "魔界の王子。すっげーキモいデザインだな"
      enemy.max_hp = 175500
      enemy.attack = 10000
      enemy.defence = 200
      enemy.attack_frequency = [10, 11, 12, 13]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 0
      enemy.gold = 0
      enemy.element = "光"
    when 43
      enemy.id = 43
      enemy.image_file_name = "satan.png"
      enemy.name = "サタン"
      enemy.description = "魔界の王様。狼みたいなライオンのようなそんな感じ"
      enemy.max_hp = 175500
      enemy.attack = 15000
      enemy.defence = 200
      enemy.attack_frequency = [10, 11, 12, 13]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 0
      enemy.gold = 0
      enemy.element = "火"
    when 44
      enemy.id = 44
      enemy.image_file_name = "leviathan.png"
      enemy.name = "レヴィアタン"
      enemy.description = "大蛇"
      enemy.max_hp = 175500
      enemy.attack = 15000
      enemy.defence = 200
      enemy.attack_frequency = [10, 11, 12, 13]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 0
      enemy.gold = 0
      enemy.element = "氷"
    when 45
      enemy.id = 45
      enemy.image_file_name = "belphegor.png"
      enemy.name = "ベルフェゴール"
      enemy.description = "ちょっと！　うんこ中なんですけど！！"
      enemy.max_hp = 175500
      enemy.attack = 15000
      enemy.defence = 200
      enemy.attack_frequency = [10, 11, 12, 13]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 0
      enemy.gold = 0
      enemy.element = "土"
    when 46
      enemy.id = 46
      enemy.image_file_name = "mammon.png"
      enemy.name = "マモン"
      enemy.description = "カァーッ！　カァーッ！"
      enemy.max_hp = 175500
      enemy.attack = 15000
      enemy.defence = 200
      enemy.attack_frequency = [10, 11, 12, 13]
      enemy.ai = 0
      enemy.attack_speed = 16
      enemy.exp = 0
      enemy.gold = 0
      enemy.element = "風"
    when 47
      enemy.id = 47
      enemy.image_file_name = "beelzebub.png"
      enemy.name = "ベルゼブブ"
      enemy.description = "蝿の王。王様らしい格好をしている。"
      enemy.max_hp = 175500
      enemy.attack = 15000
      enemy.defence = 200
      enemy.attack_frequency = [10, 11, 12, 13]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 0
      enemy.gold = 0
      enemy.element = "闇"
    when 48
      enemy.id = 48
      enemy.image_file_name = "asmodeus.png"
      enemy.name = "アスモデウス"
      enemy.description = "淫魔。やらしい格好をして玉を抱いている。"
      enemy.max_hp = 175500
      enemy.attack = 15000
      enemy.defence = 200
      enemy.attack_frequency = [10, 11, 12, 13]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 0
      enemy.gold = 0
      enemy.element = "闇"
    when 49
      enemy.id = 49
      enemy.image_file_name = "arrow.png"
      enemy.name = "アロウ"
      enemy.description = "ソロモンの塔の魔力に取り憑かれたアロウ。しかし属性は光のまま"
      enemy.max_hp = 175500
      enemy.attack = 15000
      enemy.defence = 200
      enemy.attack_frequency = [10, 11, 12, 13]
      enemy.ai = 0
      enemy.attack_speed = 12
      enemy.exp = 0
      enemy.gold = 0
      enemy.element = "光"
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
    
    # 敵が無属性の場合は属性をランダムに付与する
    if enemy.element == "" then
      lottery = rand(7)
      if lottery == 1 then
        enemy.element = "火"
      elsif lottery == 2 then
        enemy.element = "氷"
      elsif lottery == 3 then
        enemy.element = "土"
      elsif lottery == 4 then
        enemy.element = "風"
      elsif lottery == 5 then
        enemy.element = "光"
      elsif lottery == 6 then
        enemy.element = "闇"
      end
    end
    
    return enemy
  end
end