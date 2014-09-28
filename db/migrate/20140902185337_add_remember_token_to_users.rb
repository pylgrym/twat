class AddRememberTokenToUsers < ActiveRecord::Migration
  def change
  	# p346 added:
  	add_column :users, :remember_token, :string
  	add_index  :users, :remember_token
  end
end
