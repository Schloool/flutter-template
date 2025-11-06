sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(String message) = Failure<T>;
  const factory Result.loading() = Loading<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;
  bool get isLoading => this is Loading<T>;

  T? get data => switch (this) {
    Success(:final data) => data,
    _ => null,
  };

  String? get message => switch (this) {
    Failure(:final message) => message,
    _ => null,
  };

  R when<R>({
    required R Function(T data) success,
    required R Function(String message) failure,
    required R Function() loading,
  }) {
    return switch (this) {
      Success(:final data) => success(data),
      Failure(:final message) => failure(message),
      Loading() => loading(),
    };
  }
}

class Success<T> extends Result<T> {
  const Success(this.data);

  @override
  final T data;
}

class Failure<T> extends Result<T> {
  const Failure(this.message);

  @override
  final String message;
}

class Loading<T> extends Result<T> {
  const Loading();
}
