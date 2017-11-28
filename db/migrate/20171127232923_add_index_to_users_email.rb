class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
  	add_index :users, :email, unique: true
  end
end
 #email uniquenes at database level i.e 2 identical
 #request at same time only first will be allowed.