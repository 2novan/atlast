class AddSongkickIdToConcerts < ActiveRecord::Migration[6.0]
  def change
    add_column :concerts, :songkick_id, :string
  end
end
