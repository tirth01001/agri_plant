import 'dart:convert';
import 'package:agriplant/models/weather_data.dart';
import 'package:agriplant/models/weather_data_current.dart';
import 'package:agriplant/models/weather_data_daily.dart';
import 'package:agriplant/models/weather_data_hourly.dart';
import 'package:agriplant/utils/api_url.dart';
import 'package:http/http.dart' as http;


class FetchWeatherAPI {
  WeatherData? weatherData;

  // Processing the data from response > toJSON
  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString));

    return weatherData!;
  }
}
