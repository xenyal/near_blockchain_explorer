# frozen_string_literal: true
require 'net/http'

module NEAR
  class ApiService
    include HttpUtil

    class NearApiServiceError < StandardError; end
    class MissingRequiredEnvironmentVariable < StandardError; end

    NEAR_API_HOST_URL = ENV['NEAR_API_HOST_URL']
    NEAR_API_KEY = ENV['NEAR_API_KEY']
    NEAR_API_PATH = "/near/transactions"

    def initialize
      raise MissingRequiredEnvironmentVariable, 'NEAR_API_HOST_URL environment variable is missing' unless NEAR_API_HOST_URL.present?
      raise MissingRequiredEnvironmentVariable, 'NEAR_API_PATH environment variable is missing' unless NEAR_API_PATH.present?
      raise MissingRequiredEnvironmentVariable, 'NEAR_API_KEY environment variable is missing' unless NEAR_API_KEY.present?
    end

    def fetch_blocks_with_transactions
      uri = build_uri(NEAR_API_HOST_URL, NEAR_API_PATH, api_key: NEAR_API_KEY)
      response = make_request(uri)
      parse_response(response, error_class: NearApiServiceError)
    rescue StandardError => e
      raise NearApiServiceError, e
    end
  end
end
