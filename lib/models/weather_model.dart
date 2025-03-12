class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final int humidity;
  final String icon;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json["name"],
      temperature: json["main"]["temp"].toDouble(),
      description: json["weather"][0]["description"],
      humidity: json["main"]["humidity"],
      icon: json["weather"][0]["icon"],
    );
  }

  String get LocalImage {
    switch (icon) {
      case "01d":
        return "assets/images/01d.png";
      case "02d":
        return "assets/images/02d.png";
      case "03d":
        return "assets/images/03d.png";
      case "04d":
      case "04n":
        return "assets/images/04d.png";
      case "09d":
      case "09n":
        return "assets/images/09d.png";
      case "10d":
      case "10n":
        return "assets/images/10d.png";
      case "11d":
      case "11n":
        return "assets/images/11d.png";
      case "13d":
      case "13n":
        return "assets/images/13d.png";
      case "50d":
      case "50n":
        return "assets/images/50d.png";
      default:
        return "assets/images/10d.png";
    }
  }
}
