// Todays date in yyyymmdd
String todaysDate() {
  // today
  var dateTime = DateTime.now();

  // year
  String year = dateTime.year.toString();

  //month in mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // day in dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // yyyymmdd format
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

// convert string to datetime obj
DateTime createDateTimeObj(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));

  DateTime dateTimeObj = DateTime(yyyy, mm, dd);
  return dateTimeObj;
}

String convertDateTimeToString(DateTime dateTime){
    // year
  String year = dateTime.year.toString();

  //month in mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // day in dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // yyyymmdd format
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
