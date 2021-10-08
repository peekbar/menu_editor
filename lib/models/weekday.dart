import 'package:json_annotation/json_annotation.dart';

enum Weekday {
  @JsonValue('monday')
  monday,
  @JsonValue('tuesday')
  tuesday,
  @JsonValue('wednesday')
  wednesday,
  @JsonValue('thursday')
  thursday,
  @JsonValue('friday')
  friday,
  @JsonValue('saturday')
  saturday,
  @JsonValue('sunday')
  sunday,
}

class WeekdayString {

  static String weekdayToString(Weekday weekday) {
    switch (weekday) {
      case Weekday.monday:
      return 'Monday';
      case Weekday.tuesday:
      return 'Tuesday';
      case Weekday.wednesday:
      return 'Wednesday';
      case Weekday.thursday:
      return 'Thursday';
      case Weekday.friday:
      return 'Friday';
      case Weekday.saturday:
      return 'Saturday';
      case Weekday.sunday:
      return 'Sunday'; 
    }
  }

  static String weekdayListToString(Set<Weekday> weekdayList) {
    String result = '';
    List<Weekday> dayList = [];

    for (var day in Weekday.values) {
      if (weekdayList.contains(day)) {
        dayList.add(day);
      }
    }

    for (var i = 0; i < dayList.length; i++) {
      result = result + weekdayToString(dayList[i]);
      if (i < weekdayList.length - 1) {
        result = '$result, ';
      }
    }
    return result;
  }
}