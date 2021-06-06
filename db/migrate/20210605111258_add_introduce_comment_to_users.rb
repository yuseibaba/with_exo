class AddIntroduceCommentToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :introduce_comment, :string
  end
end
