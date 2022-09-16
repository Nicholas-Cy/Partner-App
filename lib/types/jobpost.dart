class JobPostCompact {
  const JobPostCompact({
    required this.title,
    required this.postTitle,
    required this.timeAgo,
    required this.unreadNotifications,
  });
  final String title;
  final String postTitle;
  final String timeAgo;
  final int unreadNotifications;
}
