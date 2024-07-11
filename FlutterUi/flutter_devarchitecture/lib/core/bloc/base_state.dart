abstract class BaseState {
  const BaseState();
}

class BlocInitial extends BaseState {
  const BlocInitial();
}

class BlocLoading extends BaseState {
  final String message;
  BlocLoading(this.message);
}

class BlocChecking extends BaseState {
  final String message;
  BlocChecking(this.message);
}

class BlocSending extends BaseState {
  final String message;
  BlocSending(this.message);
}

class BlocSuccess<T> extends BaseState {
  final T? result;
  const BlocSuccess(this.result);
}

class BlocFailed extends BaseState {
  final String message;
  const BlocFailed(this.message);
}
