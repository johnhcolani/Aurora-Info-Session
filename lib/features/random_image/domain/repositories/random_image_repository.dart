import '../../../../core/resources/data_state.dart';
import '../entities/random_image_entity.dart';

abstract class RandomImageRepository {
  Future<DataState<RandomImageEntity>> getRandomImage();
}

