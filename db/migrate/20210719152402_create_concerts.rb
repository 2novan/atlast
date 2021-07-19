class CreateConcerts < ActiveRecord::Migration[6.0]
  def change
    create_table :concerts do |t|
      t.string :location
      t.datetime :start_at
      t.references :artist, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
