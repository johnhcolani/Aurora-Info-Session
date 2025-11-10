import '../../../../core/usecase/use_case.dart';
import '../repositories/bookmark_repository.dart';

class IsBookmarkedUseCase implements UseCase<bool, String> {
  IsBookmarkedUseCase(this._repository);

  final BookmarkRepository _repository;

  @override
  Future<bool> call(String url) {
    return _repository.isBookmarked(url);
  }
}
