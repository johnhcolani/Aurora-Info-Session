import '../../../../core/usecase/use_case.dart';
import '../repositories/bookmark_repository.dart';

class AddBookmarkUseCase implements UseCase<void, String> {
  AddBookmarkUseCase(this._repository);

  final BookmarkRepository _repository;

  @override
  Future<void> call(String url) {
    return _repository.addBookmark(url);
  }
}
