class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.string :name
      t.references :release, null: false, foreign_key: true
      t.integer :duration
      t.integer :track_number
      t.string :spotify_id

      t.timestamps
    end
  end
end
