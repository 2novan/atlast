class CreateArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :spotify_id
      t.string :image_url
      t.integer :songkick_id

      t.timestamps
    end
  end
end
