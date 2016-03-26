class CouriersWithProfiles < ActiveRecord::Migration
  def up
  	execute <<-SQL
  		CREATE VIEW cours AS SELECT  name, phone, role_id, longitude, latitude FROM users,profiles where users.role_id = 2 AND users.id = profiles.user_id 
  	SQL
  end

  def down
  	execute <<-SQL 
  		DROP VIEW IF EXISTS cours
  	SQL
  end

end

