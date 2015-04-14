class CreateKeywordsTable < ActiveRecord::Migration
  def change
    create_table :keywords do |t|
      t.string :keyword
      t.decimal :results_count
      t.decimal :time_taken
      t.timestamps
    end
  end
end
