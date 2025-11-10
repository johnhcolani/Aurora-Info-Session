// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'random_image_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RandomImageEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshRequested,
    required TResult Function() bookmarkToggled,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshRequested,
    TResult? Function()? bookmarkToggled,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshRequested,
    TResult Function()? bookmarkToggled,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_BookmarkToggled value) bookmarkToggled,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_BookmarkToggled value)? bookmarkToggled,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_BookmarkToggled value)? bookmarkToggled,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RandomImageEventCopyWith<$Res> {
  factory $RandomImageEventCopyWith(
    RandomImageEvent value,
    $Res Function(RandomImageEvent) then,
  ) = _$RandomImageEventCopyWithImpl<$Res, RandomImageEvent>;
}

/// @nodoc
class _$RandomImageEventCopyWithImpl<$Res, $Val extends RandomImageEvent>
    implements $RandomImageEventCopyWith<$Res> {
  _$RandomImageEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RandomImageEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
    _$StartedImpl value,
    $Res Function(_$StartedImpl) then,
  ) = __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$RandomImageEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
    _$StartedImpl _value,
    $Res Function(_$StartedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RandomImageEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl with DiagnosticableTreeMixin implements _Started {
  const _$StartedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RandomImageEvent.started()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'RandomImageEvent.started'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshRequested,
    required TResult Function() bookmarkToggled,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshRequested,
    TResult? Function()? bookmarkToggled,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshRequested,
    TResult Function()? bookmarkToggled,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_BookmarkToggled value) bookmarkToggled,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_BookmarkToggled value)? bookmarkToggled,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_BookmarkToggled value)? bookmarkToggled,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements RandomImageEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$RefreshRequestedImplCopyWith<$Res> {
  factory _$$RefreshRequestedImplCopyWith(
    _$RefreshRequestedImpl value,
    $Res Function(_$RefreshRequestedImpl) then,
  ) = __$$RefreshRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshRequestedImplCopyWithImpl<$Res>
    extends _$RandomImageEventCopyWithImpl<$Res, _$RefreshRequestedImpl>
    implements _$$RefreshRequestedImplCopyWith<$Res> {
  __$$RefreshRequestedImplCopyWithImpl(
    _$RefreshRequestedImpl _value,
    $Res Function(_$RefreshRequestedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RandomImageEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshRequestedImpl
    with DiagnosticableTreeMixin
    implements _RefreshRequested {
  const _$RefreshRequestedImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RandomImageEvent.refreshRequested()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RandomImageEvent.refreshRequested'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshRequested,
    required TResult Function() bookmarkToggled,
  }) {
    return refreshRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshRequested,
    TResult? Function()? bookmarkToggled,
  }) {
    return refreshRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshRequested,
    TResult Function()? bookmarkToggled,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_BookmarkToggled value) bookmarkToggled,
  }) {
    return refreshRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_BookmarkToggled value)? bookmarkToggled,
  }) {
    return refreshRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_BookmarkToggled value)? bookmarkToggled,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested(this);
    }
    return orElse();
  }
}

abstract class _RefreshRequested implements RandomImageEvent {
  const factory _RefreshRequested() = _$RefreshRequestedImpl;
}

/// @nodoc
abstract class _$$BookmarkToggledImplCopyWith<$Res> {
  factory _$$BookmarkToggledImplCopyWith(
    _$BookmarkToggledImpl value,
    $Res Function(_$BookmarkToggledImpl) then,
  ) = __$$BookmarkToggledImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookmarkToggledImplCopyWithImpl<$Res>
    extends _$RandomImageEventCopyWithImpl<$Res, _$BookmarkToggledImpl>
    implements _$$BookmarkToggledImplCopyWith<$Res> {
  __$$BookmarkToggledImplCopyWithImpl(
    _$BookmarkToggledImpl _value,
    $Res Function(_$BookmarkToggledImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RandomImageEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BookmarkToggledImpl
    with DiagnosticableTreeMixin
    implements _BookmarkToggled {
  const _$BookmarkToggledImpl();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RandomImageEvent.bookmarkToggled()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RandomImageEvent.bookmarkToggled'));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookmarkToggledImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() refreshRequested,
    required TResult Function() bookmarkToggled,
  }) {
    return bookmarkToggled();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? refreshRequested,
    TResult? Function()? bookmarkToggled,
  }) {
    return bookmarkToggled?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? refreshRequested,
    TResult Function()? bookmarkToggled,
    required TResult orElse(),
  }) {
    if (bookmarkToggled != null) {
      return bookmarkToggled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_RefreshRequested value) refreshRequested,
    required TResult Function(_BookmarkToggled value) bookmarkToggled,
  }) {
    return bookmarkToggled(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_RefreshRequested value)? refreshRequested,
    TResult? Function(_BookmarkToggled value)? bookmarkToggled,
  }) {
    return bookmarkToggled?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_RefreshRequested value)? refreshRequested,
    TResult Function(_BookmarkToggled value)? bookmarkToggled,
    required TResult orElse(),
  }) {
    if (bookmarkToggled != null) {
      return bookmarkToggled(this);
    }
    return orElse();
  }
}

abstract class _BookmarkToggled implements RandomImageEvent {
  const factory _BookmarkToggled() = _$BookmarkToggledImpl;
}

/// @nodoc
mixin _$RandomImageState {
  RandomImageStatus get status => throw _privateConstructorUsedError;
  RandomImageEntity? get image => throw _privateConstructorUsedError;
  Color? get backgroundColor => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  bool get isBookmarked => throw _privateConstructorUsedError;

  /// Create a copy of RandomImageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RandomImageStateCopyWith<RandomImageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RandomImageStateCopyWith<$Res> {
  factory $RandomImageStateCopyWith(
    RandomImageState value,
    $Res Function(RandomImageState) then,
  ) = _$RandomImageStateCopyWithImpl<$Res, RandomImageState>;
  @useResult
  $Res call({
    RandomImageStatus status,
    RandomImageEntity? image,
    Color? backgroundColor,
    String? errorMessage,
    bool isBookmarked,
  });
}

/// @nodoc
class _$RandomImageStateCopyWithImpl<$Res, $Val extends RandomImageState>
    implements $RandomImageStateCopyWith<$Res> {
  _$RandomImageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RandomImageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? image = freezed,
    Object? backgroundColor = freezed,
    Object? errorMessage = freezed,
    Object? isBookmarked = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as RandomImageStatus,
            image: freezed == image
                ? _value.image
                : image // ignore: cast_nullable_to_non_nullable
                      as RandomImageEntity?,
            backgroundColor: freezed == backgroundColor
                ? _value.backgroundColor
                : backgroundColor // ignore: cast_nullable_to_non_nullable
                      as Color?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            isBookmarked: null == isBookmarked
                ? _value.isBookmarked
                : isBookmarked // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RandomImageStateImplCopyWith<$Res>
    implements $RandomImageStateCopyWith<$Res> {
  factory _$$RandomImageStateImplCopyWith(
    _$RandomImageStateImpl value,
    $Res Function(_$RandomImageStateImpl) then,
  ) = __$$RandomImageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    RandomImageStatus status,
    RandomImageEntity? image,
    Color? backgroundColor,
    String? errorMessage,
    bool isBookmarked,
  });
}

/// @nodoc
class __$$RandomImageStateImplCopyWithImpl<$Res>
    extends _$RandomImageStateCopyWithImpl<$Res, _$RandomImageStateImpl>
    implements _$$RandomImageStateImplCopyWith<$Res> {
  __$$RandomImageStateImplCopyWithImpl(
    _$RandomImageStateImpl _value,
    $Res Function(_$RandomImageStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RandomImageState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? image = freezed,
    Object? backgroundColor = freezed,
    Object? errorMessage = freezed,
    Object? isBookmarked = null,
  }) {
    return _then(
      _$RandomImageStateImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as RandomImageStatus,
        image: freezed == image
            ? _value.image
            : image // ignore: cast_nullable_to_non_nullable
                  as RandomImageEntity?,
        backgroundColor: freezed == backgroundColor
            ? _value.backgroundColor
            : backgroundColor // ignore: cast_nullable_to_non_nullable
                  as Color?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        isBookmarked: null == isBookmarked
            ? _value.isBookmarked
            : isBookmarked // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$RandomImageStateImpl extends _RandomImageState
    with DiagnosticableTreeMixin {
  const _$RandomImageStateImpl({
    this.status = RandomImageStatus.initial,
    this.image,
    this.backgroundColor,
    this.errorMessage,
    this.isBookmarked = false,
  }) : super._();

  @override
  @JsonKey()
  final RandomImageStatus status;
  @override
  final RandomImageEntity? image;
  @override
  final Color? backgroundColor;
  @override
  final String? errorMessage;
  @override
  @JsonKey()
  final bool isBookmarked;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'RandomImageState(status: $status, image: $image, backgroundColor: $backgroundColor, errorMessage: $errorMessage, isBookmarked: $isBookmarked)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'RandomImageState'))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('backgroundColor', backgroundColor))
      ..add(DiagnosticsProperty('errorMessage', errorMessage))
      ..add(DiagnosticsProperty('isBookmarked', isBookmarked));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RandomImageStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.backgroundColor, backgroundColor) ||
                other.backgroundColor == backgroundColor) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    image,
    backgroundColor,
    errorMessage,
    isBookmarked,
  );

  /// Create a copy of RandomImageState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RandomImageStateImplCopyWith<_$RandomImageStateImpl> get copyWith =>
      __$$RandomImageStateImplCopyWithImpl<_$RandomImageStateImpl>(
        this,
        _$identity,
      );
}

abstract class _RandomImageState extends RandomImageState {
  const factory _RandomImageState({
    final RandomImageStatus status,
    final RandomImageEntity? image,
    final Color? backgroundColor,
    final String? errorMessage,
    final bool isBookmarked,
  }) = _$RandomImageStateImpl;
  const _RandomImageState._() : super._();

  @override
  RandomImageStatus get status;
  @override
  RandomImageEntity? get image;
  @override
  Color? get backgroundColor;
  @override
  String? get errorMessage;
  @override
  bool get isBookmarked;

  /// Create a copy of RandomImageState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RandomImageStateImplCopyWith<_$RandomImageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
