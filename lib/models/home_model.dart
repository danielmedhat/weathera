class HomeModel {
  String? message;
  List<WeatherModel> weather = [];
  HomeModel.fromJson(Map<String, dynamic> json) {
    json['weather'].forEach((element) {
      weather.add(WeatherModel.fromJson(element));
    });
    message = json['message'];
  }
}

class WeatherModel {
  late String main;
  late String icon;
  WeatherModel.fromJson(Map<String, dynamic> json) {
    main = json['description'];
    icon = json['icon'];
  }
}
