class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(omniauth, current_user)

    puts "access token: #{oath_token}"

    @graph = Koala::Facebook::GraphAPI.new(oath_token)

    @test_users = Koala::Facebook::TestUsers.new(:app_id => app_id, :app_access_token => app_access_token)
    @test_users.create(true, "offline_access,read_stream")

    # network of 3 test users
    # @test_users.create_network(3, installed_status, permissions)

    session['facebook_token'] = oath_token

    # Log out
    # session['access_token'] = nil

    # @graph.put_like("7204941866_117111188317384")

    # @graph.put_comment("7204941866_117111188317384", "Can't believe Mother's Day's just a week away!  I'd better get on that gift.")

    # <script src="http://connect.facebook.net/en_US/all.js"></script>
    # content_tag("fb:login-button", "Log in", {:scope=>"email"}) 

    # graph API
    # https://developers.facebook.com/docs/reference/api/

    # Koala graph API
    # https://github.com/arsduo/koala/wiki/Graph-API

    # {:scope =>"publish_stream"}    
    # @graph.put_wall_post("hey, i'm learning kaola")

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def app_id
    '285193711555371'
  end

  def app_access_token
    '9d5501e9bda66481fed4c88eaaf28712'
  end

  def omniauth
    @omniauth ||= request.env["omniauth.auth"]
  end

  def oath_token
    omniauth.credentials.token
  end
end