import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/temp/screen_element_constants.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_consumer_extension.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../../../core/constants/temp/messages.dart';
import '../../../../core/di/core_initializer.dart';
import '../../user_claims/bloc/user_claim_cubit.dart';
import '../../user_claims/widgets/user_claim_auto_complete.dart';

class ChangeUserClaimsDialog extends StatefulWidget {
  final int userId;

  const ChangeUserClaimsDialog({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _ChangeUserClaimsDialogState createState() => _ChangeUserClaimsDialogState();
}

class _ChangeUserClaimsDialogState extends State<ChangeUserClaimsDialog> {
  List<int> _selectedClaims = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserClaimCubit(),
      child: ExtendedBlocConsumer<UserClaimCubit, BaseState>(
        builder: (context, state) {
          if (state is BlocInitial) {
            BlocProvider.of<UserClaimCubit>(context).getUserClaimsByUserId(
              widget.userId,
            );
          }
          var resultWidget = getResultWidgetByState(context, state);
          if (resultWidget != null) {
            return resultWidget;
          }

          return AlertDialog(
            title: Text(ScreenElementConstants.updateUserClaims),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: UserClaimAutocomplete(
                userId: widget.userId,
                onChanged: (selectedClaims) {
                  setState(() {
                    _selectedClaims = selectedClaims;
                  });
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(ScreenElementConstants.cancelButton),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_selectedClaims.isNotEmpty) {
                    BlocProvider.of<UserClaimCubit>(context)
                        .saveUserClaimsByUserId(widget.userId, _selectedClaims);
                    Navigator.of(context).pop();
                  } else {
                    CoreInitializer()
                        .coreContainer
                        .screenMessage
                        .getErrorMessage(Messages.atLeastOneSelection);
                  }
                },
                child: Text(ScreenElementConstants.saveButton),
              ),
            ],
          );
        },
      ),
    );
  }
}