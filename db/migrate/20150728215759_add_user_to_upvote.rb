class AddUserToUpvote < ActiveRecord::Migration
  def change
    add_column :upvotes, :user_id, :integer
  end
end
