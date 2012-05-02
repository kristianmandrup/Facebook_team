class ApplicationController < ActionController::Base
  protect_from_forgery

	def facebook_cookies
		@facebook_cookies ||= Koala::Facebook::OAuth.new.get_user_info_from_cookie(cookies)
		# @facebook_cookies ||= Koala::Facebook::OAuth.new('285193711555371', '9d5501e9bda66481fed4c88eaaf28712').get_user_info_from_cookie(cookies)
	end  
end
