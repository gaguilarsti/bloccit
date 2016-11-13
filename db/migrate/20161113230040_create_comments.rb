class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body

      # the index on the references line tells the database to index the post_id column so it can be searched effciently.
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
