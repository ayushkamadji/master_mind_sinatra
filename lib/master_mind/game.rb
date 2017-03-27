require 'master_mind/board'
require 'master_mind/player'
require 'master_mind/game_helper'
require 'master_mind/ai'

class Game
  include GameHelper

  attr_accessor :code, :board # change back to reader later

  def initialize(player=:human)
    @board = Board.new
    case player
    when :human
      @player = Player.new
      @code = generate_secret_code()
    when :ai
      @player = Ai.new
      @code = parse(prompt_secret_code)
    end
    @gameover = false
    @tries = 11
  end

  def start
    display
    until @gameover
      move = parse(get_next_play)
      feedback = calculate_feedback(move)
      @board.update_row((11 - @tries), move, feedback)
      display
      @tries -= 1
      @gameover = true if has_winner? || @tries < 0
    end
    if has_winner?
      print "\nMastermindful! You broke the secret code!\n"
    else
      print "\nGame over...\n"
    end
    show_code
  end

  def end_turn
    @tries -= 1
  end

  def update(move)
    @board.update_row((11 - @tries), move, calculate_feedback(move))
  end

  def over?
    has_winner? || @tries < 0
  end

  def has_winner?
    return @board.rows.any? do |row|
      row.feedback.all? { |fb| fb.code == :grey }
    end
  end

  def calculate_feedback(secret = @code, decode)
    feedback = []
    decode_nomatch = []
    secret_nomatch = []
    decode.each_with_index do |code, i| 
       if secret[i] == code
         feedback.push(:grey)
       else
         decode_nomatch.push(code)
         secret_nomatch.push(secret[i])
       end
    end
    decode_nomatch.each_with_index do |code, i|
      if secret_nomatch.include?(code)
        feedback.push(:white)
        secret_nomatch.delete(code)
      end
    end
    return feedback
  end

  def get_next_play
    move = @player.play if @player.is_a? Player
    move = @player.play(@board) if @player.is_a? Ai
    return move
  end

  # View
  def display
    board.display
    print "#{peg(:red)} = red\t#{peg(:blue)} = blue\t#{peg(:purple)} = purple\n"
    print "#{peg(:cyan)} = cyan\t#{peg(:green)} = green\t#{peg(:yellow)} = yellow\n"
  end

  def show_code
    @code.each { |code| print "#{peg(code)}" }
  end

end
