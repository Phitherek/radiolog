class RemoteUser < ActiveRecord::Base
    validates :callsign, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true

    scope :like, -> (q) { where("UPPER(callsign) LIKE UPPER('%#{q}%')") }

    has_many :remote_sessions
end
