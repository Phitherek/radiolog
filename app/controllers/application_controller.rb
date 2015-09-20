class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def find_user
        if session['remote_session_token'] != nil
            @session = RemoteSession.find_by_token(session['remote_session_token'])
            if !@session.nil?
                @user = @session.remote_user
                @check = JSON.parse(HTTParty.get("https://rlauth.phitherek.me/api/user_data?access_token=#{@session.token}").body || "{}")
                if @check.include?("status") && @check["status"] == "failure"
                    session['remote_session_token'] = nil
                    redirect_to '/auth/rlauth' and return
                elsif @check.include?("user")
                    @user = RemoteUser.find_by_callsign(@check["user"]["callsign"])
                    if !@user.nil?
                        session['remote_session_token'] = @session.token
                    else
                        session['remote_session_token'] = nil
                    end
                end
            else
                @user = nil
            end
        else
            @user = nil
        end
    end

    def user_only
        redirect_to root_path unless !@user.nil?
    end
end
