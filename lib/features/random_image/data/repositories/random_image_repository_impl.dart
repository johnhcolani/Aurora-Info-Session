import '../../../../core/resources/data_state.dart';
import '../../domain/entities/random_image_entity.dart';
import '../../domain/repositories/random_image_repository.dart';
import '../datasources/random_image_remote_data_source.dart';
import '../models/random_image_model.dart';

/// Repository implementation that fetches random images from remote data source and converts to domain entities.
class RandomImageRepositoryImpl implements RandomImageRepository {
  RandomImageRepositoryImpl(this._remoteDataSource);

  final RandomImageRemoteDataSource _remoteDataSource;

  @override
  Future<DataState<RandomImageEntity>> getRandomImage() async {
    try {
      final response = await _remoteDataSource.getRandomImage();
      if (response.errorMessage != null) {
        return DataFailed(response.errorMessage!);
      }

      final data = response.data;
      if (response.statusCode == 200 && data != null) {
        final model = RandomImageModel.fromJson(data);
        if (model.url.isEmpty) {
          return const DataFailed('Empty image url received.');
        }
        return DataSuccess(model);
      }

      return DataFailed(
        'Unexpected response: ${response.statusCode ?? 'no status code'}',
      );
    } catch (_) {
      return const DataFailed('Unknown error occurred.');
    }
  }
}

