class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.string :token
      t.references :user, null: false, foreign_key: true
      t.string :timestamps

      t.timestamps
    end
  end
end
