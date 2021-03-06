require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(9) { Array('A'..'Z').sample }
  end

  def score
    end_time   = Time.now
    start_time = params[:start_time]
    @word      = params[:word].upcase
    word_array = @word.chars
    @letters   = params[:letters].split('')

    valid_word = word_array.all? do |char|
      @letters.count(char) >= word_array.count(char)
    end

    if valid_word
      url = "https://wagon-dictionary.herokuapp.com/#{@word}"
      dictionary = open(url).read
      result = JSON.parse(dictionary)

      # isso é true ou false!!!
      found = result["found"]

      if found
        @message = "Hurraaayyy! You won!"

        time_multiplier = (end_time - start_time.to_time) / 60

        @score = (@word.length / time_multiplier).round()
      else
        @message = "That word doesn't exist, silly"
      end
    else
      @message = "You cheated, your word can't be formed."
    end

    @score ||= 0
  end

end
