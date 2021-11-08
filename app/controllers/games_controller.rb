require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(9) { ('A'..'Z').to_a.sample }
  end
  def score
    @word = params[:word]
    @letters = params[:letters]
    if @word.upcase.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }
      response = URI.open("https://wagon-dictionary.herokuapp.com/#{@word}")
      json = JSON.parse(response.read)
      if json['found'] == true
        @answer = "Congrats! #{@word.upcase} is a english word"
      else
        @answer = "Sorry, but #{@word.upcase} is not an english word"
      end
    else
      @answer = "Sorry but #{@word.upcase} can't be built out of #{@letters}"
    end
  end
end
