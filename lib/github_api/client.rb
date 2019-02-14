# Using Github version 3 api to get public repository of an user
# https://developer.github.com/v3/repos/

require 'httparty'
require 'json'

module GithubApi
  class Client
    include HTTParty

    # base URI of github api
    base_uri 'https://api.github.com'.freeze

    # get list of public guthub repository of an user
    #
    # @param user_name[String] github user name
    # @return HTTParty response
    def get_public_repos(user_name)
      get("/users/#{user_name}/repos")
    end

    private
    def get(request_url)
      self.class.get(request_url)
    end
  end
end