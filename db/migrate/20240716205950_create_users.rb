class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :timestamps

      t.timestamps
    end
    add_index :users, :username
    add_index :users, :email
  end
end
