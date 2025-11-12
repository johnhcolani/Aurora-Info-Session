
/// Base sealed-like class representing either success or failure results.
abstract class DataState<T> {
  final T? data;
  final String? error;

  const DataState(this.data, this.error);
}

/// Wraps successful responses with optional payload.
class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T? data) : super(data, null);
}

/// Wraps failure responses with the error message.
class DataFailed<T> extends DataState<T> {
  const DataFailed(String error) : super(null, error);
}