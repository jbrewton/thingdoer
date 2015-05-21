class SessionsController < ApplicationController

  def new
    redirect_to '/users/auth/bitbucket'
  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'],
                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
    reset_session
    session[:user_id] = user.id
    session[:access_token] = auth["extra"]["access_token"]
    redirect_to root_url, :notice => 'Signed in!'
  end

  def destroy
    reset_session
    Task.destroy_all
    if Dir['/tmp/tasklistapp/TaskListApp/tasklist.txt']
      FileUtils.rm('/tmp/tasklistapp/TaskListApp/tasklist.txt')
    end
    sign_out
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end