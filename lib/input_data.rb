require './lib/minesweeper_error'
require './lib/utils'

require 'pry-remote'

class InputData
	attr_accessor :new_game, :dimension, :mines, :difficulty

  def initialize
    @new_game = intial_arguments
    if @new_game == Utils::YES # new game  
     @dimension = choose_board_dimension
     @difficulty = select_difficulty 
      case @difficulty 
      when :e 
        @mines = (@dimension ** 2) / 10
      when :m
        @mines = (@dimension ** 2) / 7
      when :h
        @mines = (@dimension ** 2) / 5
      end 
    end

	end

	def intial_arguments
			Utils.print_welcome_message
			print "Would you like to start a new Minesweeper? \n please enter Yes/No ?\n"
    	print " > "

     new_game = $stdin.gets.chomp.downcase.to_s
    
	    until Utils.valid_yes_or_no?(new_game) 
	    	raise InvalidCommand.new(new_game) 
	    end 

	    return new_game
	  rescue InvalidCommand => e
	  	print e.message
	end

	def choose_board_dimension
	    print "Choose a board size. Must be at least 5\n"
	    print "> "

	  	dimension = $stdin.gets.chomp.to_i # get board size

	    if Utils.is_valid_dimension?(dimension)
	    	raise InvalidInteger if Utils.is_i?(dimension)
	    	raise InvalidDimensionSize if Utils.is_valid_dimension?(dimension)
	    end
	    return dimension

    rescue InvalidInteger => e
	  	print e.message
	  	retry
	  rescue InvalidDimensionSize => e
	  	print e.message
	  	retry
	end

	def select_difficulty
		  print "Choose a difficulty, [e]easy, [m]medium or [h]hard \nPlease enter e m or h\n"
	    print "> "

	    diff = $stdin.gets.chomp.downcase.to_sym

	    until [:e, :m, :h].include?(diff)
	      raise InvalidDifficultyOfGame
	    end 
	    return diff

	  rescue InvalidDifficultyOfGame => e
	  	print e.message
	  	retry
	end
end