class HelperController < ApplicationController
    def get_current_utc
        time = Time.now.utc
        sdate = time.to_date
        sftime = format_time(time)
        render json: { utc: {time: time.to_s, date: sdate.to_s, ftime: sftime.to_s} }
    end
end
