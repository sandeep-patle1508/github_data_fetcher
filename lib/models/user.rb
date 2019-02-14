class User
  attr_accessor :id, :name, :html_url

  def initialize(params)
    params.each do |k,v|
      instance_variable_set("@#{k}",v) unless v.nil?
    end
  end
end