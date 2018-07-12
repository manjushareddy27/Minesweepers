require './lib/minesweeper'

class Parser
  attr_reader :board, :flags_remaining, :diff


  def initialize(board, flags_remaining, diff)
    @board = board
    @flags_remaining = flags_remaining
    @diff = diff
  end

  def parse_input
    begin
      print "Input command (r or f) followed by the position xy. No spaces"
      print "Or input 'save' to save progress"
      print ">"
      str = $stdin.gets.chomp
      if str == "save"
        save 
        
      else 
        command = str[0].to_sym
        pos = [str[1].to_i, str[2].to_i]      
      end 
      
        raise BadInputError, "Invalid command" unless [:r, :f].include?(command) 
        raise BadInputError, "Invalid Positions" unless @board.is_valid?(pos)
      
        rescue BadInputError => e
          print e.message      
          retry 
        rescue ArgumentError => e
          print e.message    
          retry
        
      end 
    { :command => command , :pos => pos }
  end

  
  
  def save
    game_yaml = [@board, @flags_remaining, @diff].to_yaml
    print "Enter a file name to save your game to."
    file_name = $stdin.gets.chomp
    File.open(file_name, "w") do |f|
      f.print game_yaml
    end 
    print "Your game has been saved"
  end
end