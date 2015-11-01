class AddCommentsAndUpvotesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer, :default => 0
    add_column :posts, :upvotes_count, :integer, :default => 0
    
    Post.reset_column_information
    Post.find_each do |p|
      Post.reset_counters p.id, :comments
      Post.reset_counters p.id, :upvotes
    end
  end
end
