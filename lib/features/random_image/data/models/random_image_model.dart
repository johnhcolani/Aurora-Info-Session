import '../../domain/entities/random_image_entity.dart';

/// Data model for random images, extending the domain entity with JSON serialization.
class RandomImageModel extends RandomImageEntity {
  const RandomImageModel({
    required super.url,
  });

  factory RandomImageModel.fromJson(Map<String, dynamic> json) {
    return RandomImageModel(
      url: json['url'] as String? ?? '',
    );
  }
}

