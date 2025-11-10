import '../../../../core/usecase/use_case.dart';
import '../repositories/bookmark_repository.dart';

class RemoveBookmarkUseCase implements UseCase<void, String> {
  RemoveBookmarkUseCase(this._repository);

  final BookmarkRepository _repository;

  @override
  Future<void> call(String url) {
    return _repository.removeBookmark(url);
  }
}
