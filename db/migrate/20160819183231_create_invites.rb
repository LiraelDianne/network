class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.references :user, index: true, foreign_key: true
      t.references :inviter, index: true

      t.timestamps null: false
    end
    add_foreign_key :invites, :users, column: :inviter_id
  end
end
