class CreateCheckers < ActiveRecord::Migration
  def change
    create_table :checkers do |t|
      t.integer :id_user
      t.timestamp :initial_date
      t.timestamp :last_date
      t.date :date_day
      t.integer :work_hours
      t.string :extra

      t.timestamps null: false
    end
  end
end
