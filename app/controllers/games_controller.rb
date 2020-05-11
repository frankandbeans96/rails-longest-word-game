require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    word_presence
    if word_validation(params[:word]) == true && @presence == true
      @result = 'congrats'
    elsif @presence == false
      @result = "Sorry but #{params[:word]} can't be built with: #{params[:letter_grid].upcase}"
    else
      @result = "Sorry but #{params[:word]} is not an english word"
    end
  end

  private

  def word_presence
    word = params[:word].split('')
    grid = params[:letter_grid]
    word.each do |letter|
      if grid.include? letter
        @presence = true
      else
        @presence = false
      end
    end
  end

  def word_validation(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = open(url).read
    word = JSON.parse(word_serialized)
    return true if word['found'] == true
  end

end
