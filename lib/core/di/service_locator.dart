import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/random_image/data/datasources/random_image_remote_data_source.dart';
import '../../features/random_image/data/repositories/random_image_repository_impl.dart';
import '../../features/random_image/domain/repositories/random_image_repository.dart';
import '../../features/random_image/domain/usecases/get_random_image_usecase.dart';
import '../../features/random_image/presentation/bloc/random_image_bloc.dart';
import '../network/dio_client.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setupDependencies() async {
  serviceLocator
    ..registerLazySingleton(DioClient.new)
    ..registerLazySingleton<Dio>(() => serviceLocator<DioClient>().dio)
    ..registerLazySingleton<RandomImageRemoteDataSource>(
      () => RandomImageRemoteDataSourceImpl(serviceLocator()),
    )
    ..registerLazySingleton<RandomImageRepository>(
      () => RandomImageRepositoryImpl(serviceLocator()),
    )
    ..registerLazySingleton(
      () => GetRandomImageUseCase(serviceLocator()),
    )
    ..registerFactory(
      () => RandomImageBloc(serviceLocator()),
    );
}

