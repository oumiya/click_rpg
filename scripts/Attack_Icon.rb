# �A�^�b�N�A�C�R��
class Attack_Icon
  attr_accessor :x       # �A�^�b�N�A�C�R���̍���X���W
  attr_accessor :y       # �A�^�b�N�A�C�R���̍���Y���W
  attr_accessor :visible  # �\����� true or false
  
  def initialize()
    @x = 670
    @y = 398
    @visible = false
  end
  
  # �A�^�b�N�A�C�R�����\���ɂ��ď����ʒu�ɖ߂�
  def die()
    @x = 670
    @y = 398
    @visible = false
  end
end