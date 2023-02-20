https://user-images.githubusercontent.com/20674817/220103494-b756e431-49bb-4b41-b470-baa0879fa79f.mp4

# Food Truck Finder
This is a simple Elixir application that searches for open food trucks in

 San Francisco based on the user's search criteria. The app provides a command-line interface that accepts a few arguments, such as the type of food, the user's location, and the search radius. The app queries a dataset of food trucks in San Francisco to find matching food trucks and displays the results on the console.

### Prerequisites

* Elixir 1.14 or higher
* Erlang/OTP 25 or higher
* Internet connection (to access the data source)

### Installation
1. Clone the repository:
```
git clone https://github.com/utf26/food-truck-finder.git
cd food-truck-finder
```
2. Install dependencies:
```
mix deps.get
```
3. Compile the code:
```
mix compile
```

### Usage
To run the app, use the following command:
```
mix run -e 'FoodTruck.CLI.run([type: "<food_type>", latitude: <latitude>, longitude: <longitude>, radius: <radius>])'
```
Make sure to replace `<food_type>`, `<latitude>`, `<longitude>`, and `<radius>` with the appropriate values for your use case.

For example, the following command searches for open taco trucks within a 5-mile radius of San Francisco:

```
mix run -e 'FoodTruck.CLI.run([type: "taco", latitude: 37.7749, longitude: -122.4194, radius: 10])'
```

Here are some example values you can use for each parameter:

* `food_type`: `"taco"`, `"pizza"`, `"hot dog"`, etc.
* `latitude`: `37.7749`, `42.3601`, `51.5074`, etc.
* `longitude`: `-122.4194`, `-71.0589`, `0.1278`, etc.
* `radius`: `5`, `10`, `20`, etc. (in miles)

Note that the `latitude`, `longitude`, and `radius` parameters are optional. If you do not provide a value for `latitude` and `longitude`, the application will use the default value of `0`. If you do not provide a value for `radius`, the application will use the default value of `10` miles.

### Testing
The app includes a test suite that you can run with the following command:
```
mix test
```

### Deployment
To deploy the app, you can create a release with the following command:
```
mix release
```

This command will generate a release that you can run on any machine with the same operating system and architecture. You can find the release in the `_build` directory. You can run the release with the following command:

```
./_build/<env>/rel/food_truck/bin/food_truck start
```

Replace `<env>` with the environment you're deploying to, such as prod. You can also configure the app by modifying the `config/<env>.exs` file.

### Production
Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).
