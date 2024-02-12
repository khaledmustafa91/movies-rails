class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.text :description
      t.string :year
      t.string :actor
      t.string :director
      t.string :filming_location
      t.string :country

      t.timestamps
    end
  end
end
