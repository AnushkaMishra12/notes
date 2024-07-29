abstract class UiState<T> {
  const UiState();
}

class Success<T> extends UiState<T> {
  final T data;

  const Success(this.data);
}

class Error<T> extends UiState<T> {
  final String msg;

  const Error(this.msg);
}

class Loading<T> extends UiState<T> {
  const Loading();
}

class None<T> extends UiState<T> {
  const None();
}
