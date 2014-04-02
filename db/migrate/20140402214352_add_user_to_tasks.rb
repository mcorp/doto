class AddUserToTasks < ActiveRecord::Migration
  def change
    change_table :tasks do |t|
      t.references :user
    end
  end
end
