require 'dxruby'

# ゲーム中の全てのシーンのスーパークラス
class Scene_Base
  
  # ループ前処理 例えばインスタンス変数の初期化などを行う
  def start()
  end
  
  # 画面の描画をする ※ このメソッドに描画処理以外の処理を入れてはならない
  def draw()
  end
  
  # フレーム更新処理
  def update()
  end
  
  # ループ後処理
  def terminate()
  end
  
  # 次のシーンに遷移
  # 遷移しない場合は nil を返す
  def get_next_scene()
    return nil
  end

end
