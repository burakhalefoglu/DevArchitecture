import '../di/core_initializer.dart';
import 'base_state.dart';

void showScreenMessageByBlocStatus(BaseState state) {
  if (state is BlocFailed) {
    CoreInitializer()
        .coreContainer
        .screenMessage
        .getErrorMessage(state.message);
  }
  if (state is BlocChecking) {
    CoreInitializer().coreContainer.screenMessage.getInfoMessage(state.message);
  }
  if (state is BlocSending) {
    CoreInitializer().coreContainer.screenMessage.getInfoMessage(state.message);
  }
  if (state is BlocLoading) {
    CoreInitializer().coreContainer.screenMessage.getInfoMessage(state.message);
  }
  if (state is BlocAdded) {
    CoreInitializer()
        .coreContainer
        .screenMessage
        .getSuccessMessage(state.message!);
  }
  if (state is BlocUpdated) {
    CoreInitializer()
        .coreContainer
        .screenMessage
        .getSuccessMessage(state.message!);
  }
  if (state is BlocDeleted) {
    CoreInitializer()
        .coreContainer
        .screenMessage
        .getWarningMessage(state.message!);
  }
}
