defmodule FoodTruck do
  @moduledoc """
  FoodTruck keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  import :math, only: [cos: 1, pow: 2, sin: 1, atan2: 2, sqrt: 1]

  @csv_file_path "priv/repo/data/Mobile_Food_Facility_Permit.csv"

  defstruct [
    :applicant,
    :facility_type,
    :location_description,
    :address,
    :status,
    :food_items,
    :latitude,
    :longitude,
    :schedule,
    :dayshours
  ]

  @doc """
  Retrieves a list of open food trucks that serve the given food type within
  a specified radius around a given location.

  ## Examples

      iex> FoodTruck.search("taco", 37.7749, -122.4194)
      [
        %FoodTruck{
          applicant: "Tacos el Gordo",
          facility_type: "Truck",
          location_description: "19TH ST: MISSOURI ST to CONNECTICUT ST (400 - 499)",
          address: "19TH ST: MISSOURI ST to CONNECTICUT ST (400 - 499)",
          status: "APPROVED",
          food_items: "Tacos: burritos: quesadillas: nachos: tortas: 12 different meats and 5 vegetarian options",
          latitude: 37.7609361326825,
          longitude: -122.396631810402,
          schedule: "https://twitter.com/tacoselgordo11",
          dayshours: "Mo-Su: 11AM-10PM"
        },
        %FoodTruck{
          applicant: "Tacos San Buena",
          facility_type: "Truck",
          location_description: "MARKET ST: 04TH ST to 05TH ST (1100 - 1199)",
          address: "1169 Market St",
          status: "APPROVED",
          food_items: "tacos: burritos: quesadillas: nachos: sodas: water",
          latitude: 37.7773068275507,
          longitude: -122.412596464968,
          schedule: "https://www.tacosanbuena.com/",
          dayshours: "Mo-Fr: 8AM-4PM"
        }
      ]

  The function takes the following parameters:

  * `food_type` - a string representing the type of food to search for.
  * `latitude` - a float representing the latitude of the location to search around.
  * `longitude` - a float representing the longitude of the location to search around.
  * `radius` - an optional float representing the radius in miles around the location to search within. The default value is 5.0.

  The function returns a list of `FoodTruck` struct, each representing an open food truck that serves the given food type and is within the specified radius around the given location. If no food trucks are found, an empty list is returned.
  """
  def search(food_type, latitude, longitude, radius \\ 5.0) do
    File.stream!(@csv_file_path, [:read])
    |> CSV.decode(headers: true)
    |> Stream.filter(fn
      {:ok, %{"Status" => "APPROVED", "FoodItems" => food_items, "Latitude" => lat, "Longitude" => long}} ->
        String.contains?(food_items, food_type) &&
        haversine_distance(parse_to_float(lat), parse_to_float(long), latitude, longitude) <= radius;
      _ -> false
    end)
    |> Stream.map(fn {:ok, %{"Applicant" => applicant, "FacilityType" => facility_type, "LocationDescription" => location_description, "Address" => address, "Status" => status, "FoodItems" => food_items, "Latitude" => latitude, "Longitude" => longitude, "Schedule" => schedule, "dayshours" => dayshours}} ->
      %FoodTruck{
        applicant: applicant,
        facility_type: facility_type,
        location_description: location_description,
        address: address,
        status: status,
        food_items: food_items,
        latitude: latitude,
        longitude: longitude,
        schedule: schedule,
        dayshours: dayshours
      }
    end)
    |> Enum.to_list()
  end

  defp haversine_distance(lat1, lon1, lat2, lon2) do
    earth_radius = 3961
    d_lat = abs(lat2 - lat1) * 0.01745329252
    d_lon = abs(lon2 - lon1) * 0.01745329252
    a = pow(sin(d_lat / 2), 2) + cos(lat1 * 0.01745329252) * cos(lat2 * 0.01745329252) * pow(sin(d_lon / 2), 2)
    c = 2 * atan2(sqrt(a), sqrt(1 - a))
    earth_radius * c
  end

  defp parse_to_float(""), do: 0.0
  defp parse_to_float(x) do
    {x, _} =  Float.parse x
    x
  end
end
