class CreateReleases < ActiveRecord::Migration[6.0]
  def change
    create_table :releases do |t|
      t.string :name
      t.string :album_type
      t.references :artist, null: false, foreign_key: true
      t.date :release_date
      t.text :description
      t.string :spotify_id
      t.string :image_url
      t.integer :total_tracks

      t.timestamps
    end
  end
end
