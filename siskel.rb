require 'httparty'

class Siskel
  attr_reader :title, :rating, :year, :plot
  def initialize(title, options = {})
    year = options[:year]
    plot_type = options[:plot]

    @movie = HTTParty.get("http://www.omdbapi.com/?t=#{title}&y=#{options[:year]}&plot=#{plot_type}&tomatoes=true")
    @tomato_meter = @movie["tomatoMeter"].to_f

    @title = @movie['Title']
    @rating = @movie["Rated"]
    @year = @movie["Year"]
    #p @movie (to see where everything is stored)
    @plot = @movie["Plot"]
  end
  def consensus
    if @tomato_meter >= 0 and @tomato_meter <= 50
      "Thumbs Down"
    else
      "Thumbs Up"
    end
  end
  # @title = @movie['Title'] || @movie['Error']
  def title
    if @title == nil
      @title = "Movie not found!"
    else
      @title = @movie['Title']
    end
  end
end
