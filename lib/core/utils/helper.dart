class HelperFunctions {
  static String formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Visited today';
    } else if (difference.inDays == 1) {
      return 'Visited yesterday';
    } else if (difference.inDays < 7) {
      return 'Visited ${difference.inDays} days ago';
    } else {
      // Format as "Jan 15, 2024"
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return 'Visited ${months[date.month - 1]} ${date.day}, ${date.year}';
    }
  }
}
