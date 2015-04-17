class AddKeywordIdToResult < ActiveRecord::Migration
  def change
    add_column :results, :keyword_id, :integer
  end
end
