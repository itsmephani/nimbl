class AddTimeStamps < ActiveRecord::Migration
  def change
    [:keywords, :pages, :results].each do |table|
      add_timestamps table
    end
  end
end
