require 'active_support/all' 

class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word, :guesses, :wrong_guesses, :valid

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  

  
  def guess(letter)
    if(letter =~ /[a-z]/i)
      valid = letter.downcase
    elsif(letter.nil? || letter =~ /^\s*.*$/)
      raise ArgumentError.new("Invalid letter")
    end
    if word.include?(valid)
      if guesses.exclude?(valid)
        guesses << valid
      else
        return false
      end
    else
      if wrong_guesses.exclude?(valid)
        wrong_guesses << valid
      else
      return false
      end
    end
  end
  
  def word_with_guesses
    result = ''
    
    word.split('').each do |letter|
      if guesses.include?(letter)
        result << letter
      else
        result << '-'
      end
    end
    
    result
  end
  
  def check_win_or_lose
    return :lose if wrong_guesses.length >= 7
    return :win unless word_with_guesses.include?('-')
    :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
 