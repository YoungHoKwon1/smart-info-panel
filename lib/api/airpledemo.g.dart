// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'airpledemo.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestAirpleDemo implements RestAirpleDemo {
  _RestAirpleDemo(this._dio, {this.baseUrl}) {
    baseUrl ??= 'http://mqtt.brilcom.com:8080';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<dynamic> postEnvInfo(formData) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = formData;
    final _result = await _dio.fetch(_setStreamType<dynamic>(
        Options(method: 'POST', headers: _headers, extra: _extra)
            .compose(_dio.options, '/mqtt/GetAirQuality',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data;
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
