class QuotesTable < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :quote
      t.string :author
    end
  end
end
