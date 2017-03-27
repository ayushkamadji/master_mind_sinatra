module AiHelper

  def generate_answer_space
    answer_space = DecodingNode.valid_codes.repeated_permutation(4).to_a
    return answer_space
  end

  def get_recent_row(board)
    return board.rows.select { |row| row.is_locked? }.last
  end

  def remove_blanks(feedback)
    feedback.delete(:blank)
    return feedback
  end

  def get_plain_codes(node_array)
    code_array = Array.new
    node_array.each { |node| code_array.push(node.code) }
    return code_array
  end

end
