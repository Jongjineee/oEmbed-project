class IntrosController < ApplicationController
  require 'rest-client'
  require 'uri'
  require 'net/http'
  require 'pry'

  before_action :url_params, only: [:index]

  def index
    if url_params && URI.parse(url_params).host
      oembed_providers = RestClient.get 'https://oembed.com/providers.json'
      @providers_json = JSON.parse(oembed_providers)
      @domain = URI.parse(url_params).host
      
      if check_url
        first_url = check_url["endpoints"][0]["url"]
        first_url.gsub! '{format}', 'json'
        full_url = first_url + '?url=' + url_params
        full_url = full_url + "&format=json" unless full_url.include? "json"
        json_result = Net::HTTP.get(URI.parse(full_url))
        @results = JSON.parse(json_result)
      else
        redirect_to root_url
      end
    end
  end

  private

  def url_params
    params[:video_address]
  end

  def check_url
    @providers_json.find{ |provider| provider['provider_url'].include? @domain }
  end
end
