/// DateTime 扩展

extension DYDateTimeExtension on DateTime {
  /// 本日 凌晨零点
  DateTime get amZeroInDay {
    return DateTime(year, month, day);
  }

  /// 本周周一 零点
  DateTime get amZeroInMonday {
    return DateTime(year, month, day).subtract(Duration(days: weekday - 1));
  }

  /// 本月1号 零点
  DateTime get amZeroInMonth {
    return DateTime(year, month, 1);
  }

  /// 本年1月1号 零点
  DateTime get amZeroInYear {
    return DateTime(year, 1, 1);
  }

  static String formatWithSeconds(int seconds) {
    final minutes = seconds ~/ 60;
    final restSeconds = seconds % 60;

    String minutesString;
    String restSecondsString;
    if (minutes < 10) {
      minutesString = "0" + "$minutes";
    } else {
      minutesString = "$minutes";
    }

    if (restSeconds < 10) {
      restSecondsString = "0" + "$restSeconds";
    } else {
      restSecondsString = "$restSeconds";
    }

    return minutesString + ":" + restSecondsString;
  }

  static String formatWithMillSeconds(int millSeconds) {
    final seconds = millSeconds / 1000;
    final minutes = seconds ~/ 60;
    final restSeconds = (seconds % 60).toInt();

    String minutesString;
    String restSecondsString;
    if (minutes < 10) {
      minutesString = "0" + "$minutes";
    } else {
      minutesString = "$minutes";
    }

    if (restSeconds < 10) {
      restSecondsString = "0" + "$restSeconds";
    } else {
      restSecondsString = "$restSeconds";
    }

    return minutesString + ":" + restSecondsString;
  }
}
