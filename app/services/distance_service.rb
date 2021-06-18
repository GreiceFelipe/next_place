class DistanceService

  def initialize(lat1, lat2, lon1, lon2)
    @lat1 = deg2rad(lat1)
    @lat2 = deg2rad(lat2)
    @lon1 = deg2rad(lon1)
    @lon2 = deg2rad(lon2)
  end

  def call 
    dist = (6371 *  calculate_acos)
    (dist * 1.226).round
  end

  private

  def deg2rad(degrees)
    degrees * Math::PI / 180
  end

  def calculate_acos
    Math.acos(calculate_cos + calculate_sin)
  end

  def calculate_cos
    Math.cos(@lat1) * Math.cos(@lat2) * Math.cos(@lon2 - @lon1)
  end

  def calculate_sin
    Math.sin(@lat1) * Math.sin(@lat2)
  end
end