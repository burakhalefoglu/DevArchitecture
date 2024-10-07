import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_state.dart';
import 'bloc_fail_middleware.dart';

class ExtendedBlocConsumer<B extends StateStreamable<S>, S extends BaseState>
    extends StatelessWidget {
  final BlocWidgetBuilder<S> builder;
  final BlocBuilderCondition<S>? buildWhen;
  final BlocWidgetListener<S> listener;
  final BlocListenerCondition<S>? listenWhen;

  const ExtendedBlocConsumer({
    Key? key,
    required this.builder,
    this.buildWhen,
    required this.listener,
    this.listenWhen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<B, S>(
      builder: builder,
      buildWhen: buildWhen,
      listener: (context, state) {
        BlocFailedMiddleware.handleBlocFailed(context, state);
        listener(context, state);
      },
      listenWhen: listenWhen,
    );
  }
}
