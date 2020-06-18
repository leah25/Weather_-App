import 'package:knowweather/services/location.dart';
import 'package:knowweather/services/networking.dart';


const apiKey = '65d6513749efb4ea477a8c1bb3a9d15d';
class WeatherModel {
  Future <dynamic> getCityWeather(String cityName)async{
    var url = 'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';

    Networking networking = Networking(url: url);

    var weatherData=await networking.getNetworkingData();

    return weatherData;
  }
  Future <dynamic> getLocationWeather() async{

    Location location = Location();
    await location.getCurrentLocation();

    Networking networking = Networking(url:'https://api.openweathermap.org/data/2.5/weather?lat=${location.lattitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networking.getNetworkingData();

    return weatherData;
  }
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp >= 25) {
      return 'It\'s 🍦 time';
    } else if (temp >= 20) {
      return 'Time for shorts and 👕';
    } else if (temp <= 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
