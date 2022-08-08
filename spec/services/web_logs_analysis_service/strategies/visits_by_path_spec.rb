# frozen_string_literal: true

require 'spec_helper'

RSpec.describe(WebLogsAnalysisService::Strategies::VisitsByPath) do
  subject(:call) { described_class.call(logs) }

  let(:logs) do
    [
      '/test_path_3 129.1.15.120',
      '/test_path 128.1.15.120',
      '/test_path 128.1.15.120',
      '/test_path_2 128.1.15.120'
    ]
  end

  describe '.call' do
    it { is_expected.to be_a(Array) }

    it 'returns the number of visits for each paths in descending order' do
      expect(call).to eq([['/test_path', 2], ['/test_path_2', 1], ['/test_path_3', 1]])
    end
  end
end
