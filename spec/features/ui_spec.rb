require 'rails_helper'

describe 'Log UI' do
  it 'show the created logs' do
    log_time = Time.zone.now
    post '/projects/another-project/logs', body: 'A real nice log', timestamp: log_time

    visit '/another-project/logs'
    within 'table#logs' do
      expect(page).to have_content('A real nice log')
      expect(page).to have_content(log_time.to_s(:iso8601))
    end
  end

  it 'updates as soon as I send it', js: true do
    post '/projects', {name: 'another-project'}
    visit '/another-project/logs'

    log_time = Time.zone.now
    post '/projects/another-project/logs', body: 'A real nice log', timestamp: log_time

    within 'table#logs' do
      expect(page).to have_content('A real nice log')
      expect(page).to have_content(log_time.to_s(:iso8601).gsub(/\d\dZ/, ''))
    end
  end
end
