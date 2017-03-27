require 'master_mind/view_helper'

class Node
  include ViewHelper

  attr_reader :code

  def initialize(code = :blank)
    @code = code
  end
  
  def is_blank?
    return @code == :blank
  end

end

class DecodingNode < Node

  @@valid_codes = [:blue, :red, :green, :purple, :yellow, :cyan]

  def initialize(code = :blank)
    @code = code
  end

  def display
    print ViewHelper::dpeg(@code)
    return nil
  end

  def self.valid_codes
    return @@valid_codes
  end

  def update_code(code)
    return print "Color not recognized" unless @@valid_codes.include?(code)
    @code = code
  end

end

class FeedbackNode < Node

  @@valid_codes = [:grey, :white]

  def initialize(code = :blank)
    @code = code
  end

  def display
    print ViewHelper::fpeg(@code)
    return nil
  end
  
  def self.valid_codes
    return @@valid_codes
  end

  def update_code(code)
    return print "Color not recognized" unless @@valid_codes.include?(code)
    @code = code
  end

end
