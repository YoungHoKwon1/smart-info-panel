import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'airpledemo.g.dart'; //미리 '파일이름'.g.dart 를선언해주고

//flutter pub run build_runner build 를 실행시키면 자동으로 해당 g 파일이 생김
//code 66 뜨면 밑에 코드 순차 실행
//flutter clean
//flutter pub get
//flutter pub run build_runner build
@RestApi(baseUrl: 'http://mqtt.brilcom.com:8080')
abstract class RestAirpleDemo {
  factory RestAirpleDemo(Dio dio, {String baseUrl}) = _RestAirpleDemo;

  @POST('/mqtt/GetAirQuality')
  Future<dynamic> postEnvInfo(
      @Body() FormData formData
      );

}