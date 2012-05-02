class HomeController < ApplicationController
	# before_filter :parse_facebook_cookies

  def index
  	if facebook_cookies
	 		@access_token = facebook_cookies["access_token"]
	  	@graph = Koala::Facebook::GraphAPI.new(@access_token)
	  	puts @graph.inspect
	  else
	  	puts "No facebook cookies"
	  end

    puts "ME:" + @graph.get_object("me").to_yaml.to_s

    puts @graph.get_connections("kmandrup", "likes").to_yaml

    puts @graph.get_connections("kmandrup", "friends").to_yaml
	  
  end

  protected

	def parse_facebook_cookies
	  @facebook_cookies ||= Koala::Facebook::OAuth.new('285193711555371', '9d5501e9bda66481fed4c88eaaf28712').get_user_info_from_cookie(cookies)
	  # If you've setup a configuration file as shown above then you can just do
	  # @facebook_cookies ||= Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
	end  
end
