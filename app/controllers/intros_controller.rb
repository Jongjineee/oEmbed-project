class IntrosController < ApplicationController
  require 'rest-client'
  require 'open-uri'
  before_action :validated_request_url
  
  def index
    if url_params && get_oembed_url
      first_url = get_oembed_url
      first_url.gsub! '{format}', 'json'
      full_url = first_url + '?url=' + url_params
      full_url = full_url + '&format=json' unless full_url.include? 'json'
      json_result = open(full_url).read
      @results = JSON.parse(json_result)
    end
  end

  private

  def url_params
    params[:url_address]
  end

  def url_host
    URI.parse(url_params).host
  end

  def validated_request_url
    get_providers_json if url_params
  end

  def get_providers_json
    if url_params && url_host
      oembed_providers = RestClient.get 'https://oembed.com/providers.json'
      @providers_json = JSON.parse(oembed_providers)
      return get_oembed_url
    else
      redirect_to root_url, alert: "Invalid URL"
    end
  end

  def get_oembed_url
    @providers_json.each do |provider|
      if provider['endpoints'][0]['schemes']
        schemes = provider['endpoints'][0]['schemes'].map { |url| url.split('/')[2]&.gsub '*', 'www' }
        return provider['endpoints'][0]['url'] if schemes.include? url_host
      end
    end
    redirect_to root_url, alert: "The url does not provide oEmbed." and return
  end
end
