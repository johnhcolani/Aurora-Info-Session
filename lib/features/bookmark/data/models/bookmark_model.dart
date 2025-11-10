import '../../domain/entities/bookmark_entity.dart';

class BookmarkModel extends BookmarkEntity {
  BookmarkModel({
    required super.id,
    required super.url,
    required super.createdAt,
  });

  factory BookmarkModel.fromMap(Map<String, dynamic> map) {
    return BookmarkModel(
      id: map['id'] as int,
      url: map['url'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'url': url,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
