enum TimeInterval { today, yesterday, week, month, year, alltime }

String timeIntervalInStringFormat(TimeInterval timeInterval) {
  switch (timeInterval) {
    case TimeInterval.today:
      return 'Today';
    case TimeInterval.yesterday:
      return 'Yesterday';
    case TimeInterval.week:
      return 'This Week';
    case TimeInterval.month:
      return 'This Month';
    case TimeInterval.year:
      return 'This Year';
    case TimeInterval.alltime:
      return 'All Time';
  }
}
