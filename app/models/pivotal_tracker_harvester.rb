class PivotalTrackerHarvester

  def label_array(current_user_token)
    array = []
    current_user_token[:labels].each do |label|
      array << label[:name]
    end
  end

end
