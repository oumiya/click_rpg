# 1�E�F�[�u�̌��ʂ��i�[����
class Wave_Result
  # �퓬��
  attr_accessor :battle_count
  # ���v�o���l
  attr_accessor :exp
  # ���v���z
  attr_accessor :gold
  # �E�F�[�u�̌��� true ���� false �s�k
  attr_accessor :result
  
  def initialize()
    @battle_count = 0
    @exp = 0
    @gold = 0
    @result = false
  end
end