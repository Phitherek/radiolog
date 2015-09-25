class RegularLogEntry < ActiveRecord::Base
    validates :remote_user_id, presence: true
    validates :to_callsign, presence: true, format: { with: /\A[A-Z]{2}[0-9]+[A-Z]+\z/ }
    validates :rst_from, format: { with: /\A[1-5][0-9]?[1-9]?\z/, allow_blank: true }
    validates :rst_to, format: { with: /\A[1-5][0-9]?[1-9]?\z/, allow_blank: true }
    validates :qth_locator, format: { with: /\A[A-Z]{2}[0-9]{2}[a-z]{2}\z/, allow_blank: true }
    validates :mod, inclusion: { in: %w(FM AM CW SSB), allow_blank: true }
    validates :qsl, presence: true, inclusion: { in: %w(yes no impossible) }

    belongs_to :remote_user

    default_scope { order(utc: :desc) }
    scope :for_callsign, ->(q) { where(to_callsign: q.to_s.upcase)}
    scope :from_utc, ->(q) { where("utc >= '#{q}''")}
    scope :to_utc, ->(q) { where("utc <= '#{q}'")}
end
