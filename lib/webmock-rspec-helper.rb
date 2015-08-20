require 'webmock'
require 'rspec'

module WebMock
  module RSpec
    module Helper

      def webmock(method, mocks = {}, with: false)
        mocks.each do |regex, result|
          if result.to_s =~ /\A\d+\z/
            status = result
            body = ''
          else
            status = result[/\.(\d+)\./, 1] || 200
            body = File.read Rails.root.join('spec', 'support', 'stubs', result)
          end

          stub = WebMock.stub_request(method, regex)
          stub.with(with) if with
          stub.to_return status: status.to_i, body: body
        end
      end

    end
  end
end

RSpec.configure do |config|
  config.include WebMock::RSpec::Helper
end
