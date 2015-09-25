class SimpleController < ApplicationController
    def index
        @entries = @user.regular_log_entries
    end

    def logging
    end
end
