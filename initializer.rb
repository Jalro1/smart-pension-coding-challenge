# frozen_string_literal: true

require 'zeitwerk'

class Initializer
  ZEITWERK_IGNORED_PATHS = %W[
    #{__dir__}/lib
    #{__dir__}/ruby_app.rb
    #{__dir__}/spec
  ].freeze

  ZEITWERK_INCLUDED_DIRECTORIES = %W[
    #{__dir__}/lib/mixins
    #{__dir__}/lib/services
  ].freeze

  def self.start
    loader = Zeitwerk::Loader.for_gem

    ZEITWERK_IGNORED_PATHS.each { loader.ignore(_1) }
    ZEITWERK_INCLUDED_DIRECTORIES.each { loader.push_dir(_1) }

    loader.setup
  end
end
