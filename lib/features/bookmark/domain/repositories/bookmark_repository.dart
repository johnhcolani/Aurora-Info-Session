import '../entities/bookmark_entity.dart';

abstract class BookmarkRepository {
  Future<List<BookmarkEntity>> getBookmarks();
  Future<void> addBookmark(String url);
  Future<void> removeBookmark(String url);
  Future<bool> isBookmarked(String url);
}
