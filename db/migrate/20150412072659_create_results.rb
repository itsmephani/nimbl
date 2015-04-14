class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :link
      t.string :display_url
      t.boolean :is_ad, default: false
      t.integer :page_id
      t.timestamps
    end
  end
end
