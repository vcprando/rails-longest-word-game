require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @words = params[:word].split("")
    @letters = params[:letters].split(' ')


    exist = @words.all? do |word|
      @letters.include?(word) && @words.count(word) <= @letters.count(word)
    end

    response = open("https://wagon-dictionary.herokuapp.com/#{@words.join}").read

    unless JSON.parse(response)['found']
      exist = false
    end

    if exist
      @letter_scores =
      {  "A"=>1, "B"=>3, "C"=>3, "D"=>2,
        "E"=>1, "F"=>4, "G"=>2, "H"=>4,
        "I"=>1, "J"=>8, "K"=>5, "L"=>1,
        "M"=>3, "N"=>1, "O"=>1, "P"=>3,
        "Q"=>10, "R"=>1, "S"=>1, "T"=>1,
        "U"=>1, "V"=>4, "W"=>4, "X"=>8,
        "Y"=>4, "Z"=>10
      }

      total = 0
      @words.each do |word|
        total += @letter_scores[word.upcase]
      end


      @score = total
    else
      @score = 0
    end
  end
end
