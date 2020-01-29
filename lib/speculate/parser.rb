class Speculate::Parser
  Error = Class.new RuntimeError

  AROUND_END_RGX        = %r{\A\s{0,3}(?:```|~~~)\s*\z}
  AROUND_PLACEHOLDER_RGX = %r{\A\s*\.\.\.+\s*\z}
  AROUND_START_RGX      = %r{\A\s{0,3}(?:```|~~~)(.*)\baround}
  SPECULATION_END_RGX   = %r{\A\s{0,3}(?:```|~~~)\s*\z}
  SPECULATION_START_RGX = %r{\A\s{0,3}(?:```|~~~)(.*)\bspeculate}

  attr_reader :state, :stream

  def parse
    @state = :outer
    _parse
    before + lines + after
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
  def after
     @__after__ ||= [] 
  end
  def before
     @__before__ ||= [] 
  end
  def lines
     @__lines__ ||= []
  end

  # Parser
  # ======
  def _parse
    stream.each do |line|
      # puts ":#{state} #{line}"
      case state
      when :after
        _parse_after line
      when :before
        _parse_before line
      when :outer
        _parse_outer line
      when :inner
        _parse_inner line
      else
        raise Error, "illegal state #{state}"
      end
    end
  end

  def _parse_after line
    case line
    when AROUND_END_RGX
      @state = :outer
    else
      after << line
    end
  end

  def _parse_before line
    case line
    when AROUND_PLACEHOLDER_RGX 
      @state = :after
    when AROUND_END_RGX
      @state = :outer
    else
      before << line
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
    case line
    when AROUND_START_RGX
      @state = :before
    when SPECULATION_START_RGX
      @state = :inner
    end
  end
end
