require 'json'

# �Z�[�u�f�[�^���Ǘ�����N���X
module Save_Data
  # �Q�[���f�[�^���Z�[�u����
  # 2016.07.01 �����_�ł̓v���C���[���̂݃Z�[�u
  def save()
    save_data = Hash.new
    
    save_data["level"] = $player.level               # ���x��
    save_data["max_hp"] = $player.max_hp             # �ő�HP
    save_data["attack"] = $player.attack             # �U����
    save_data["defence"] = $player.defence           # �h���
    save_data["heal_count"] = $player.heal_count     # �򑐂̐�
    save_data["exp"] = $player.exp                   # �o���l
    save_data["gold"] = $player.gold                 # ������
    save_data["hair"] = $player.hair                 # ���^
    save_data["have_hair"] = $player.have_hair       # �����Ă��锯�^
    save_data["equip_weapon"] = $player.equip_weapon # �������Ă��镐��
    save_data["have_weapon"] = $player.have_weapon   # �����Ă��镐��
    save_data["equip_armor"] = $player.equip_armor   # �������Ă���h��
    save_data["have_armor"] = $player.have_armor     # �����Ă���h��
  
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
      
      $player.level = save_data["level"].to_i           # ���x��
      $player.max_hp = save_data["max_hp"].to_i         # �ő�HP
      $player.attack = save_data["attack"].to_i         # �U����
      $player.defence = save_data["defence"].to_i       # �h���
      $player.heal_count = save_data["heal_count"].to_i # �򑐂̐�
      $player.exp = save_data["exp"].to_i               # �o���l
      $player.gold = save_data["gold"].to_i             # ������
      $player.hair = save_data["hair"]                  # ���^
      $player.have_hair = save_data["have_hair"]        # �����Ă��锯�^
      
    end
    
  end
end