class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :movie
      t.string :user
      t.integer :stars
      t.text :body

      t.timestamps
    end
  end
end
