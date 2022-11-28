import 'package:flutter/material.dart';

class EnvDataProvider with ChangeNotifier {


  var _sensorTemperature = "22";
  var _sensorHumidity = '52';
  var _sensorPm25 = '11.8';
  var _sensorPm10 = '11.2';
  var _sensorCo2 = '1561.8';

  Color _weatherFontColorReal = Color(0xffc45d1a);
  Color _weatherDataFontColorReal = Color(0xffc45d1a);

  String _weather_assets = 'assets/airple_weather/sunny.jpg';

  Color get weatherFontColorReal => _weatherFontColorReal;

  get sensorTemperature => _sensorTemperature;

  get sensorHumidity => _sensorHumidity;

  get sensorPm25 => _sensorPm25;

  get sensorPm10 => _sensorPm10;

  get sensorCo2 => _sensorCo2;

  void updateData(var sensorTemperature,
  var sensorHumidity,
  var sensorPm25 ,
  var sensorPm10,
  var sensorCo2,
  Color weatherFontColorReal,
  Color weatherDataFontColorReal,
  String weather_assets,) {
    _sensorTemperature = sensorTemperature;
    _sensorHumidity = sensorHumidity;
    _sensorPm25= sensorPm25;
    _sensorPm10= sensorPm10;
    _sensorCo2= sensorCo2;
    _weatherFontColorReal = weatherFontColorReal;
    _weatherDataFontColorReal = weatherDataFontColorReal;
    _weather_assets = weather_assets;
    print("Env Data Upate");
    notifyListeners();
  }

  Color get weatherDataFontColorReal => _weatherDataFontColorReal;

  String get weather_assets => _weather_assets;

}