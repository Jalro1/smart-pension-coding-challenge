# frozen_string_literal: true

class WebLogsAnalysisService
  extend Callable

  private

  attr_reader :log_file_path, :strategy

  def initialize(strategy:, log_file_path:)
    @strategy = strategy
    @log_file_path = log_file_path
  end

  def call
    strategy.call(log_file_lines)
  end

  def log_file_lines
    File.open(log_file_path).each_line.lazy
  end
end
