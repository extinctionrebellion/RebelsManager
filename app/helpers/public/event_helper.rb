module Public::EventHelper
  def params_for_events
    request.params.slice("local_group_id", "scope")
  end
end
