class AddPosterToMicroposts < ActiveRecord::Migration
  def self.up
    add_column :microposts, :poster, :string
  end

  def self.down
    remove_column :microposts, :poster
  end
end
