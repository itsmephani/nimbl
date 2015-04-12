class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :no_of_adwords_top
      t.integer :no_of_adwords_right
      t.integer :no_of_non_adwords_results
      t.integer :total_results_per_page
      t.integer :start
      t.text    :content
      t.integer :keyword_id
    end
  end
end
