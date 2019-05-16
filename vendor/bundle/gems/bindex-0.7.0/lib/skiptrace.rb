case RUBY_ENGINE
when 'rbx'
  require 'skiptrace/rubinius'
when 'jruby'
  require 'skiptrace/jruby'
when 'ruby'
  require 'skiptrace/cruby'
end

require "skiptrace/version"

