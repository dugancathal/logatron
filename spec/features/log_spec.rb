require 'rails_helper'

describe 'Log client' do
  it 'creates projects if they do not exist' do
    post '/projects/my-project/logs', {body: "Imma real fancy log"}

    get '/projects'
    response = JSON.parse(last_response.body)
    expect(response.length).to eq 1
    expect(response[0]).to eq 'my-project'
  end

  it 'stores the logs it recieves' do
    log_time = Time.zone.now
    post '/projects/my-project2/logs', {body: "Imma real fancy log", timestamp: log_time}

    get '/projects/my-project2/logs', format: :json
    response = JSON.parse(last_response.body)
    expect(response.length).to eq 1
    expect(response[0]['body']).to eq 'Imma real fancy log'
    expect(response[0]['created_at']).to be
    expect(response[0]['timestamp']).to eq log_time.to_s(:iso8601)
  end
end
