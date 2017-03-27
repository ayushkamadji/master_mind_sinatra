module ViewHelper
  
  def self.colorize(str, code)
    return "\e[#{color(code)}m#{str}\e[0m"
  end

  def self.color(code)
    case code
    when :blue then return "0;34"
    when :green then return "0;32"
    when :red then return "0;31"
    when :yellow then return "1;33"
    when :purple then return "0;35"
    when :cyan then return "1;36"
    when :grey then return "1;30"
    when :white then return "1;37"
    end
  end

  def self.dpeg(code)
    return colorize(" \u25cb ", code) unless code != :blank
    return colorize(" \u25cf ", code)
  end

  def self.fpeg(code)
    return colorize("\u25e6", code) unless code != :blank
    return colorize("\u2022", code)
  end

end
