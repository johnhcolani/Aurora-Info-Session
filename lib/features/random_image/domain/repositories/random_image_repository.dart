import '../../../../core/resources/data_state.dart';
import '../entities/random_image_entity.dart';

/// Domain repository interface for fetching random images.
abstract class RandomImageRepository {
  Future<DataState<RandomImageEntity>> getRandomImage();
}

