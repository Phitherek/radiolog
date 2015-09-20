class GeneralController < ApplicationController

    skip_before_filter :user_only, only: [:index, :omniauth_callback]

    def index
        unless @user.nil?
            redirect_to modes_path
        end
    end

    def modes

    end

    def omniauth_callback
        if !auth_hash.nil?
            @user = RemoteUser.find_by_callsign(auth_hash.info.callsign)
            if @user.nil?
                @user = RemoteUser.create(callsign: auth_hash.info.callsign, email: auth_hash.info.email)
                @user.reload
            end
            @session = RemoteSession.new
            @session.token = auth_hash.credentials.token
            @session.token_expires = Time.at(auth_hash.credentials.expires_at)
            @session.refresh_token = auth_hash.credentials.refresh_token
            @session.remote_user = @user
            @session.save!
            @user.save!
            session['remote_session_token'] = @session.token
        end
        redirect_to root_path
    end

    def logout
        HTTParty.post("https://rlauth.phitherek.me/oauth/revoke?token=#{@session.token}")
        @session.destroy
        session.delete('remote_session_token')
        redirect_to root_path
    end

    private

    def auth_hash
        request.env['omniauth.auth']
    end
end
