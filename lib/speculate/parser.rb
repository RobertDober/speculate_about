class Speculate::Parser
  Error = Class.new RuntimeError

  SPECULATION_END_RGX   = %r{\A\s{0,3}(?:```)|(?:~~~)\s*\z}
  SPECULATION_START_RGX = %r{\A\s{0,3}(?:```)|(?:~~~)(\w+)speculate}

  attr_reader :state, :stream

  def parse
    @state = :outer
    _parse
    lines
  end


  private

  def initialize speculation
    @stream =
      speculation
        .each_line(chomp: true)
        .lazy
  end


  # Memos
  # =====
  def lines
     @__lines__ ||= []
  end


  # Parser
  # ======
  def _parse
    stream.each do |line|
      case state
      when :outer
        _parse_outer line
      when :inner
        _parse_inner line
      else
        raise Error, "illegal state #{state}"
      end
    end
  end

  def _parse_inner line
    if SPECULATION_END_RGX =~ line
      @state = :outer
    else
      lines << line
    end
  end

  def _parse_outer line
    if SPECULATION_START_RGX =~ line
      @state = :inner
    end
  end
end
