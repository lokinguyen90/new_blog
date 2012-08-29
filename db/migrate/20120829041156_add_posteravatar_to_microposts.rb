class AddPosteravatarToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :poster_avatar, :string
  end

  def self.down
    remove_column :microposts, :poster_avatar
  end
end
