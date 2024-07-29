import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String toDateString() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    if (isSameDate(today)) {
      return 'Today, ${DateFormat('hh:mm a').format(this)}';
    } else if (isSameDate(yesterday)) {
      return 'Yesterday, ${DateFormat('hh:mm a').format(this)}';
    } else if (year == now.year) {
      return DateFormat('EEE, dd MMM').format(this);
    } else {
      return DateFormat('dd MMM yyyy').format(this);
    }
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

extension DateString on String? {
  String getDateFormat() {
    if (this == null) return 'dd MMM yyyy hh:mm:ss a';
    // Check for ISO 8601 formats
    if (this!.contains('T')) {
      if (this!.contains('Z')) {
        if (this!.contains('.')) {
          if (this!.split('.')[1].length > 3) {
            return "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"; // ISO 8601 with nanoseconds and Zulu time
          }
          return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"; // ISO 8601 with milliseconds and Zulu time
        }
        return "yyyy-MM-dd'T'HH:mm:ss'Z'"; // ISO 8601 with Zulu time
      }
      if (this!.contains('.')) {
        if (this!.split('.')[1].length > 3) {
          return "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"; // ISO 8601 with nanoseconds
        }
        return "yyyy-MM-dd'T'HH:mm:ss.SSS"; // ISO 8601 with milliseconds
      }
      return "yyyy-MM-dd'T'HH:mm:ss"; // ISO 8601 without timezone
    }

    if (this!.contains('/')) {
      if (this!.contains(':')) {
        if (this!.contains('AM') || this!.contains('PM')) {
          if (this!.indexOf('/') == 4) {
            return 'yyyy/MM/dd hh:mm:ss a'; // e.g., 2024/07/13 01:45:30 PM
          }
          if (int.parse(this!.split('/')[0]) <= 12) {
            return 'MM/dd/yyyy  hh:mm:ss a'; // e.g., 07/13/2024 01:45:30 PM
          }
          return 'dd/MM/yyyy  hh:mm:ss a'; // e.g., 13/07/2024 01:45:30 PM
        } else {
          if (this!.indexOf('/') == 4) {
            return 'yyyy/MM/dd HH:mm:ss'; // e.g., 2024/07/13 13:45:30
          }

          if (int.parse(this!.split('/')[0]) <= 12) {
            return 'MM/dd/yyyy HH:mm:ss'; // e.g.,07/13/2024 13:45:30
          }
          return 'dd/MM/yyyy HH:mm:ss'; // e.g., 13/07/2024 13:45:30
        }
      } else {
        if (this!.indexOf('/') == 4) {
          return 'yyyy/MM/dd'; // e.g., 2024/07/13
        }
        if (int.parse(this!.split('/')[0]) <= 12) {
          return 'MM/dd/yyyy'; // e.g., 07/13/2024
        }
        return 'dd/MM/yyyy'; // e.g., 13/07/2024
      }
    }

    // Check for common formats with '-'
    if (this!.contains('-')) {
      if (this!.contains(':')) {
        if (this!.contains('AM') || this!.contains('PM')) {
          if (this!.indexOf('-') == 4) {
            return 'yyyy-MM-dd hh:mm:ss a'; // e.g., 2024-07-13 01:45:30 PM
          }
          if (int.parse(this!.split('-')[0]) <= 12) {
            return 'MM-dd-yyyy  hh:mm:ss a'; // e.g., 07-13-2024 01:45:30 PM
          }
          return 'dd-MM-yyyy  hh:mm:ss a'; // e.g., 13-07-2024 01:45:30 PM
        } else {
          if (this!.indexOf('-') == 4) {
            return 'yyyy-MM-dd HH:mm:ss'; // e.g., 2024-07-13 13:45:30
          }

          if (int.parse(this!.split('-')[0]) <= 12) {
            return 'MM-dd-yyyy HH:mm:ss'; // e.g.,07-13-2024 13:45:30
          }
          return 'dd-MM-yyyy HH:mm:ss'; // e.g., 13-07-2024 13:45:30
        }
      } else {
        if (this!.indexOf('-') == 4) {
          return 'yyyy-MM-dd'; // e.g., 2024-07-13
        }
        if (int.parse(this!.split('-')[0]) <= 12) {
          return 'MM-dd-yyyy'; // e.g., 07-13-2024
        }
        return 'dd-MM-yyyy'; // e.g., 13-07-2024
      }
    }

    // Check for formats with space
    if (this!.split(' ')[1].length == 3) {
      if (this!.contains(':')) {
        if (this!.contains('AM') || this!.contains('PM')) {
          return 'dd MMM yyyy hh:mm:ss a'; // e.g., 11 Jul 2024 01:45:30 PM
        }
        return 'dd MMM yyyy HH:mm:ss'; // e.g., 11 Jul 2024 13:45:30
      }
      return 'dd MMM yyyy'; // e.g., 11 Jul 2024
    }

    throw FormatException('Unknown date format: $this');
  }

  DateTime? toDateTime({String? format}) {
    if (this == null) {
      return null;
    }
    // Parse the IST date string to a DateTime object
    final dateFormat = DateFormat(format ?? getDateFormat());
    final istDateTime = dateFormat.parse(this!);

    return istDateTime;
  }
}
