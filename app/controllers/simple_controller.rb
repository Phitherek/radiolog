require 'date'

class SimpleController < ApplicationController
    def index
        @entries = @user.regular_log_entries
    end

    def logging
        @entries = @user.regular_log_entries.limit(20)
        @new_entry = RegularLogEntry.new
    end

    def create
        params[:regular_log_entry][:remote_user_id] = @user.id
        params[:regular_log_entry][:mode] = "simple"
        utc = DateTime.parse(params[:utc_date] + " " + params[:utc_time])
        params[:regular_log_entry][:utc] = utc
        @to_user = RemoteUser.find_by_callsign(params[:regular_log_entry][:to_callsign])
        if @to_user.nil?
            params[:regular_log_entry][:qsl] = "impossible"
        else
            @other_entry = @to_user.regular_log_entries.for_callsign(@user.callsign).from_utc(utc-5.minutes).to_utc(utc+5.minutes).first
            if @other_entry != nil
                if @other_entry.rst_from == params[:regular_log_entry][:rst_to] && @other_entry.rst_to == params[:regular_log_entry][:rst_from]
                    params[:regular_log_entry][:qsl] = "yes"
                    @other_entry.qsl = "yes"
                    @other_entry.save!
                else
                    params[:regular_log_entry][:qsl] = "no"
                end
            else
                params[:regular_log_entry][:qsl] = "no"
            end
        end
        @entry = RegularLogEntry.create(entry_params)
        if @entry.new_record?
            flash[:error] = t("flashes.errors.entry_create") + " " + @entry.errors.full_messages.join(", ")
        else
            flash[:success] = t("flashes.successes.entry_create")
            @entries = @user.regular_log_entries.limit(20)
        end
    end

    def query
    end

    private

    def entry_params
        params.require(:regular_log_entry).permit(:to_callsign, :rst_from, :rst_to, :name, :qth, :utc, :remote_user_id, :mode, :qsl)
    end
end
