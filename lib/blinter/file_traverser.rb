require 'fileutils'
require 'tempfile'

module Blinter
  class FileTraverser

    DEFAULT_OPTIONS = { 
      :file => "./**/*.rb",
      :simulate => false,
      :verbose => false,
      :test => :override_warning 
    }.freeze

    def override_warning(*args)
      class_name = self.class.to_s
      raise "Must provide a method to test in '#{class_name}'" 
    end

    def initialize(opts={})
      @options = DEFAULT_OPTIONS.dup.merge(opts)
    end

    def exec
      _each_line
    end

    private 

    def run(line)
      exec_option = @options[:test]

      case 
      when exec_option.respond_to?(:call) then
        exec_option.call(line)
      when exec_option.is_a?(String) || exec_option.is_a?(Symbol) then
        method(exec_option).call(line)
      else
        raise "Unknown execution option for '#{self.class}'"
      end
    end

    def _each_line
      Dir.glob(@options[:file]) do |file|
        next if file == "." || file == ".."

        new_line = ""
        temp_file = @options[:simulate] ? false : Tempfile.new("blinter")

        $stdout.puts("Checking: " << File.expand_path(file)) if @options[:verbose]

        File.open(File.expand_path(file), "r").each_line do |line|
          new_line = line
          new_line = run(line)

          if @options[:verbose] && line != new_line
            $stdout.puts("-" << line)
            $stdout.puts("+" << new_line)
          end

          temp_file.puts(new_line) if temp_file 
        end

        FileUtils.mv(File.expand_path(temp_file), File.expand_path(file)) if temp_file
      end
    end
  end
end
