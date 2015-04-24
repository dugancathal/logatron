class Log < ActiveRecord::Base
  belongs_to :project

  before_save do
    self.timestamp ||= Time.zone.now
  end

  def as_json(options={})
    {
      body: body,
      timestamp: timestamp.to_s(:iso8601),
      created_at: created_at,
    }
  end
end
