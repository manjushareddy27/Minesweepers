require './lib/utils'
require './lib/minesweeper_error'
require './lib/game_board'
require './lib/tile'
require './lib/parser'
require './lib/input_data'
require 'yaml' 

class Minesweeper

	attr_reader   :parser, :cmd_mgr

	def initialize

		@input = InputData.new
		Utils.clear_screen
		if @input.new_game == Utils::YES
		  @flags_remaining = @input.mines
      @board = GameBoard.new(@input.dimension, @input.mines)
      @game_over = false
      @timer_set = false
      @score = 0
      @difficulty = @input.difficulty
    else 
      print "Enter a filename to load from"
      print ">"
      file_name = $stdin.gets.chomp
      raise InvalidFileName unless File.exist?(file_name)
      @board, @flags_remaining, @difficulty = YAML.load_file(file_name)
    end
    @parser = Parser.new(@board, @flags_remaining, @difficulty)

    until @board.won? || @game_over 
      @board.display
      print "You have #{@flags_remaining} flags left."
      print ">"
	    input = @parser.parse_input
	    command, cds = input[:command], input[:pos]
	    if command == :f
	      change_flag(cds)
	    elsif command == :r
	      open_tile_board(cds)
	    end

      unless @timer_set
        @start_time = Time.new 
        @timer_set = true
      end      
    end 

    display_result

    rescue InvalidFileName => e
      print e.message
      retry  
	end


  private

	def display_result
    if @board.won? 
    	Utils.print_win_message
      print "You win the game!"
      @board.end_display
      game_complete
    elsif @game_over
    	Utils.print_mine_message
      print "You loose !"
      @board.end_display
    end    
  end 

  def change_flag(pos)
    flag = @board.get_tile(pos).flagged
    if flag && @board.remove_flag(pos)
      @flags_remaining += 1
    elsif @flags_remaining > 0 && @board.add_flag(pos)
      @flags_remaining -= 1
    else 
      print "You're out of flags"
      print ">"
    end 
  end 

  def open_tile_board(cds)
    states = @board.reveal_tile(cds) 
    if states[:game_over]
      @game_over = true
    elsif !states[:valid]
      print "Invalid move"
      print ">"
    end 
  end
  
end