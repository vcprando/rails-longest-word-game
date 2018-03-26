class GamesController < ApplicationController
  def new
    @letters = rand("a".."z").to_a
  end

  def score
  end
end
