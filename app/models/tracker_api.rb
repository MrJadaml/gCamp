class TrackerAPI

  def initialize
    @connection = Faraday.new(:url => 'https://www.pivotaltracker.com')
  end

  def projects(tracker_token)
    return [] if tracker_token.nil?
    response = @connection.get do |req|
      req.url "/services/v5/projects"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = tracker_token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def project(tracker_token, id)
    return [] if tracker_token.nil?
    response = @connection.get do |req|
      req.url "/services/v5/projects/#{id}"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = tracker_token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def stories(tracker_token, id)
    return [] if tracker_token.nil?
    response = @connection.get do |req|
      req.url "/services/v5/projects/#{id}/stories?limit=500"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = tracker_token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def unstarted(tracker_token, id)
    return [] if tracker_token.nil?
    response = @connection.get do |req|
      req.url "/services/v5/projects/#{id}/stories?with_state=unstarted"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = tracker_token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def rejected(tracker_token, id)
    return [] if tracker_token.nil?
    response = @connection.get do |req|
      req.url "/services/v5/projects/#{id}/stories?with_state=rejected"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = tracker_token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def token_filter(tracker_token)
    tracker_token[0..3] + tracker_token.from(4).gsub(/./,'*')
  end

end
