class GlobalConstants {
  static const String baseUrl = 'https://newsapi.org/v2/';

  static const double cardRadius = 16.0;
  static const double screenPadding = 16.0;
  static const double textBoxHeight = 0.13;
  static const double fullWidthBtnHeight = 0.13;

  static final RegExp emailValidatorRegEx =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static const List<String> intToMonthStr = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  static const List<String> intToWeekdayStr = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  static const Map<String, String> toShortWeekdayStr = {
    "Monday": "Mon",
    "Tuesday": "Tues",
    "Wednesday": "Wed",
    "Thursday": "Thurs",
    "Friday": "Fri",
    "Saturday": "Sat",
    "Sunday": "Sun",
  };
}
