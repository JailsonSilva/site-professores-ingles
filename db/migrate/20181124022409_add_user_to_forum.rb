class AddUserToForum < ActiveRecord::Migration[5.1]
  def change
    add_reference :forums, :user, foreign_key: true
  end
end
