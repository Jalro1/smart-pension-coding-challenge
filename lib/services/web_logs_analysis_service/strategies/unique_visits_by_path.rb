# frozen_string_literal: true

class WebLogsAnalysisService
  module Strategies
    class UniqueVisitsByPath
      extend Callable

      private

      attr_reader :log_lines

      def initialize(log_lines)
        @log_lines = log_lines
      end

      def call
        visits_by_paths.transform_values { |val| val.keys.size }.sort_by { _2 }.reverse
      end

      def visits_by_paths
        log_lines.each_with_object(Hash.new { |hash, key| hash[key] = Hash.new(0) }) do |line, hash|
          elements = line.split(' ')

          hash[elements[0]][elements[1]] += 1
        end
      end
    end
  end
end
