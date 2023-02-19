defmodule FoodTruck.FoodFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `FoodTruck.Food` context.
  """

  @doc """
  Generate a truck.
  """
  def truck_fixture(attrs \\ %{}) do
    {:ok, truck} =
      attrs
      |> Enum.into(%{
        applicant: "some applicant",
        facility_type: "some facility_type",
        latitude: 120.5,
        location: "some location",
        longitude: 120.5
      })
      |> FoodTruck.Food.create_truck()

    truck
  end
end
