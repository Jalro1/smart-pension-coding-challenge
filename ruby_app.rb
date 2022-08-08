#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative 'initializer'

Initializer.start

ARGV.each do |logs_path|
  visits_count = WebLogsAnalysisService.call(
    strategy: WebLogsAnalysisService::Strategies::VisitsByPath,
    log_file_path: logs_path
  )
  unique_visits_count = WebLogsAnalysisService.call(
    strategy: WebLogsAnalysisService::Strategies::UniqueVisitsByPath,
    log_file_path: logs_path
  )
  visited_pages_by_user = WebLogsAnalysisService.call(
    strategy: WebLogsAnalysisService::Strategies::VisitsByIpAddress,
    log_file_path: logs_path
  )

  puts "For file: #{logs_path}"

  puts "\nVisits count:\n\n"
  visits_count.each { puts "#{_1} => #{_2} visit#{'s' if _2 > 1}" }

  puts "\nUnique visits count:\n\n"
  unique_visits_count.each { puts "#{_1} => #{_2} visit#{'s' if _2 > 1}" }

  puts "\nVisited pages by user:\n\n"
  visited_pages_by_user.each { puts "#{_1} => #{_2} visit#{'s' if _2 > 1}" }
  puts "\n"
end
