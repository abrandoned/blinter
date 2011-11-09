module Blinter
  class RSpec < Blinter::FileTraverser
    def initialize(opts={})
      super
    end

    def should_equals_equals(line) 
      check_ex = /\.should \=\=\s(.*)$/ 
      sub_ex = lambda{ |l| l.gsub(check_ex, ".should eq(#{$1})") }

      return sub_ex.call(line) if line =~ check_ex
      return line
    end
    
    alias_method :see, :should_equals_equals
  end
end
