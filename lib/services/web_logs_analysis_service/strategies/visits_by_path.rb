# frozen_string_literal: true

class WebLogsAnalysisService
  module Strategies
    class VisitsByPath
      extend Callable

      private

      attr_reader :log_lines

      def initialize(log_lines)
        @log_lines = log_lines
      end

      def call
        log_lines.each_with_object(Hash.new(0)) do |line, hash|
          elements = line.split(' ')

          hash[elements[0]] += 1
        end.sort_by{ _2 }.reverse
      end
    end
  end
end
