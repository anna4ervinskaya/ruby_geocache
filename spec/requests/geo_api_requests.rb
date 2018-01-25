require 'rails_helper'

describe "list of geolocations", :type => :request do
  let!(:geolocations) {
    for i in 1..5
      Geolocation.create(message: 'message',lat: '1.1', lng: '1.1')
    end
   }

  before { get '/api/list/' }
  it "list should return proper json" do
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)['data'].size).to eq(5)
  end
end

describe "create geolocation", :type => :request do
  before do
    post '/api/create', params: { :message => 'test_message', :lat => '1.1', :lng => '1.2' }
  end

  it 'returns the message' do
    expect(JSON.parse(response.body)['message']).to eq('test_message')
  end

  it 'returns the lat' do
    expect(JSON.parse(response.body)['lat']).to eq(1.1)
  end

  it 'returns the lngt' do
    expect(JSON.parse(response.body)['lng']).to eq(1.2)
  end

  it 'returns a created status' do
    expect(response).to have_http_status(:created)
  end
end

describe "show geolocation", :type => :request do
  let!(:geolocation) { Geolocation.create(message: 'message',lat: '1.1', lng: '1.1') }
  it "show should return proper json" do
    get ('/api/show/' + geolocation.id.to_s)
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)['message']).to eq('message')
    expect(JSON.parse(response.body)['lat']).to eq(1.1)
    expect(JSON.parse(response.body)['lng']).to eq(1.1)
  end
end

describe "delete geolocation", :type => :request do
  let!(:geolocation) { Geolocation.create(message: 'message',lat: '1.1', lng: '1.1') }
  it "delete should return proper response" do
    delete ('/api/delete/' + geolocation.id.to_s)
    expect(response).to have_http_status(204)
  end
end

describe "udpate geolocation", :type => :request do
  let!(:geolocation) { Geolocation.create(message: 'message',lat: '1.1', lng: '1.1') }
  it "update should return proper json" do
    put ('/api/update/' + geolocation.id.to_s) , params: { :message => 'new_message' }
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)['message']).to eq('new_message')
  end
end
