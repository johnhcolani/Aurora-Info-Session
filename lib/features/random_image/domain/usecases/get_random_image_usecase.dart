import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/random_image_entity.dart';
import '../repositories/random_image_repository.dart';

/// Use case for fetching a random image from the repository.
class GetRandomImageUseCase
    implements UseCase<DataState<RandomImageEntity>, NoParams> {
  GetRandomImageUseCase(this._repository);

  final RandomImageRepository _repository;

  @override
  Future<DataState<RandomImageEntity>> call(NoParams param) {
    return _repository.getRandomImage();
  }
}

