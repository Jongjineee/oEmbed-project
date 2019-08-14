class IntrosController < ApplicationController
  require 'rest-client'
  require 'open-uri'
  before_action :validated_request_url

  def index
  end

  private

  def url_params
    params[:url_address]
  end

  def url_host
    @host = URI.parse(url_params).host
  end

  def validated_request_url
    get_providers_json if url_params
  end

  def get_providers_json
    if url_host
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
        if schemes.include? @host
          @oembed_url = provider['endpoints'][0]['url']
          return create_endpoint
        end
      end
    end
    redirect_to root_url, alert: "The url does not provide oEmbed." and return
  end

  def create_endpoint
    @oembed_url.gsub! '{format}', 'json'
    full_url = @oembed_url + '?url=' + url_params
    full_url = full_url + '&format=json' unless full_url.include? 'json'
    get_oembed_json(full_url)
  end

  def get_oembed_json(full_url)
    json_result = open(full_url).read
    @results = JSON.parse(json_result)
    return
  rescue OpenURI::HTTPError => e
    redirect_to root_url, alert: "잘못된 url입니다."
  end
end
