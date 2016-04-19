class AddExtraFieldsToUsers < ActiveRecord::Migration
  def change
  	change_table(:users) do |t|
  		t.string :fullname
  		t.string :phone
  		t.integer :age
  		t.integer :type_user
  	end
  end
end
