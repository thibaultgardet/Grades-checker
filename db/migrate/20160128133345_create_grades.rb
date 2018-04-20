class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.belongs_to :exam, index: true, foreign_key: true
      t.integer :score

      t.timestamps null: false
    end
  end
end
