module Spotify
  RSpotify.authenticate("99df90ccb6964e5cbe030a71e89dc1f5", "1b2dc82a4dca4d7f8b0f6026380bcede")

  class FetchArtists

    def initialize(user)
      @user = user
      @spotify_user = RSpotify::User.new('credentials' => { 'token' => User.last.token })
    end

    def call  # Spotify::FetchArtists.new(User.last).call
      # rails c -> reload!
      @spotify_user.top_artists.each do |artist|
        artist = Artist.where({name: artist.name, spotify_id: artist.id, image_url: artist.images.last["url"], genre }).first_or_create
        genre = Genre.where({name: artist.genres}).first_or_create
        artist_genres = Artist_genres.where({genre: genre, artist: artist}).first_or_create

        # Recuperer les genres et les envoyer dans la table genre puis les associer avec genre_id
      
          # genres each 
          #   genre = Genre first_or_create
          #   GenreArtist..where(genre: genre, artist: artist).first_or_create
      end
    end
  end
end