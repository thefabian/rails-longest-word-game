require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word_input = params[:word_input]
    if @word_input.upcase.chars.all? { |letter| @word_input.upcase.count(letter) <= params[:grid].count(letter) }
      if english_word?(@word_input)
        @answer = "Congratulations #{@word_input} is a valid English word."
      else
        @answer = "Sorry but #{@word_input} does not seem to be a valid English word."
      end
    else
      @answer = "Sorry but #{@word_input} can't be build out of #{params[:grid]}"
    end
  end

  def english_word?(input)
    response = open("https://wagon-dictionary.herokuapp.com/#{input}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
