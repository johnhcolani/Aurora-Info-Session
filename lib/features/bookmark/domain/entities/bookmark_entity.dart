class BookmarkEntity {
  const BookmarkEntity({
    required this.id,
    required this.url,
    required this.createdAt,
  });

  final int id;
  final String url;
  final DateTime createdAt;
}
