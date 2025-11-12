
/// Contract for use cases following the clean architecture pattern.
abstract class UseCase<T, P> {
  Future<T> call(P param);
}

/// Convenience type when a use case does not require parameters.
class NoParams {}