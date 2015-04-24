class LogsController < ApplicationController
  respond_to :html, :json
  def index
    @project = Project.find_by(name: params[:project_id]) || Project.new
    @logs = @project.logs
    respond_with @logs
  end

  def create
    project = Project.where(name: params[:project_id]).first_or_create
    log = project.logs.create(body: params[:body], timestamp: params[:timestamp])
    HTTParty.post('http://localhost:9292/faye', body: {
      message: {
        channel: "/projects/#{project.name}",
        data: {
          body: log.body,
          timestamp: log.timestamp.to_s(:iso8601)
        }
      }.to_json
    })
    respond_with log, location: [project, log]
  end
end
