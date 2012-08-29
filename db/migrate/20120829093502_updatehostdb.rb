class Updatehostdb < ActiveRecord::Migration
  def self.up
  	execute <<-SQL
        UPDATE users SET admin = TRUE
        WHERE id = 1
    SQL
  end

  def self.down
  end
end
