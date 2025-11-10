import 'package:equatable/equatable.dart';

class RandomImageEntity extends Equatable {
  const RandomImageEntity({
    required this.url,
  });

  final String url;

  @override
  List<Object?> get props => [url];
}

