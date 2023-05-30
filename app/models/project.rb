class Project < ApplicationRecord
    validates :title, presence: true
    validates :due_date, presence: true
  
    # 関連付けやメソッドの定義など、プロジェクトに関連する追加のコードを記述することもできます
end