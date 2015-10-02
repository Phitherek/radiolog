class SimpleController < ApplicationController
    def index
        @entries = @user.regular_log_entries
    end

    def logging
        @entries = @user.regular_log_entries.limit(20)
        @new_entry = RegularLogEntry.new
    end

    def create
    end

    def query
    end
end
