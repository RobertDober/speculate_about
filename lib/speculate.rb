module Speculate extend self
  SPECULATIONS_GLOB = "SPECULATE*.md"
  require_relative 'speculate/dirs'
  require_relative 'speculate/generator'

  def speculations
    @__speculations__ ||= _speculations
  end

  def run args
    if args[0] == ":force"
      _force speculations
    end
    speculations
      .filter(&:outdated?)
      .each(&Generator.method(:generate))
  end


  private

  def _force speculations
    speculations.each do |speculation|
      puts "touching #{speculation.speculation.path} as :force was passed in"
      FileUtils.touch speculation.speculation
    end
  end

  def _speculations
    speculations = Dir.glob(SPECULATIONS_GLOB)
    if speculations.any?
      puts "Speculations found: #{speculations}"
    else
      puts "No Speculations found!!!! :O :O :O"
      return []
    end
    speculations.map{ |speculation| Dirs.speculation_to_dir(speculation) }
  end

end
