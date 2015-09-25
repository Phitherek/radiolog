class CreateRegularLogEntries < ActiveRecord::Migration
  def change
    create_table :regular_log_entries do |t|
      t.belongs_to :remote_user, null: false
      t.string :to_callsign, null: false
      t.string :rst_from
      t.string :rst_to, null: false
      t.string :name
      t.string :qth
      t.string :qth_locator
      t.timestamp :utc
      t.string :notes
      t.string :freq
      t.string :mod
      t.string :via
      t.string :mode, null: false
      t.string :qsl, null: false, default: "impossible"
      t.timestamps null: false
    end
  end
end
