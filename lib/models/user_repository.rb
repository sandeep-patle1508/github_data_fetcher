require './lib/github_api/client'

class UserRepository
  attr_accessor :id, :name, :html_url

  def initialize(params)
    params.each do |k,v|
      instance_variable_set("@#{k}",v) unless v.nil?
    end
  end

  # class method to get user public repos
  #
  # @params user_name[String] Github user name
  # @return array of user objects if API call successful
  # else return empty array 
  def self.get_public_repos(user_name)
    repos = []
    api_response = GithubApi::Client.new.get_public_repos(user_name)

    if api_response.success?
      api_response.each do |data| 
        repos << new( { id: data['id'], name: data['name'], html_url: data['html_url'] })
      end
    end

    repos
  end
end