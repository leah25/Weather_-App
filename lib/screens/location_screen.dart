import 'package:flutter/material.dart';
import 'package:knowweather/utilities/constants.dart';
import 'package:knowweather/services/weather.dart';
import 'package:knowweather/screens//city_screen.dart';

class LocationScreen extends StatefulWidget {

  final locationWeather;
  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  WeatherModel weatherModel = WeatherModel();
  var weatherIcon;
 var temperature;
  var cityName;
  var message;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);

  }

  void updateUI( dynamic weatherData){
   setState(() {
     if(weatherData == null){
       temperature= 0.0;
       weatherIcon ='Error';
       message = 'unabale to get weather data';
       cityName = 'your city';

       return;
     }else{
       var condition =  weatherData['weather'][0]['id'];
       weatherIcon = weatherModel.getWeatherIcon(condition);
       var temp =  weatherData['main']['temp'];
       temperature = temp.toInt();

       message = weatherModel.getMessage(temperature);
       weatherModel.getMessage(temperature);
       cityName = weatherData['name'];
     }


   });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(

          image: DecorationImage(
            image: AssetImage('images/w10.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 40.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                     var typeName = await Navigator.push(context, MaterialPageRoute(builder: (context)=> CityScreen()));
                     print(typeName);
                     if (typeName != null){
                      var weatherData = await weatherModel.getCityWeather(typeName);
                       updateUI(weatherData);

                     }

                    },
                     child: Icon(
                      Icons.location_city,
                      size: 40.0,
                    ),

                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
