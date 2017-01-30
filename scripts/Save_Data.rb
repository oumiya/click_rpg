require 'json'

# �Z�[�u�f�[�^���Ǘ�����N���X
module Save_Data
  # �Q�[���f�[�^���Z�[�u����
  # 2016.07.01 �����_�ł̓v���C���[���̂݃Z�[�u
  def save()
    save_data = Hash.new
    
    save_data["name"] = $player.name                     # ���O
    save_data["level"] = $player.level                   # ���x��
    save_data["max_hp"] = $player.max_hp                 # �ő�HP
    save_data["attack"] = $player.attack                 # �U����
    save_data["defence"] = $player.defence               # �h���
    save_data["heal_count"] = $player.heal_count         # �򑐂̐�
    save_data["exp"] = $player.exp                       # �o���l
    save_data["gold"] = $player.gold                     # ������
    save_data["hair"] = $player.hair                     # ���^
    save_data["hair_color"] = $player.hair_color         # ���̐F
    save_data["skin_color"] = $player.skin_color         # ���̐F
    save_data["have_hair"] = $player.have_hair           # �����Ă��锯�^
    save_data["equip_weapon"] = $player.equip_weapon     # �������Ă��镐��
    save_data["weapon_bonus"] = $player.weapon_bonus     # �������Ă��镐��̕���{�[�i�X
    save_data["weapon_element"] = $player.weapon_element # �������Ă��镐��̕��푮��
    save_data["have_weapon"] = $player.have_weapon       # �����Ă��镐��
    save_data["equip_armor"] = $player.equip_armor       # �������Ă���h��
    save_data["armor_bonus"] = $player.armor_bonus       # �������Ă���h��̖h��{�[�i�X
    save_data["armor_element"] = $player.armor_element   # �������Ă���h��̖h���
    save_data["armor_heal"] = $player.armor_heal         # �������Ă���h��̎����� ���bn%��
    save_data["have_armor"] = $player.have_armor         # �����Ă���h��
    save_data["fever_point"] = $player.fever_point       # �t�B�[�o�[�|�C���g
    save_data["fever_frame"] = $player.fever_frame       # �t�B�[�o�[��������
    save_data["fever_count"] = $player.fever_count       # �t�B�[�o�[��
    save_data["opening"] = $player.opening               # �I�[�v�j���O���������ǂ���
    save_data["cleared"] = $player.cleared               # �N���A�ς݂��ǂ���
    save_data["progress"] = $player.progress             # �i�s�x
    save_data["town"] = $player.town                     # �X
    save_data["income"] = $player.income                 # 1�퓬���Ƃ̎���
    save_data["flag"] = $player.flag                     # �X�g�[���[�t���O
  
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
      
      $player.name = save_data["name"].to_s                  # ���O
      $player.level = save_data["level"].to_i                # ���x��
      $player.max_hp = save_data["max_hp"].to_i              # �ő�HP
      $player.attack = save_data["attack"].to_i              # �U����
      $player.defence = save_data["defence"].to_i            # �h���
      $player.heal_count = save_data["heal_count"].to_i      # �򑐂̐�
      $player.exp = save_data["exp"].to_i                    # �o���l
      $player.gold = save_data["gold"].to_i                  # ������
      $player.hair = save_data["hair"]                       # ���^
      $player.hair_color = save_data["hair_color"]           # ���̐F
      $player.skin_color = save_data["skin_color"]           # ���̐F
      $player.have_hair = save_data["have_hair"]             # �����Ă��锯�^
      $player.equip_weapon = save_data["equip_weapon"]       # �������Ă��镐��
      $player.weapon_bonus = save_data["weapon_bonus"]       # �������Ă��镐��̕���{�[�i�X
      $player.weapon_element = save_data["weapon_element"]   # �������Ă��镐��̕��푮��
      $player.have_weapon = save_data["have_weapon"]         # �����Ă��镐��
      $player.equip_armor = save_data["equip_armor"]         # �������Ă���h��
      $player.armor_bonus = save_data["armor_bonus"]         # �������Ă���h��̖h��{�[�i�X
      $player.armor_element = save_data["armor_element"]     # �������Ă���h��̖h���
      $player.armor_heal = save_data["armor_heal"]           # �������Ă���h��̎����� ���bn%��
      $player.have_armor= save_data["have_armor"]            # �����Ă���h��
      $player.fever_point = save_data["fever_point"]         # �t�B�[�o�[�|�C���g
      $player.fever_frame = save_data["fever_frame"]         # �t�B�[�o�[��������
      $player.fever_count = save_data["fever_count"]         # �t�B�[�o�[��
      $player.opening = save_data["opening"]                 # �I�[�v�j���O���������ǂ���
      $player.cleared = save_data["cleared"]                 # �N���A�ς݂��ǂ���
      $player.progress = save_data["progress"]               # �i�s�x
      $player.town = save_data["town"]                       # �X
      $player.income = save_data["income"]                   # 1�퓬���Ƃ̎���
      $player.flag = save_data["flag"]                       # �X�g�[���[�t���O
    end
    
  end
end