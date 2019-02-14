class User
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
  end
end