class MusicLibraryController

  def initialize(path='./db/mp3s')
    MusicImporter.new(path).import
  end

  def call
    choice = nil
    while choice != "exit"
      puts "Welcome to your music library!"
      puts "To list all of your songs, enter 'list songs'."
      puts "To list all of the artists in your library, enter 'list artists'."
      puts "To list all of the genres in your library, enter 'list genres'."
      puts "To list all of the songs by a particular artist, enter 'list artist'."
      puts "To list all of the songs of a particular genre, enter 'list genre'."
      puts "To play a song, enter 'play song'."
      puts "To quit, type 'exit'."
      puts "What would you like to do?"
      choice = gets.strip

      if choice == "list songs"
        list_songs
      elsif choice == "list artists"
        list_artists
      elsif choice == "list genres"
        list_genres
      elsif choice == "list artist"
        list_songs_by_artist
      elsif choice == "list genre"
        list_songs_by_genre
      elsif choice == "play song"
        play_song
      end
    end
  end

  def list_songs
      array = []
      counter = 1
      array =  Song.all.sort_by! {|s| s.name}
      array.each do |s|
        puts "#{counter}. #{s.artist.name} - #{s.name} - #{s.genre.name}"
        counter += 1
      end
  end

  def list_artists
      array = []
      counter = 1
      array =  Artist.all.sort_by! {|s| s.name}
      array.each do |s|
        puts "#{counter}. #{s.name}"
        counter += 1
      end
  end

  def list_genres
      array = []
      counter = 1
      array =  Genre.all.sort_by! {|s| s.name}
      array.each do |s|
        puts "#{counter}. #{s.name}"
        counter += 1
      end
  end

  def list_songs_by_artist
      counter = 1
      puts "Please enter the name of an artist:"
      choice=gets.strip
      if Artist.find_by_name(choice)
        x=Artist.find_by_name(choice)
        x.songs.sort_by! {|s| s.name}
        x.songs.each do |s|
          puts "#{counter}. #{s.name} - #{s.genre.name}"
          counter += 1
        end
      end
  end

  def list_songs_by_genre
    counter = 1
    puts "Please enter the name of a genre:"
    choice = gets.strip
    if Genre.find_by_name(choice)
      x=Genre.find_by_name(choice)
      x.songs.sort_by! {|s| s.name}
      x.songs.each do |s|
        puts "#{counter}. #{s.artist.name} - #{s.name}"
        counter += 1
      end
    end
  end

  def sorted_songs
    Song.all.sort_by{|s| s.name}
  end

  def play_song
    puts "Which song number would you like to play?"
    choice = gets.strip.to_i
    if choice >=1 && choice <=sorted_songs.size #made a sorted_songs method above
      puts "Playing #{sorted_songs[choice-1].name} by #{sorted_songs[choice-1].artist.name}"
    end
  end

end
