class RemoveCommentsAndUpvotesFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :comments_count, :integer
    remove_column :posts, :upvotes_count, :integer
  end
end
