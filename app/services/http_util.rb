module HttpUtil
  def build_uri(host, path, params = {})
    uri = URI.parse(host)
    uri.path = path
    uri.query = URI.encode_www_form(params)
    uri
  end

  def make_request(uri)
    Net::HTTP.get_response(uri)
  end

  def parse_response(response, error_class: StandardError)
    case response
    when Net::HTTPSuccess
      JSON.parse(response.body)
    else
      raise error_class, "HTTP request failed with code: #{response.code} and message: #{response.message}"
    end
  end
end
