defmodule FoodTruck.CLI do
  @moduledoc """
This module provides a command-line interface for searching for food trucks.

It uses the `FoodTruck.search/4` function to query the dataset of
food trucks in San Francisco, and prints out a list of matching food trucks to
the console.

## Example usage:

`$ elixir food_truck.exs type:taco latitude:37.7749 longitude:-122.4194 radius:10`
"""

  @doc """
  Runs the command-line interface for searching for food trucks.

  ## Arguments
  * `args` - A list of key-value pairs representing the command-line arguments.

  ## Example
  `FoodTruck.CLI.run([type: "taco", latitude: 37.7749, longitude: -122.4194, radius: 10])`

  """
  def run([type: food_type, latitude: latitude, longitude: longitude, radius: radius]),
      do: search(food_type, latitude, longitude, radius)
  def run([type: food_type, latitude: latitude, longitude: longitude]),
      do: search(food_type, latitude, longitude, 10)
  def run([type: food_type, latitude: latitude]),
      do: search(food_type, latitude, 0, 10)
  def run([type: food_type]),
      do: search(food_type, 0, 0, 10)
  def run(_), do: show_help()

  defp search(food_type, latitude, longitude, radius) do
    matching_trucks = FoodTruck.search(food_type, latitude, longitude, radius)

    if Enum.empty?(matching_trucks) do
      IO.puts("No food trucks found for '#{food_type}'.")
    else
      IO.puts("Food trucks found for '#{food_type}':")
      Enum.each(matching_trucks, fn truck ->
        IO.puts("#{truck.applicant} at #{truck.address}")
      end)
    end
  end

  defp show_help() do
    IO.puts("Usage: type: <food_type> latitude: <latitude> longitude: <longitude> radius: <radius>")
  end
end
