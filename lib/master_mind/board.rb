require 'master_mind/node'

class Board
  attr_reader :rows

  def initialize
    @rows = Array.new
    12.times do
      @rows.push(Row.new)
    end
  end

  def update_row(index, decoding, feedback)
    @rows[index].update_decoding(*decoding)
    @rows[index].update_feedback(*feedback)
    @rows[index].lock
  end

  ## View
  def display_row(index)
    print "|"
    @rows[index].display
  end
    
  def display
    print "\e[2J\e[1;1H"
    print " ____________________\n"
    @rows.reverse_each do |row|
      row.display 
      print "\n"
    end
    print " --------------------\n"
    return nil
  end

end

class Row
  attr_reader :decoding, :feedback

  def initialize
    @locked = false
    @decoding, @feedback = Array.new, Array.new

    4.times do
      @decoding.push(DecodingNode.new)
      @feedback.push(FeedbackNode.new) 
    end
  end

  def update_decoding(a, b, c, d)
    codes = [a, b, c, d]
    codes.each_with_index { |code, index| @decoding[index].update_code(code) }
  end

  def update_feedback(*codes)
    codes.each_with_index { |code, index| @feedback[index].update_code(code) }
  end

  def lock
    @locked = true
  end

  def is_locked?
    return @locked
  end

  ## View
  def display
    print "|"
    @decoding.each { |node| node.display }
    print " | "
    @feedback.each { |node| node.display }
    print " |"
    return nil
  end

end
