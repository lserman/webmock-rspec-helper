module WebMock
  module RSpec
    module Helper

      VERSION = '0.0.1'

      def webmock(method, mocks = {})
        mocks.each do |regex, filename|
          status = filename[/\.(\d+)\./)] || 200
          body = File.read Rails.root.join('spec', 'support', filename)
          WebMock.stub_request(method, regex).to_return status: status, body: body
        end
      end

    end
  end
end

RSpec.configure do |config|
  config.include WebMock::RSpec::Helper
end