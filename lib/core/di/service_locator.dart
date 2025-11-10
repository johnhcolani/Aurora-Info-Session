import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/bookmark/data/datasources/local/bookmark_local_data_source.dart';
import '../../features/bookmark/data/repositories/bookmark_repository_impl.dart';
import '../../features/bookmark/domain/repositories/bookmark_repository.dart';
import '../../features/bookmark/domain/usecases/add_bookmark_usecase.dart';
import '../../features/bookmark/domain/usecases/get_bookmarks_usecase.dart';
import '../../features/bookmark/domain/usecases/is_bookmarked_usecase.dart';
import '../../features/bookmark/domain/usecases/remove_bookmark_usecase.dart';
import '../../features/bookmark/presentation/cubit/bookmark_album_cubit.dart';
import '../../features/random_image/data/datasources/random_image_remote_data_source.dart';
import '../../features/random_image/data/repositories/random_image_repository_impl.dart';
import '../../features/random_image/domain/repositories/random_image_repository.dart';
import '../../features/random_image/domain/usecases/get_random_image_usecase.dart';
import '../../features/random_image/presentation/bloc/random_image_bloc.dart';
import '../../features/theme/presentation/cubit/theme_cubit.dart';
import '../network/dio_client.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setupDependencies() async {
  serviceLocator
    ..registerLazySingleton(DioClient.new)
    ..registerLazySingleton<Dio>(() => serviceLocator<DioClient>().dio)
    ..registerLazySingleton(BookmarkLocalDataSource.new)
    ..registerLazySingleton<BookmarkRepository>(
      () => BookmarkRepositoryImpl(serviceLocator()),
    )
    ..registerLazySingleton(
      () => AddBookmarkUseCase(serviceLocator()),
    )
    ..registerLazySingleton(
      () => RemoveBookmarkUseCase(serviceLocator()),
    )
    ..registerLazySingleton(
      () => IsBookmarkedUseCase(serviceLocator()),
    )
    ..registerLazySingleton(
      () => GetBookmarksUseCase(serviceLocator()),
    )
    ..registerLazySingleton(ThemeCubit.new)
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
      () => RandomImageBloc(
        serviceLocator(),
        addBookmarkUseCase: serviceLocator(),
        removeBookmarkUseCase: serviceLocator(),
        isBookmarkedUseCase: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => BookmarkAlbumCubit(serviceLocator()),
    );
}

