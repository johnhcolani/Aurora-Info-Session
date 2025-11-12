import '../../../../core/usecase/use_case.dart';
import '../repositories/bookmark_repository.dart';

/// Use case for removing a bookmark by URL.
class RemoveBookmarkUseCase implements UseCase<void, String> {
  RemoveBookmarkUseCase(this._repository);

  final BookmarkRepository _repository;

  @override
  Future<void> call(String url) {
    return _repository.removeBookmark(url);
  }
}
