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
    webmock :get, %r{google.com} => 'GET_google.json'
    response = GET 'http://google.com'
    expect(response.status).to eq 200
    expect(response.body['google']).to eq true
  end

  it 'mocks GET google with custom response code' do
    webmock :get, %r{google.com} => 'GET_google.999.json'
    response = GET 'http://google.com'
    expect(response.status).to eq 999
    expect(response.body['google']).to eq true
  end

  it 'accepts a block that returns the with options' do
    webmock :get, %r{google.com} => 'GET_google.json', with: Hash[query: { test: '123' }]
    expect { GET 'http://google.com' }.to raise_error WebMock::NetConnectNotAllowedError
    response = GET 'http://google.com?test=123'
    expect(response.status).to eq 200
  end

  it 'mocks GET google with an empty body and given status code' do
    webmock :get, %r{google.com} => 204
    response = GET 'http://google.com'
    expect(response.body).to eq ''
    expect(response.status).to eq 204
  end

  it 'mocks GET google with response headers' do
    webmock :get, %r{google.com} => 'GET_google.json', headers: { 'Content-Type' => 'text/html' }
    response = GET 'http://google.com'
    expect(response.content_type).to eq 'text/html'
  end
end

describe '#fetch_webmock' do
  it 'should provide json data as a hash' do
    expect(fetch_webmock(:GET_google).json).to eq('google' => true)
    expect(fetch_webmock('GET_google.999').json).to eq('google' => true)
  end

  it 'should access nested stubs' do
    expect(fetch_webmock(:nested, :GET_nested).json).to eq('nested' => true)
    expect(fetch_webmock('nested/GET_nested').json).to eq('nested' => true)
  end

  it 'should provide raw data as a verbatim string' do
    expect(fetch_webmock('GET_google.json').raw).to eq '{ "google": true }'
    expect(fetch_webmock(:GET_google).raw(:json)).to eq '{ "google": true }'
  end
end

def GET(url)
  response = Net::HTTP.get_response URI.parse(url)
  body = response.body ? JSON.parse(response.body) : ''
  OpenStruct.new status: response.code.to_i, body: body, content_type: response['Content-Type']
end
