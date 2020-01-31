class GeocodeRebelJob < ActiveJob::Base
  queue_as :default

  def perform(rebel)
    position = Geocoder.search("#{rebel.postcode}", params: { countrycodes: ENV['NOMINATIM_COUNTRY_CODE'] })&.first
    if !position.nil?
      rebel.update_column(:lat, position.data['lat']&.to_d)
      rebel.update_column(:lon, position.data['lon']&.to_d)
    end
  end
end
