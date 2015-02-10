require 'webmock'
require 'rspec'

module WebMock
  module RSpec
    module Helper

      def webmock(method, mocks = {})
        mocks.each do |regex, filename|
          status = filename[/\.(\d+)\./, 1] || 200
          body = File.read Rails.root.join('spec', 'support', 'stubs', filename)

          stub = WebMock.stub_request(method, regex)
          stub.with(yield) if block_given?
          stub.to_return status: status.to_i, body: body
        end
      end

    end
  end
end

RSpec.configure do |config|
  config.include WebMock::RSpec::Helper
end