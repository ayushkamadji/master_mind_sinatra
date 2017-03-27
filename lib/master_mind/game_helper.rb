require 'master_mind/view_helper'

module GameHelper
  
  def generate_secret_code
    secret_code = Array.new
    4.times do
      secret_code.push(DecodingNode.valid_codes[rand(6)])
    end
    return secret_code
  end

  def prompt_secret_code
    print "\e[2J\e[1;1H"
    print "#{peg(:red)} = red\t#{peg(:blue)} = blue\t#{peg(:purple)} = purple\n"
    print "#{peg(:cyan)} = cyan\t#{peg(:green)} = green\t#{peg(:yellow)} = yellow\n"
    print "Type in 4 colours :\n"
    return gets.strip
  end

  def peg(code)
    ViewHelper::dpeg(code)
  end

  def parse(code_string)
    return code_string.split(" ").collect { |code| code.to_sym }
  end

end
