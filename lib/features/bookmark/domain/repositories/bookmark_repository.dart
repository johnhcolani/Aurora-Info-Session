import '../entities/bookmark_entity.dart';

/// Domain contract exposing bookmark operations to the app.
abstract class BookmarkRepository {
  Future<List<BookmarkEntity>> getBookmarks();
  Future<void> addBookmark(String url);
  Future<void> removeBookmark(String url);
  Future<bool> isBookmarked(String url);
}
