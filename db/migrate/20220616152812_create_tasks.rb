class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.date :start_date
      t.date :end_date
      t.boolean :all_day
      t.string :introduction

      t.timestamps
    end
  end
end
