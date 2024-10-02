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

class BlocFailed extends BaseState {
  final String message;
  const BlocFailed(this.message);
}

class BlocSuccess<T> extends BaseState {
  final T? result;
  final String? message;
  const BlocSuccess(this.result, {this.message});
}

class BlocAdded extends BlocSuccess {
  const BlocAdded()
      : super(null, message: "Veri Başarılı bir şekilde Eklendi!");
}

class BlocUpdated extends BlocSuccess {
  const BlocUpdated()
      : super(null, message: "Veri Başarılı bir şekilde Güncellendi!");
}

class BlocDeleted extends BlocSuccess {
  const BlocDeleted()
      : super(null, message: "Veri Başarılı bir şekilde silindi!");
}
