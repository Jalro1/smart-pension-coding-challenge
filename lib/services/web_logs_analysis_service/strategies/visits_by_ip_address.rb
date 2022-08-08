# frozen_string_literal: true

class WebLogsAnalysisService
  module Strategies
    class VisitsByIpAddress
      extend Callable

      private

      attr_reader :log_lines, :unique_path

      def initialize(log_lines, unique_path: false)
        @log_lines = log_lines
        @unique_path = unique_path
      end

      def call
        log_lines.each_with_object(Hash.new(0)) do |line, hash|
          elements = line.split(' ')

          hash[elements[1]] += 1
        end.sort_by{ _2 }.reverse
      end
    end
  end
end
