class Speculate::Args

  FLAG_RGX = %r{\A:}
  KEYWORD_RGX = %r{:\z}

  attr_reader :args

  def empty?; args.empty? end

  def fetch symbol, default=nil, &block
    index = args.index("#{symbol}:")
    return default unless index
    args.fetch( index.succ, default ).tap do |value|
      return block.(value) if block
    end
  end

  def fetch! symbol, default=nil, &block
    index = args.index("#{symbol}:")
    return default unless index
    args.delete_at index
    args.fetch( index ) {
      return default
    }.tap{ |value|
      args.delete_at index
      return block.(value) if block
    }
  end

  def flag? value
    args.index ":#{value}"
  end

  def flag! value
    flag?(value).tap do |idx|
      return unless idx
      args.delete_at(idx)
    end
  end

  def positionals
    args.inject [false, []] do |(last_was_keyword, result), ele|
      if last_was_keyword
        [false, result]
      else
        case ele
        when KEYWORD_RGX
          [true, result]
        when FLAG_RGX
          [false, result]
        else
          [false, result << ele]
        end
      end
    end.last
  end

  def to_a
    args.dup
  end


  private

  def initialize with
    @args = with.dup
  end

  def _flag arg
    FLAG_RGX.match? arg
  end

  def _keyword? arg
    KEYWORD_RGX.match arg
  end
end
