class AddPosteridToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :poster_id, :integer
  end

  def self.down
    remove_column :microposts, :poster_id
  end
end
