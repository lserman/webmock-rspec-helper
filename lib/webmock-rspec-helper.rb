require 'webmock'
require 'rspec'
require_relative './webmock-rspec-helper/stub_data'

module WebMock
  module RSpec
    module Helper
      def webmock(method, mocks = {}, with: false, headers: nil)
        mocks.each do |regex, result|
          if result.to_s =~ /\A\d+\z/
            status = result
            body = ''
          else
            status = result[/\.(\d+)\./, 1] || 200
            body = fetch_webmock(result).raw
          end

          stub = WebMock.stub_request(method, regex)
          stub.with(with) if with
          stub.to_return status: status.to_i, body: body, headers: headers
        end
      end

      def fetch_webmock(*path_fragment, name_without_extension)
        StubData.new(stub_path_for(*path_fragment), name_without_extension)
      end

      private
        def stub_path_for(*path_fragment)
          Rails.root.join 'spec', 'support', 'stubs', *path_fragment.map(&:to_s)
        end
    end
  end
end

RSpec.configure do |config|
  config.include WebMock::RSpec::Helper
end
