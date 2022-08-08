# frozen_string_literal: true

require 'spec_helper'
require 'tempfile'

RSpec.describe(WebLogsAnalysisService) do
  describe '.call' do
    subject(:call) { described_class.call(strategy: dummy_strategy, log_file_path: file.path) }

    let(:dummy_strategy) do
      class_spy(Class.new { extend Callable })
    end
    let(:file) do
      Tempfile.new('test_file').tap do
        _1 << '/test_path 124.153.11.122'
      end
    end
    let(:file_descriptor) { File.open(file) }
    let(:fd_each_line) { file_descriptor.each_line }
    let(:fd_each_line_lazy) { fd_each_line.lazy }

    before do
      allow(File).to receive(:open).with(file.path).and_return(file_descriptor)
      allow(file_descriptor).to receive(:each_line).and_return(fd_each_line)
      allow(fd_each_line).to receive(:lazy).and_return(fd_each_line_lazy)
    end

    it 'calls the strategy with a lazy enumerator on each line of the file' do
      call

      expect(dummy_strategy).to have_received(:call).with(fd_each_line_lazy)
    end
  end
end
