class IntrosController < ApplicationController
  require 'rest-client'
  require 'uri'
  require 'net/http'

  before_action :check_params
  
  def index
    # FecthOembedService.call(params[:requested...])
    # libray 이용, controller 사용 용도?

    # json schemes -> instagram : www. 붙으면 X
    # application/json-oembed HEADER

    if url_params && check_url
      first_url = check_url["endpoints"][0]["url"]
      first_url.gsub! '{format}', 'json'
      full_url = first_url + '?url=' + url_params
      full_url = full_url + "&format=json" unless full_url.include? "json"
      json_result = Net::HTTP.get(URI.parse(full_url))
      @results = JSON.parse(json_result)
    end
  end

  private

  def url_params
    params[:url_address] # video_address 네이밍 변경 url_address
  end

  def url_host
    URI.parse(url_params).host
  end

  def check_params # validated_request_url 따라가도록 하지말고 한 곳에서 입력해주도록? 
    check_valid_url if url_params
  end

  def check_valid_url
    return load_providers_json if url_host
    redirect_to root_url, alert: "Invalid URL"
  end

  def check_url
    @providers_json.find{ |provider| provider['provider_url'].include? url_host }
  end

  def load_providers_json
    oembed_providers = RestClient.get 'https://oembed.com/providers.json'
    @providers_json = JSON.parse(oembed_providers)
    return request_oembed_url
  end

  def request_oembed_url
    return if check_url
    redirect_to root_url, alert: "The url does not provide oEmbed." and return
  end
end
