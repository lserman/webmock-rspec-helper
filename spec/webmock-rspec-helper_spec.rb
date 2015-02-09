require 'net/http'
require 'uri'
require 'json'

require 'webmock-rspec-helper'
require 'webmock/rspec'

WebMock.disable_net_connect!

class WebMock::RSpec::Helper::Rails
  def self.root
    Pathname.new File.expand_path('../..', __FILE__)
  end
end

describe '#webmock' do
  it 'mocks GET google using default response 200' do
    webmock :get, %r[google.com] => 'GET_google.json'
    response = GET('http://google.com')
    expect(response.status).to eq 200
    expect(response.body['google']).to eq true
  end

  it 'mocks GET google with custom response code' do
    webmock :get, %r[google.com] => 'GET_google.999.json'
    response = GET('http://google.com')
    expect(response.status).to eq 999
    expect(response.body['google']).to eq true
  end
end

def GET(url)
  response = Net::HTTP.get_response URI.parse('http://google.com')
  OpenStruct.new status: response.code.to_i, body: JSON.parse(response.body)
end
