import '../../../../core/usecase/use_case.dart';
import '../entities/bookmark_entity.dart';
import '../repositories/bookmark_repository.dart';

class GetBookmarksUseCase implements UseCase<List<BookmarkEntity>, NoParams> {
  GetBookmarksUseCase(this._repository);

  final BookmarkRepository _repository;

  @override
  Future<List<BookmarkEntity>> call(NoParams param) {
    return _repository.getBookmarks();
  }
}
