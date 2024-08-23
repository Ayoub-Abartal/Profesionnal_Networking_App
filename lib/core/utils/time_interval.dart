/// This class has from/to attributes to mage the from/to date picker
class TimeInterval {
  /// The month of the interval
  String fromMonth = 'January', toMonth = 'January';

  /// The year of the interval
  int fromYear = DateTime.now().year, toYear = DateTime.now().year;

  /// Returns the 'from' date as a string with the month and year
  String getFromDate() {
    return "$fromMonth $fromYear";
  }

  /// Returns the 'to' date as a string with the month and the year
  String getToDate() {
    return "$toMonth $toYear";
  }
}
