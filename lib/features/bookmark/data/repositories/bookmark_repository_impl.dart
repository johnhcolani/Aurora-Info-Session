import '../../domain/entities/bookmark_entity.dart';
import '../../domain/repositories/bookmark_repository.dart';
import '../datasources/bookmark_local_data_source.dart';

class BookmarkRepositoryImpl implements BookmarkRepository {
  BookmarkRepositoryImpl(this._localDataSource);

  final BookmarkLocalDataSource _localDataSource;

  @override
  Future<void> addBookmark(String url) {
    return _localDataSource.insertBookmark(url);
  }

  @override
  Future<List<BookmarkEntity>> getBookmarks() {
    return _localDataSource.getBookmarks();
  }

  @override
  Future<bool> isBookmarked(String url) {
    return _localDataSource.isBookmarked(url);
  }

  @override
  Future<void> removeBookmark(String url) {
    return _localDataSource.deleteBookmark(url);
  }
}
