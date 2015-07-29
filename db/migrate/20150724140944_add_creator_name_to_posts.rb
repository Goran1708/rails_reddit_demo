class AddCreatorNameToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :creator_name, :string
  end
end
