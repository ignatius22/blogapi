class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :email, null:  false
      t.string :password_digest, null: false
      t.index  :email, unique:  true
      t.timestamps
    end
  end
end
