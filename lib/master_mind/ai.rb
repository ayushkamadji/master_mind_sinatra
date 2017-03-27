require 'master_mind/node'
require 'master_mind/board'
require 'master_mind/ai_helper'

class Ai
  include AiHelper
  attr_reader :answer_space

  def initialize
    @answer_space = generate_answer_space
    @codes = DecodingNode.valid_codes
  end

  def play(board)
    return first_play unless board.rows[0].is_locked?

    recent_row = get_recent_row(board)
    recent_answer = get_plain_codes(recent_row.decoding)
    recent_feedback = get_plain_codes(recent_row.feedback)

    eliminate_answers(recent_answer, recent_feedback)

    return @answer_space[rand(@answer_space.length)].join(' ')
  end

  def first_play
    return [@codes[0], @codes[0], @codes[1], @codes[1]].join(' ')
  end

  def eliminate_answers(recent_answer, feedback)
    @answer_space.delete(recent_answer)

    feedback = remove_blanks(feedback)

    @answer_space.each do |answer|
      unless feedback == calculate_feedback(answer, recent_answer)
        @answer_space.delete(answer)
      end
    end
  end

  def calculate_feedback(secret, decode)
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

#  Random plays
#  def play(board)
#    play = Array.new
#
#    4.times do
#      play.push(DecodingNode.valid_codes[rand(6)])
#    end
#
#    return play.join(' ')
#  end

end
