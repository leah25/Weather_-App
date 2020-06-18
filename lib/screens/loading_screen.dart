import 'package:flutter/material.dart';
import 'package:knowweather/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:knowweather/screens/location_screen.dart';



class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}


class _LoadingScreenState extends State<LoadingScreen>{



  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    WeatherModel weather = WeatherModel();
     var weatherData = await weather.getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context)=> LocationScreen(locationWeather: weatherData,)
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.cloud, color: Colors.blue,size: 200),
          SizedBox(height: 60,),
          Text('Know the weather ',style: TextStyle(fontSize: 25.0),),
          Text('of your location...',style: TextStyle(fontSize: 25.0),),
          SizedBox(height: 10,),
          Text('please ensure your phone location button is on :)',style: TextStyle(fontSize: 10.0),),

          SizedBox(height: 60,),
          SpinKitDoubleBounce(
            color: Colors.white,
            size: 100.0,
          ),
        ],


      ),
    );
  }
}
