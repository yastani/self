require 'spec_helper'

describe server(:nginx) do
  describe http(
  	'http://localhost:8080',
    headers: {
    	'Host' => 'localhost',
    	'X-Forwarded-Proto' => 'http'
    }
  ) do
    it "responds with 200" do
    	expect(response.status).to eq(200)
    end

    it "responds content including 'Welcome to nginx!'" do
    	expect(response.body).to include('Welcome to nginx!')
    end

    it "responds as 'text/html'" do
    	expect(response.headers['content-type']).to eq("text/html")
    end
  end
end