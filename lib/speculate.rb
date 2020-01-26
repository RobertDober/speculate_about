module Speculate extend self
  require_relative 'speculate/args'
  require_relative 'speculate/dirs'
  require_relative 'speculate/generator'

  BASE_DIR = 'spec/speculations'

  attr_reader :args

  def base_dir
    @__base_dir__ ||= args.fetch!(:dest, BASE_DIR) 
  end

  def speculations
    @__speculations__ ||= _speculations
  end

  def speculations_dir
    @__speculations_dir__ ||= args.fetch!(:dir, 'spec/speculations')
  end

  def speculations_glob
    @__speculations_glob__ ||= args.fetch!(:glob, '**/*.md')
  end

  def run args
    @args = Args.new args
    if @args.flag!(:force)
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
    speculations = Dir.glob(File.join(speculations_dir, speculations_glob))
    if speculations.any?
      puts "Speculations found: #{speculations}"
    else
      puts "No Speculations found!!!! :O :O :O"
      return []
    end
    speculations.map{ |speculation| Dirs.speculation_to_dir(speculation, base_dir) }
  end

end
